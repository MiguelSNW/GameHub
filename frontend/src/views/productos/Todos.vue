<template>
  <div class="max-w-full flex bg-gray-900 min-h-screen text-white">
    
    <!-- 🔍 Panel izquierdo: Búsqueda y filtros -->
    <aside class="w-full md:w-1/4 border-r border-indigo-500 rounded-l px-6 py-10 bg-gray-900">
      
      <!-- Buscador -->
      <div ref="buscadorRef" class="mb-8">
        <input
          v-model="terminoBusqueda"
          @input="buscarEnTiempoReal"
          @keyup.enter="irABusqueda"
          type="text"
          placeholder="🔍 Busca tu próximo juego favorito..."
          class="w-full px-5 py-3 rounded-full bg-gray-800 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-violet-600 shadow-md transition"
        />
      </div>

      <!-- Filtro de precio -->
      <div class="mb-6">
        <label class="block text-sm font-medium mb-1 text-white">Precio máximo:</label>
        <div class="flex items-center">
          <input
            v-model.number="maxPrice"
            type="range"
            min="0"
            :max="maxLimit"
            step="10"
            class="accent-indigo-500 flex-1"
          />
          <span class="ml-4 font-semibold text-white">{{ maxPrice }}€</span>
        </div>
      </div>

      <!-- Filtro por plataforma -->
      <div class="mb-6">
        <h2 class="font-semibold mb-2 text-violet-500 text-lg">Filtrar por plataforma:</h2>
        <div class="flex flex-col space-y-2">
          <label
            v-for="plataforma in plataformas"
            :key="plataforma.plataforma_id"
            class="flex items-center text-sm text-white"
          >
            <input
              type="checkbox"
              :value="plataforma.plataforma_id"
              v-model="plataformasSeleccionadas"
              class="accent-indigo-500 mr-2"
            />
            {{ plataforma.plataforma }}
          </label>
        </div>
      </div>
    </aside>

    <!-- 🎮 Panel derecho: Resultados de productos -->
    <section class="w-full md:w-3/4 px-6 py-10">
      <div class="border border-indigo-500 bg-gray-900 rounded-r px-6 py-10 shadow-md">
        
        <!-- Cargando -->
        <template v-if="isLoading">
          <LoadingScreen />
        </template>

        <!-- Resultados -->
        <template v-else>
          <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 gap-4">
            <router-link
              v-for="producto in productosPaginados"
              :key="producto.id"
              :to="`/producto/${producto.id}`"
              class="block"
            >
              <div class="bg-white p-3 rounded shadow hover:shadow-lg transition-transform transform hover:-translate-y-1 h-[300px] flex flex-col justify-between">
                <img
                  :src="`/${producto.imagen}`"
                  alt="Carátula del juego"
                  class="h-[160px] w-full object-contain mb-2 rounded"
                />
                <h3 class="text-base font-semibold truncate text-violet-700">
                  {{ producto.nombre }}
                </h3>
                <p class="text-gray-700 text-sm">{{ producto.precio }}€</p>
              </div>
            </router-link>
          </div>

          <!-- 🔢 Paginación -->
          <div class="flex justify-center mt-8 space-x-2">
            <button
              @click="cambiarPagina(paginaActual - 1)"
              :disabled="paginaActual === 1"
              class="px-4 py-2 bg-violet-700 hover:bg-violet-800 rounded disabled:opacity-50"
            >
              <
            </button>


            <button
              @click="cambiarPagina(paginaActual + 1)"
              :disabled="paginaActual === totalPaginas"
              class="px-4 py-2 bg-violet-700 hover:bg-violet-800 rounded disabled:opacity-50"
            >
              >
            </button>
          </div>
        </template>
      </div>
    </section>

  </div>
</template>



<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'
import LoadingScreen from '@/components/LoadingScreen.vue'
import { watch } from 'vue'

// Variables reactivas
const resultados = ref([])
const isLoading = ref(true)

// Búsqueda por nombre
const terminoBusqueda = ref('')

// Límite de precio
const maxLimit = 700
const maxPrice = ref(maxLimit)

// Router para navegación en "enter"
const router = useRouter()

// Computed para filtrar por término y precio
const resultadosFiltrados = computed(() => {
  return resultados.value
    .filter(p => p.precio <= maxPrice.value)
    .filter(p => p.nombre.toLowerCase().includes(terminoBusqueda.value.trim().toLowerCase()))
    .filter(p => {
      // Si no hay plataformas seleccionadas, no filtrar por plataforma
      if (plataformasSeleccionadas.value.length === 0) return true
      return plataformasSeleccionadas.value.includes(p.plataforma_id)
    })
})


// Funciones vinculadas al input
const buscarEnTiempoReal = () => {
  // Con v-model y computed, el filtrado ya es reactivo.
}

const irABusqueda = () => {
  if (terminoBusqueda.value.trim()) {
    router.push({ name: 'Busqueda', query: { q: terminoBusqueda.value.trim() } })
  }
}

// Carga de productos
const obtenerProductos = async () => {
  try {
    const res = await axios.get(`/productos`)
    resultados.value = res.data
  } catch (error) {
    console.error('Error al obtener productos:', error)
  }
}

const plataformas = ref([])
const plataformasSeleccionadas = ref([]) // array de ids seleccionados

// Cargar plataformas desde la API
const obtenerPlataformas = async () => {
  try {
    const res = await axios.get('/plataforma')
    plataformas.value = res.data
  } catch (error) {
    console.error('Error al cargar plataformas:', error)
  }
}

onMounted(() => {
   obtenerProductos()
  obtenerPlataformas()
  setTimeout(() => {
    isLoading.value = false
  }, 4000)
})

const paginaActual = ref(1)
const productosPorPagina = 12

const totalPaginas = computed(() =>
  Math.ceil(resultadosFiltrados.value.length / productosPorPagina)
)

const productosPaginados = computed(() => {
  const inicio = (paginaActual.value - 1) * productosPorPagina
  const fin = inicio + productosPorPagina
  return resultadosFiltrados.value.slice(inicio, fin)
})

const cambiarPagina = (nuevaPagina) => {
  if (nuevaPagina >= 1 && nuevaPagina <= totalPaginas.value) {
    paginaActual.value = nuevaPagina
  }
}
// Resetear a página 1 cuando cambia la búsqueda o filtros
watch([terminoBusqueda, maxPrice, plataformasSeleccionadas], () => {
  paginaActual.value = 1
})
</script>

<style scoped>
/* Ajusta estilos adicionales según necesites */
</style>

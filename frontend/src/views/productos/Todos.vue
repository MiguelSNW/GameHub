<template>
  <div class="max-w-full flex">
    <!-- Parte izquierda: Búsqueda y filtro de precios -->
    <div class="w-full md:w-1/4 border-r border-indigo-500 rounded-l px-4 py-8 pt-12">
      <div ref="buscadorRef" class="relative w-full mb-6 z-0">
        <input
          v-model="terminoBusqueda"
          @input="buscarEnTiempoReal"
          @keyup.enter="irABusqueda"
          type="text"
          placeholder="🔍 Busca tu próximo juego favorito..."
          class="w-full px-5 py-3 rounded-full bg-gray-800 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-violet-600 shadow-md transition"
        />
      </div>
      <div class="mb-4 flex items-center">
        <input
          v-model.number="maxPrice"
          type="range"
          min="0"
          :max="maxLimit"
          step="10"
          class="accent-indigo-500 flex-1"
        />
        <span class="ml-4 font-semibold text-gray-700">{{ maxPrice }}€</span>
      </div>
    </div>

    <!-- Parte derecha: Productos filtrados -->
    <div class="w-full md:w-3/4 px-4 py-8 pt-12">
      <div class="border border-indigo-500 rounded-r px-4 py-8 pt-12">
        <!-- Condicional para mostrar el LoadingScreen o el listado filtrado -->
        <template v-if="isLoading">
          <LoadingScreen />
        </template>
        
        <template v-else>
          <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-6">
            <router-link
              v-for="producto in resultadosFiltrados"
              :key="producto.id"
              :to="`/producto/${producto.id}`"
              class="block"
            >
              <div class="bg-white p-4 rounded shadow transition-transform transform hover:-translate-y-1 hover:shadow-lg h-[400px] flex flex-col justify-between">
                <img
                  :src="`/${producto.imagen}`"
                  alt="Carátula del juego"
                  class="h-[250px] w-full object-contain mb-4 rounded"
                />
                <h3 class="text-lg font-semibold">{{ producto.nombre }}</h3>
                <p class="text-gray-700">{{ producto.precio }}€</p>
              </div>
            </router-link>
          </div>
        </template>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'
import LoadingScreen from '@/components/LoadingScreen.vue'

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
    .filter(p => 
      p.nombre.toLowerCase().includes(terminoBusqueda.value.trim().toLowerCase())
    )
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

onMounted(() => {
  obtenerProductos()
  // Simula loader de 4 segundos
  setTimeout(() => {
    isLoading.value = false
  }, 4000)
})
</script>

<style scoped>
/* Ajusta estilos adicionales según necesites */
</style>

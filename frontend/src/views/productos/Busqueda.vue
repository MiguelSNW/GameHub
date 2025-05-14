<template>
  <div class="max-w-6xl mx-auto relative">
    <!-- Encabezado posicionado sobre el borde del contenedor -->
    <h1 class="absolute -top-5 left-4 bg-gray-900 px-2 text-2xl font-bold text-white">
      Resultados de búsqueda para "{{ termino }}"
    </h1>
    
    <!-- Contenedor con borde, redondeado y con padding -->
    <div class="border border-indigo-500 rounded px-4 py-8 pt-12">
      
      <!-- Filtro de rango de precios: Una barra única para definir el precio máximo -->
      <div class="mb-4">
        <div class="flex items-center">
          <input
            v-model.number="maxPrice"
            type="range"
            min="0"
            :max="maxLimit"
            step="10"
            class="accent-indigo-500 flex-1"
          />
          <!-- El precio máximo aparece justo a la derecha del slider -->
          <span class="ml-4 font-semibold text-gray-700">{{ maxPrice }}€</span>
        </div>
      </div>
      
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
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import { useRoute } from 'vue-router'
import axios from 'axios'
import LoadingScreen from '@/components/LoadingScreen.vue'

// Obtener el término de búsqueda desde la URL
const route = useRoute()
const termino = ref(route.query.q || '')

// Variables para resultados y loader
const resultados = ref([])
const isLoading = ref(true)

// Definir límite máximo del rango de precios
const maxLimit = 1000

// Inicializar el valor para el precio máximo (mínimo siempre 0)
const maxPrice = ref(maxLimit)

// Propiedad computada para filtrar productos según el rango seleccionado (precio <= maxPrice)
const resultadosFiltrados = computed(() => {
  return resultados.value.filter(producto => producto.precio <= maxPrice.value)
})

// Función para buscar productos basados en el término
const buscarProductos = async () => {
  if (!termino.value.trim()) return
  try {
    const res = await axios.get(`/productos/buscar?q=${encodeURIComponent(termino.value)}`)
    resultados.value = res.data
  } catch (error) {
    console.error('Error al buscar productos:', error)
  }
}

// Cargar productos al montar la vista
onMounted(() => {
  buscarProductos()
  // Simula carga: Mantener el loader visible 4 segundos
  setTimeout(() => {
    isLoading.value = false
  }, 4000)
})

// Actualizar la búsqueda si cambia el query parameter
watch(() => route.query.q, (nuevo) => {
  termino.value = nuevo
  buscarProductos()
})
</script>

<style scoped>
/* Puedes ajustar estilos adicionales según necesites */
</style>

<template>
  <div class="max-w-6xl mx-auto relative">
    <!-- Encabezado posicionado sobre el borde del contenedor -->
    <h1 class="absolute -top-5 left-4 bg-gray-900 px-2 text-2xl font-bold text-white">
      Resultados de búsqueda para "{{ termino }}"
    </h1>
    <!-- Contenedor con borde, redondeado y con padding. Se deja espacio en la parte superior para el encabezado -->
    <div class="border border-indigo-500 rounded px-4 py-8 pt-12">
      <template v-if="isLoading">
        <LoadingScreen />
      </template>
      <template v-else>
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-6">
          <router-link
            v-for="producto in resultados"
            :key="producto.id"
            :to="`/producto/${producto.id}`"
            class="block"
          >
            <div class="bg-white p-4 rounded shadow transition-transform transform hover:-translate-y-1 hover:shadow-lg h-[400px] flex flex-col justify-between">
              <img :src="`/${producto.imagen}`" alt="Carátula del juego" class="h-[250px] w-full object-contain mb-4 rounded" />
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
  import { ref, onMounted, watch } from 'vue'
  import { useRoute } from 'vue-router'
  import axios from 'axios'
  import LoadingScreen from '@/components/LoadingScreen.vue'
  
  const route = useRoute()
  const termino = ref(route.query.q || '')
  const resultados = ref([])
  // Variable para el loader
const isLoading = ref(true)


  const buscarProductos = async () => {
    if (!termino.value.trim()) return
    const res = await axios.get(`/productos/buscar?q=${encodeURIComponent(termino.value)}`)
    resultados.value = res.data
  }
  
  // Carga al entrar y si cambia el query param
  onMounted(() => {
    buscarProductos()
    // Simular carga: Mostrar el loader por 4 segundos
    setTimeout(() => {
      isLoading.value = false
    }, 4000)
  })
  watch(() => route.query.q, (nuevo) => {
    termino.value = nuevo
    buscarProductos()
  })

  </script>
  
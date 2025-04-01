<template>
    <div class="max-w-6xl mx-auto p-4">
      <h1 class="text-2xl font-bold mb-4">Resultados de búsqueda para "{{ termino }}"</h1>
  
      <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-6">
        <router-link
          v-for="producto in resultados"
          :key="producto.id"
          :to="`/producto/${producto.id}`"
          class="block"
        >
          <div     class="bg-white p-4 rounded shadow transition-transform transform hover:-translate-y-1 hover:shadow-lg h-[400px] flex flex-col justify-between">
            <img :src="`/${producto.imagen}`" class="h-[250px] w-full object-contain mb-4" />
            <h3 class="text-lg font-semibold">{{ producto.nombre }}</h3>
            <p class="text-gray-700">{{ producto.precio }}€</p>
          </div>
        </router-link>
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted, watch } from 'vue'
  import { useRoute } from 'vue-router'
  import axios from 'axios'
  
  const route = useRoute()
  const termino = ref(route.query.q || '')
  const resultados = ref([])
  
  const buscarProductos = async () => {
    if (!termino.value.trim()) return
    const res = await axios.get(`http://localhost:8000/productos/buscar?q=${encodeURIComponent(termino.value)}`)
    resultados.value = res.data
  }
  
  // Carga al entrar y si cambia el query param
  onMounted(buscarProductos)
  watch(() => route.query.q, (nuevo) => {
    termino.value = nuevo
    buscarProductos()
  })
  </script>
  
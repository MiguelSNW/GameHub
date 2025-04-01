<template>
    <div class="max-w-4xl mx-auto p-4">
      <img
        :src="`/${producto.imagen}`"
        alt="Carátula"
        class="w-full max-h-96 object-contain mb-4"
      />
      <h1 class="text-3xl font-bold mb-2">{{ producto.nombre }}</h1>
      <p class="text-gray-600 text-lg mb-2">{{ producto.descripcion }}</p>
      <p class="text-indigo-700  text-xl font-bold mb-8">Fecha de lanzamiento: {{ producto.fecha_lanz }}</p>
      <p class="text-3xl font-bold"> {{ producto.precio }}€ <span class="ml-4 px-3 py-1 rounded-full text-white text-sm" :class="esPrecompra ? 'bg-violet-950' : 'bg-indigo-700'"
  >
    {{ esPrecompra ? '¡Precompra YA!' : '¡Compra YA!' }}
  </span>
</p>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted } from 'vue'
  import { useRoute } from 'vue-router'
  import axios from 'axios'
  import { computed } from 'vue'

  const producto = ref({})
  const route = useRoute()
  
  const esPrecompra = computed(() => {
  if (!producto.value.fecha_lanz) return false
  const hoy = new Date()
  const fechaLanz = new Date(producto.value.fecha_lanz)
  return fechaLanz > hoy
})
  
  onMounted(async () => {
    const res = await axios.get(`http://localhost:8000/productos/${route.params.id}`)
    producto.value = res.data
  })
  </script>
  
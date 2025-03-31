<template>
  <div class="min-h-screen bg-gray-100 p-6">
    <h1 class="text-3xl font-bold text-gray-800 mb-6">📊 Panel de Control</h1>

    <div class="grid gap-6 grid-cols-1 sm:grid-cols-2 md:grid-cols-3">

      <div class="bg-white rounded-2xl shadow-md p-6 border-l-8 border-blue-500">
        <h2 class="text-xl font-semibold text-blue-700">👥 Usuarios</h2>
        <p class="text-3xl font-bold mt-2">{{ datos.usuarios }}</p>
      </div>

      <div class="bg-white rounded-2xl shadow-md p-6 border-l-8 border-green-500">
        <h2 class="text-xl font-semibold text-green-700">🛒 Ventas</h2>
        <p class="text-3xl font-bold mt-2">{{ datos.ventas }}</p>
      </div>

      <div class="bg-white rounded-2xl shadow-md p-6 border-l-8 border-yellow-500">
        <h2 class="text-xl font-semibold text-yellow-700">💰 Ingresos</h2>
        <p class="text-3xl font-bold mt-2">$ {{ datos.ingresos }}</p>
      </div>
    </div>
    <p class="text-red-500 text-2xl font-bold">¿Se ve rojo? Tailwind funciona.</p>

  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'Dashboard',
  data() {
    return {
      datos: {
        usuarios: 0,
        ventas: 0,
        ingresos: 0
      }
    }
  },
  mounted() {
    axios.get('http://localhost:8000/dashboard')
      .then(res => {
        this.datos = res.data
      })
      .catch(err => {
        console.error('Error al cargar dashboard:', err)
      })
  }
}
</script>

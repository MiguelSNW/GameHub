<template>
    <div class="container mx-auto p-6">
      <h1 class="text-3xl font-bold mb-6">Perfil de Usuario</h1>
      
      <!-- Loader mientras se carga el perfil -->
      <div v-if="isLoading" class="flex justify-center items-center">
        <LoadingScreen />
      </div>
      
      <!-- Mostrar datos del usuario cuando se hayan cargado -->
      <div v-else class="bg-white p-6 rounded shadow-md">
        <p><strong>DNI:</strong> {{ user.dni }}</p>
        <p><strong>Nombre:</strong> {{ user.nombre }}</p>
        <p><strong>Correo:</strong> {{ user.correo }}</p>
        <!-- Agrega otros campos del usuario según tu modelo -->
        <p v-if="user.telefono"><strong>Teléfono:</strong> {{ user.telefono }}</p>
        <p v-if="user.direccion"><strong>Dirección de envío:</strong> {{ user.direccion }}</p>
        <!-- etc. -->
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted } from 'vue'
  import axios from 'axios'
  import LoadingScreen from '@/components/LoadingScreen.vue'
  
  const isLoading = ref(true)
  const user = ref({})
  
  onMounted(async () => {
    try {
      // Obtenemos el token almacenado en localStorage para autenticación
      const token = localStorage.getItem('token')
      
      // Realizamos una petición GET al endpoint protegido que devuelve los datos del usuario
      const response = await axios.get('/getUser', {
        headers: {
          Authorization: `Bearer ${token}`
        }
      })
      
      // Guardamos los datos del usuario
      user.value = response.data
    } catch (error) {
      console.error('Error fetching user data:', error)
      // Aquí podrías redirigir al login o mostrar un mensaje de error según tu lógica
    } finally {
      isLoading.value = false
    }
  })
  </script>
  
  <style scoped>
  /* Puedes agregar estilos personalizados para la vista de perfil aquí */
  .container {
    max-width: 800px;
  }
  </style>
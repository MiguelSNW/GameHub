<template>
    <div class="max-w-xl mx-auto p-4 border border-gray-300 rounded shadow-lg">
      <h2 class="text-xl font-bold mb-4">Asistente Virtual</h2>
      
      <!-- Historial de chat -->
      <div class="h-64 overflow-y-auto border p-2 rounded mb-4" ref="chatContainer">
        <div v-for="(mensaje, index) in mensajes" :key="index" class="mb-2">
          <div :class="mensaje.tipo === 'usuario' ? 'text-right' : 'text-left'">
            <span :class="mensaje.tipo === 'usuario' 
                ? 'bg-blue-500 text-white px-3 py-1 rounded inline-block' 
                : 'bg-gray-200 text-gray-800 px-3 py-1 rounded inline-block'">
              {{ mensaje.texto }}
            </span>
          </div>
        </div>
      </div>
      
      <!-- Formulario -->
      <form @submit.prevent="enviarMensaje" class="flex">
        <input 
          type="text" 
          v-model="nuevoMensaje"
          placeholder="Escribe tu mensaje..."
          class="flex-1 border rounded-l px-3 py-2 focus:outline-none"
          required
        />
        <button type="submit" class="bg-blue-500 text-white px-4 rounded-r hover:bg-blue-600">
          Enviar
        </button>
      </form>
    </div>
  </template>
  
  <script setup>
  import { ref, nextTick } from 'vue'
  import axios from 'axios'
  
  const mensajes = ref([
    { tipo: 'asistente', texto: '¡Hola! ¿En qué puedo ayudarte hoy?' }
  ])
  const nuevoMensaje = ref('')
  const chatContainer = ref(null)
  
  const enviarMensaje = async () => {
    const texto = nuevoMensaje.value.trim()
    if (!texto) return
  
    // Agregar mensaje de usuario
    mensajes.value.push({ tipo: 'usuario', texto })
    nuevoMensaje.value = ''
  
    await nextTick(() => {
      if (chatContainer.value) {
        chatContainer.value.scrollTop = chatContainer.value.scrollHeight
      }
    })
  
    try {
      // Llamada al endpoint del backend
      const res = await axios.post('/chat', { mensaje: texto })
      const respuestaIA = res.data.respuesta || 'Lo siento, no pude procesar tu mensaje.'
      mensajes.value.push({ tipo: 'asistente', texto: respuestaIA })
    } catch (error) {
      console.error('Error al obtener respuesta:', error)
      mensajes.value.push({ tipo: 'asistente', texto: 'Ha ocurrido un error, por favor intenta de nuevo.' })
    }
  
    await nextTick(() => {
      if (chatContainer.value) {
        chatContainer.value.scrollTop = chatContainer.value.scrollHeight
      }
    })
  }
  </script>
  
  <style scoped>
  /* Puedes ajustar estilos adicionales para el chat si lo deseas */
  </style>
  
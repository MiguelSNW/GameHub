<template>
  <div class="max-w-3xl mx-auto p-6 text-white">
    <h1 class="text-3xl font-bold mb-6 text-center text-violet-400">Perfil de Usuario</h1>

    <div v-if="isLoading" class="flex justify-center items-center">
      <LoadingScreen />
    </div>

    <div
      v-else
      class="bg-gray-800 p-6 rounded-2xl shadow-xl border border-gray-700 transition transform hover:-translate-y-1"
    >
      <div class="space-y-4">
        <div class="flex justify-between border-b border-gray-700 pb-2">
          <span class="font-semibold text-gray-300">DNI:</span>
          <span class="text-gray-100">{{ user.dni }}</span>
        </div>
        <div class="flex justify-between border-b border-gray-700 pb-2">
          <span class="font-semibold text-gray-300">Nombre:</span>
          <span class="text-gray-100">{{ user.nombre }}</span>
        </div>
        <div class="flex justify-between border-b border-gray-700 pb-2">
          <span class="font-semibold text-gray-300">Apellidos:</span>
          <span class="text-gray-100">{{ user.apellidos }}</span>
        </div>
        <div class="flex justify-between border-b border-gray-700 pb-2">
          <span class="font-semibold text-gray-300">Correo:</span>
          <span class="text-gray-100">{{ user.correo }}</span>
        </div>
        <div class="flex justify-between border-b border-gray-700 pb-2">
          <span class="font-semibold text-gray-300">Teléfono:</span>
          <span class="text-gray-100">{{ user.telefono }}</span>
        </div>
        <div class="flex justify-between border-b border-gray-700 pb-2">
          <span class="font-semibold text-gray-300">Tipo de usuario:</span>
          <span class="text-gray-100 capitalize">{{ user.tipouser }}</span>
        </div>
        <div class="flex justify-between border-b border-gray-700 pb-2">
          <span class="font-semibold text-gray-300">Nombre de usuario:</span>
          <span class="text-gray-100">{{ user.usuario }}</span>
        </div>
      </div>

      <!-- Botón para modificar -->
      <div class="mt-6 text-right">
        <button @click="showEditModal = true" class="bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700">
          Modificar Perfil
        </button>
      </div>
    </div>

    <!-- Modal de edición -->
    <div
      v-if="showEditModal"
      class="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center z-50"
    >
      <div class="bg-white text-black p-6 rounded-xl w-full max-w-lg shadow-lg relative">
       <!-- Encabezado del modal -->
<h2 class="text-xl font-bold mb-1">Editar Perfil</h2>
<p class="text-sm text-gray-500 mb-4">(Dejar un campo en blanco no modificará dicho campo)</p>


        <form @submit.prevent="guardarCambios">
  <div class="grid grid-cols-1 gap-4">
    <!-- Nombre -->
    <div>
      <input v-model="editForm.nombre" type="text" placeholder="Nombre" class="input" />
    </div>

    <!-- Apellidos -->
    <div>
      <input v-model="editForm.apellidos" type="text" placeholder="Apellidos" class="input" />
    </div>

    <!-- Correo -->
    <div>
      <input v-model="editForm.correo" type="email" placeholder="Correo" class="input" />
      <p v-if="erroresForm.correo" class="text-sm text-red-500 mt-1">{{ erroresForm.correo }}</p>
    </div>

    <!-- Teléfono -->
    <div>
      <input v-model="editForm.telefono" type="number" placeholder="Teléfono" class="input" />
    </div>

    <!-- Usuario -->
    <div>
      <input v-model="editForm.usuario" type="text" placeholder="Nombre de usuario" class="input" />
      <p v-if="erroresForm.usuario" class="text-sm text-red-500 mt-1">{{ erroresForm.usuario }}</p>
    </div>

    <!-- Contraseña -->
<div>
  <input v-model="editForm.clave" type="password" placeholder="Nueva contraseña (mínimo 8 caracteres)" class="input" />
</div>

  </div>

  <!-- Botones -->
  <div class="mt-6 flex justify-end gap-2">
    <button
      @click="showEditModal = false"
      type="button"
      class="bg-gray-600 text-white px-4 py-2 rounded hover:bg-gray-700"
    >
      Cancelar
    </button>
    <button
      type="submit"
      class="bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700"
    >
      Guardar Cambios
    </button>
  </div>
</form>

      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import LoadingScreen from '@/components/LoadingScreen.vue'
import Swal from 'sweetalert2'

const isLoading = ref(true)
const user = ref({})
const showEditModal = ref(false)

const editForm = ref({
  nombre: '',
  apellidos: '',
  correo: '',
  telefono: '',
  usuario: '',
    clave: ''
})

onMounted(async () => {
  try {
    const token = localStorage.getItem('token')
    const response = await axios.get('/getUser', {
      headers: {
        Authorization: `Bearer ${token}`
      }
    })
    user.value = response.data
  } catch (error) {
    console.error('Error fetching user data:', error)
  } finally {
    isLoading.value = false
  }
})

const guardarCambios = async () => {
  try {
    const token = localStorage.getItem('token')
    const cambios = {}

    for (const campo in editForm.value) {
      if (editForm.value[campo].trim() !== '') {
        cambios[campo] = editForm.value[campo]
      }
    }

    if (Object.keys(cambios).length === 0) {
      Swal.fire('Nada para actualizar', 'Debes rellenar al menos un campo.', 'info')
      return
    }

    await axios.put('/actualizar-usuario', cambios, {
      headers: {
        Authorization: `Bearer ${token}`
      }
    })

    showEditModal.value = false
    Swal.fire('Perfil actualizado', '', 'success')



   // Recargar datos del perfil
const res = await axios.get('/getUser', {
  headers: { Authorization: `Bearer ${token}` }
})
user.value = res.data

// ✅ Actualiza localStorage y emite evento personalizado
localStorage.setItem('userName', res.data.usuario);
window.dispatchEvent(new Event('usuario-actualizado'));

    // Reset formulario
    editForm.value = {
      nombre: '',
      apellidos: '',
      correo: '',
      telefono: '',
      usuario: '',
        clave: ''
    }
  } catch (error) {
     console.log(error.response.data.errors)
  // Reiniciar errores previos
  erroresForm.value = {
    correo: '',
    usuario: ''
  }

  if (error.response?.data?.errors) {
    const errs = error.response.data.errors
    erroresForm.value.correo = errs.correo?.[0] || ''
    erroresForm.value.usuario = errs.usuario?.[0] || ''
  } else {
    Swal.fire('Error', 'No se pudo actualizar el perfil.', 'error')
  }
}
}

const erroresForm = ref({
  correo: '',
  usuario: ''
})
</script>

<style scoped>
.input {
  @apply w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-violet-500;
}
</style>

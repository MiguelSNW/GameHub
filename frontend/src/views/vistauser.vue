<template>
  <div class="p-6">
    <h1 class="text-3xl font-bold text-green-700 mb-4">Lista de Usuarios</h1>

    <input
      v-model="search"
      type="text"
      placeholder="Buscar por nombre, usuario, DNI..."
      class="mb-4 p-2 border rounded"
    />
    <table class="w-full text-sm text-left text-gray-700 border border-gray-300 shadow-md rounded-lg overflow-hidden">
  <thead class="bg-violet-950 text-slate-200 uppercase text-xs font-semibold">
    <tr>
      <th class="px-4 py-3">Usuario</th>
      <th class="px-4 py-3">DNI</th>
      <th class="px-4 py-3">Nombre</th>
      <th class="px-4 py-3">Correo</th>
      <th class="px-4 py-3">Teléfono</th>
      <th class="px-4 py-3">Nivel</th>
      <th class="px-4 py-3">Tipo de Usuario</th>
      <th class="px-4 py-3">Acciones</th>
    </tr>
  </thead>
  <tbody>
    <tr
      v-for="usuario in paginatedUsuarios"
      :key="usuario.dni"
      class="bg-white border-t hover:bg-green-50 transition-colors duration-200"
    >
      <td class="px-4 py-3">{{ usuario.usuario }}</td>
      <td class="px-4 py-3">{{ usuario.dni }}</td>
      <td class="px-4 py-3">{{ usuario.nombre }}</td>
      <td class="px-4 py-3">{{ usuario.correo }}</td>
      <td class="px-4 py-3">{{ usuario.telefono }}</td>
      <td class="px-4 py-3">{{ usuario.nivel }}</td>
      <td class="px-4 py-3">{{ usuario.tipouser }}</td>
      <td class="px-4 py-3">
      <button @click="confirmarEliminacion(usuario)" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 transition">Eliminar</button>
    </td>
      
    </tr>
  </tbody>
</table>
    <!-- Paginación -->
    <div class="mt-4 flex justify-between items-center">
      <button @click="pagina--" :disabled="pagina === 1" class="px-4 py-2 bg-gray-300 rounded">Anterior</button>
      <span>Página {{ pagina }} de {{ totalPaginas }}</span>
      <button @click="pagina++" :disabled="pagina === totalPaginas" class="px-4 py-2 bg-gray-300 rounded">Siguiente</button>
    </div>
  </div>

  <!-- Modal -->
<div v-if="mostrarModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
  <div class="bg-white p-6 rounded-lg shadow-lg w-[90%] max-w-md">
    <h2 class="text-lg font-bold mb-4 text-red-600">¿Estás seguro?</h2>
    <p class="mb-4">¿Quieres eliminar al usuario <strong>{{ usuarioAEliminar.usuario }}</strong> con DNI: {{ usuarioAEliminar.dni }}?</p>
    <div class="flex justify-end gap-3">
      <button @click="mostrarModal = false" class="px-4 py-2 bg-gray-300 rounded hover:bg-gray-400">Cancelar</button>
      <button @click="eliminarUsuario" class="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700">Eliminar</button>
    </div>
  </div>
</div>

<!-- Toast de confirmación -->
<div
  v-if="mostrarToast"
  class="fixed bottom-6 right-6 bg-green-600 text-white px-4 py-3 rounded-lg shadow-lg animate-fade"
>
  {{ mensajeToast }}
</div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'vistauser',
  data() {
    return {
      usuarios: [],
      search: '',
      pagina: 1,
      porPagina: 5,
      mostrarModal: false,
      usuarioAEliminar: {},
      mostrarToast: false,
      mensajeToast: '',
    }
  },
  computed: {
    usuariosFiltrados() {
      return this.usuarios.filter(u => {
        const texto = `${u.usuario} ${u.nombre} ${u.dni}`.toLowerCase()
        return texto.includes(this.search.toLowerCase())
      })
    },
    totalPaginas() {
      return Math.ceil(this.usuariosFiltrados.length / this.porPagina)
    },
    paginatedUsuarios() {
      const inicio = (this.pagina - 1) * this.porPagina
      return this.usuariosFiltrados.slice(inicio, inicio + this.porPagina)
    }
  },
  mounted() {
    axios.get('http://localhost:8000/viewuser')
      .then(res => {
        this.usuarios = res.data.map(u => ({
          ...u,
          tipouser: u.nivel === 1 ? 'Administrador' : 'Cliente'
        }))
      })
      .catch(err => {
        console.error('Error al cargar usuarios:', err)
      })
  },
  watch: {
    search() {
      this.pagina = 1
    }
  },

  methods: {
  confirmarEliminacion(usuario) {
    this.usuarioAEliminar = usuario
    this.mostrarModal = true
  },
  eliminarUsuario() {
    axios.delete(`http://localhost:8000/eliminarusuario/${this.usuarioAEliminar.dni}`)
    .then(() => {
      this.usuarios = this.usuarios.filter(u => u.dni !== this.usuarioAEliminar.dni)
      this.mostrarModal = false

      // Mostrar notificación
      this.mensajeToast = 'Usuario eliminado correctamente'
      this.mostrarToast = true
      setTimeout(() => {
        this.mostrarToast = false
      }, 3000)
    })
    .catch(err => {
      console.error('Error al eliminar:', err)
      alert('No se pudo eliminar el usuario.')
    })
}
},
}
</script>

<style scoped>@keyframes fade {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
.animate-fade {
  animation: fade 0.3s ease-out;
}</style>

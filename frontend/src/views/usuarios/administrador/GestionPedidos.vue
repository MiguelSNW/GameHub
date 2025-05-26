<template>
  <h1 class="titulo text-white text-4xl font-bold text-center mt-8">Gestión de Pedidos</h1>

  <div class="table-container relative w-full">
    <!-- Tabla pedidos -->
        <!-- Botón para borrar historial -->

    <!-- Filtros por estado -->
<div class="flex gap-4 items-center text-white mt-6 mb-4">
  <label class="flex items-center gap-2">
    <input type="checkbox" v-model="filtros.confirmado" />
    Confirmados
  </label>
  <label class="flex items-center gap-2">
    <input type="checkbox" v-model="filtros.pendiente" />
    Pendientes de Confirmación
  </label>
  <label class="flex items-center gap-2">
    <input type="checkbox" v-model="filtros.cancelado" />
    Cancelados
  </label>
</div>

<!-- Filtro por DNI -->
<div class="mt-2 flex justify-start">
  <input
    v-model="filtroDni"
    type="text"
    placeholder="Buscar por DNI..."
    class="p-2 border border-gray-300 rounded w-64"
  />
</div>


    <table class="table w-full table-auto shadow-lg rounded-lg bg-white mt-6">
      <thead class="bg-gray-800 text-white">
        <tr>
          <th class="py-4 px-4 text-sm border border-black">ID Pedido</th>
          <th class="py-4 px-4 text-sm border border-black">Cliente</th>
          <th class="py-4 px-4 text-sm border border-black">DNI</th>
          <th class="py-4 px-4 text-sm border border-black">Fecha</th>
          <th class="py-4 px-4 text-sm border border-black">Estado</th>
          <th class="py-4 px-4 text-sm border border-black text-center">Acciones</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="pedido in paginatedPedidos" :key="pedido.id">
          <td class="py-3 px-4 text-sm border border-black">{{ pedido.id }}</td>
          <td class="py-3 px-4 text-sm border border-black">{{ pedido.usuario?.nombre }} {{ pedido.usuario?.apellidos }}</td>
          <td class="py-3 px-4 text-sm border border-black">{{ pedido.usuario_dni }}</td>
          <td class="py-3 px-4 text-sm border border-black">{{ formatFecha(pedido.fecha) }}</td>
          <td class="py-3 px-4 text-sm border border-black text-center">
  <span :class="claseEstado(pedido.estado)" class="px-2 py-1 rounded text-sm font-semibold">
    {{ pedido.estado }}
  </span>
</td>
          <td class="py-3 px-4 text-sm border border-black text-center space-x-2">
  
  <!-- Cancelar (solo si no está confirmado ni cancelado) -->
<button
  v-if="pedido.estado.toLowerCase() !== 'confirmado' && pedido.estado.toLowerCase() !== 'cancelado'"
  @click="abrirModalCancelacion(pedido)"
  title="Cancelar"
>
  <i class="pi pi-times text-red-500 text-lg hover:text-red-700"></i>
</button>

  <!-- Ver Detalles -->
  <button @click="verDetallesPedido(pedido)" title="Ver detalles">
    <i class="pi pi-eye text-blue-500 text-lg hover:text-blue-700"></i>
  </button>
</td>
        </tr>
      </tbody>
    </table>

<div class="mt-4 flex justify-start">
  <button
    @click="borrarHistorial"
    class=" bg-indigo-700 text-white px-4 py-2 rounded shadow text-sm"
  >
    Borrar Historial (Cancelados y Confirmados)
  </button>
</div>

    <!-- Paginación -->
    <div class="flex justify-center items-center space-x-4 mt-6">
      <button @click="previousPage" :disabled="currentPage === 1"
        class="bg-indigo-700 text-white py-2 px-4 rounded disabled:bg-gray-300 text-sm">
        Anterior
      </button>
      <span class="text-white text-xl">Página {{ currentPage }} de {{ totalPages }}</span>
      <button @click="nextPage" :disabled="currentPage === totalPages"
        class="bg-indigo-700 text-white py-2 px-4 rounded disabled:bg-gray-300 text-sm">
        Siguiente
      </button>
    </div>
  </div>
 
<!-- Modal de Detalles del Pedido -->
<div v-if="mostrarModalDetalles"
     class="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center z-50 transition-opacity duration-300">
  <div
    class="bg-white text-black w-full max-w-2xl p-6 rounded-lg shadow-lg max-h-[90vh] overflow-y-auto
           transform transition-all duration-300 scale-90 opacity-0 animate-fade-in">
    
    <h2 class="text-2xl font-bold mb-4 text-center">
      Detalles del Pedido #{{ pedidoSeleccionado.id }}
    </h2>

    <!-- Tabla de productos -->
    <table class="w-full table-auto border border-gray-300">
      <thead class="bg-gray-100">
        <tr>
          <th class="py-2 px-4 border">Producto</th>
          <th class="py-2 px-4 border">Cantidad</th>
          <th class="py-2 px-4 border">Precio Unitario</th>
          <th class="py-2 px-4 border">Stock Actual</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="producto in pedidoSeleccionado.productos" :key="producto.id">
          <td class="py-2 px-4 border">{{ producto.nombre }}</td>
          <td class="py-2 px-4 border">{{ producto.pivot.cantidad }}</td>
          <td class="py-2 px-4 border">{{ parseFloat(producto.pivot.precio_unitario).toFixed(2) }} €</td>
          <td class="py-2 px-4 border">{{ producto.stock }}</td>
        </tr>
      </tbody>
    </table>



    <!-- Motivo de cancelación -->
    <div
      v-if="pedidoSeleccionado.estado?.toLowerCase() === 'cancelado'"
      class="mt-6 bg-red-100 border-l-4 border-red-500 p-4 rounded"
    >
      <h3 class="font-semibold text-red-700 mb-2">Motivo de Cancelación</h3>
      <p class="text-red-800 whitespace-pre-line">{{ pedidoSeleccionado.detalles }}</p>
    </div>

    <!-- Botones de acción -->
    <div class="mt-6 text-right">
      <div class="flex justify-end gap-4">
        <button
          @click="mostrarModalDetalles = false"
          class="bg-gray-300 text-black px-4 py-2 rounded hover:bg-gray-400"
        >
          Cerrar
        </button>

        <!-- Solo mostrar botón "Procesar Pedido" si está pendiente -->
        <template v-if="pedidoSeleccionado.estado?.toLowerCase() === 'pendiente de confirmación'">
          <button
            @click="procesarPedido(pedidoSeleccionado)"
            :disabled="tieneProductosSinStock"
            class="bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            Procesar Pedido
          </button>
        </template>
      </div>

      <!-- Mensaje si no hay stock -->
      <p v-if="pedidoSeleccionado.estado?.toLowerCase() === 'pendiente de confirmación' && tieneProductosSinStock"
         class="text-red-600 text-sm mt-2 text-right">
        Este pedido contiene productos sin stock suficiente, no se puede procesar el pedido.
      </p>
    </div>
  </div>
</div>


<!-- Modal Cancelación -->
<div v-if="mostrarModalCancelacion" class="fixed inset-0 flex items-center justify-center z-50 bg-black bg-opacity-60">
  <div class="bg-white rounded-lg shadow-xl w-full max-w-lg p-6">
    <h2 class="text-2xl font-bold mb-4">Cancelar Pedido</h2>
    
    <p class="mb-2 text-gray-700">Indica los detalles de por qué se ha cancelado el pedido:</p>
    
    <textarea
      v-model="motivoCancelacion"
      rows="5"
      class="w-full p-2 border border-gray-300 rounded-md resize-none focus:outline-none focus:ring-2 focus:ring-indigo-500"
    ></textarea>

    <div class="mt-6 flex justify-end space-x-2">
      <button
        @click="mostrarModalCancelacion = false"
        class="px-4 py-2 rounded bg-gray-200 hover:bg-gray-300 text-gray-800"
      >
        Cancelar
      </button>
      <button
        @click="enviarCancelacion"
        :disabled="!motivoCancelacion.trim()"
        class="px-4 py-2 rounded bg-indigo-600 hover:bg-indigo-700 text-white disabled:opacity-50"
      >
        Confirmar Cancelación
      </button>
    </div>
  </div>
</div>

</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import axios from 'axios'
import 'primeicons/primeicons.css'
import Swal from 'sweetalert2'
import 'sweetalert2/dist/sweetalert2.min.css'


const filtroDni = ref('')
const pedidos = ref([])
const currentPage = ref(1)
const pedidosPorPagina = 8

const motivoCancelacion = ref('')
const mostrarModalCancelacion = ref(false)


const obtenerPedidos = async () => {
  try {
    const res = await axios.get('/obtener-pedidos-todos-usuarios')
    pedidos.value = res.data
  } catch (error) {
    console.error('Error al cargar pedidos:', error)
  }
}

const abrirModalCancelacion = (pedido) => {
  pedidoSeleccionado.value = pedido
  motivoCancelacion.value = ''
  mostrarModalCancelacion.value = true
}



const enviarCancelacion = async () => {
  try {
    await axios.post(`/pedidos/${pedidoSeleccionado.value.id}/cancelar`, {
      mensaje: motivoCancelacion.value
    })

    mostrarModalCancelacion.value = false

    // 🔁 Recargar pedidos después de cancelar
    await obtenerPedidos()

    Swal.fire({
      icon: 'success',
      title: 'Pedido cancelado',
      text: 'El pedido se ha cancelado correctamente y se ha enviado el correo al usuario.',
      confirmButtonColor: '#3085d6'
    })

  } catch (error) {
    console.error(error)

    Swal.fire({
      icon: 'error',
      title: 'Error',
      text: 'Hubo un problema al cancelar el pedido.',
      confirmButtonColor: '#d33'
    })
  }
}


const tieneProductosSinStock = computed(() => {
  if (!pedidoSeleccionado.value || !pedidoSeleccionado.value.productos) return false;

  return pedidoSeleccionado.value.productos.some(p => {
    const stock = Number(p.stock)
    const cantidad = Number(p.pivot.cantidad)
    return stock < cantidad
  })
});


onMounted(() => {
  obtenerPedidos()

})

const paginatedPedidos = computed(() => {
  const pedidosFiltrados = pedidos.value.filter(p => {
    const estado = p.estado.toLowerCase()
    const coincideEstado =
      (estado === 'confirmado' && filtros.value.confirmado) ||
      (estado === 'pendiente de confirmación' && filtros.value.pendiente) ||
      (estado === 'cancelado' && filtros.value.cancelado)

    const coincideDni = p.usuario_dni.toLowerCase().includes(filtroDni.value.toLowerCase())

    return coincideEstado && coincideDni
  })

  const start = (currentPage.value - 1) * pedidosPorPagina
  return pedidosFiltrados.slice(start, start + pedidosPorPagina)
})

watch(filtroDni, () => {
  currentPage.value = 1
})

const totalPages = computed(() => {
  const totalFiltrados = pedidos.value.filter(p => {
    const estado = p.estado.toLowerCase()
    return (
      (estado === 'confirmado' && filtros.value.confirmado) ||
      (estado === 'pendiente de confirmación' && filtros.value.pendiente) ||
      (estado === 'cancelado' && filtros.value.cancelado)
    )
  })
  return Math.max(1, Math.ceil(totalFiltrados.length / pedidosPorPagina))
})
const nextPage = () => {
  if (currentPage.value < totalPages.value) currentPage.value++
}

const previousPage = () => {
  if (currentPage.value > 1) currentPage.value--
}

const formatFecha = (fecha) => {
  return new Date(fecha).toLocaleDateString()
}

const claseEstado = (estado) => {
  switch (estado.toLowerCase()) {
    case 'cancelado':
      return 'bg-red-600 text-white'
    case 'pendiente de confirmación':
      return 'bg-yellow-500 text-black dark:text-white'
    case 'confirmado':
      return 'bg-green-600 text-white'
    default:
      return 'bg-gray-400 text-white'
  }
}

const filtros = ref({
  confirmado: true,
  pendiente: true,
  cancelado: true,
})

const mostrarModalDetalles = ref(false)
const pedidoSeleccionado = ref(null)

const verDetallesPedido = async (pedido) => {
  try {
    const res = await axios.get(`/pedido-detalles/${pedido.id}`)
    pedidoSeleccionado.value = res.data
    mostrarModalDetalles.value = true
  } catch (error) {
    console.error('Error al obtener detalles del pedido', error)
  }
}

const procesarPedido = async (pedido) => {
  try {
    const res = await axios.post(`/procesar-pedido/${pedido.id}`)
    mostrarModalDetalles.value = false

    // Recargar lista de pedidos tras procesar
    await obtenerPedidos()

    // Mostrar confirmación
    Swal.fire('¡Éxito!', 'El pedido ha sido procesado correctamente.', 'success')
  } catch (error) {
    console.error('Error al procesar el pedido:', error)
    Swal.fire('Error', 'No se pudo procesar el pedido.', 'error')
  }
}

const borrarHistorial = async () => {
  const confirmacion = await Swal.fire({
    title: '¿Estás seguro?',
    text: 'Se eliminarán todos los pedidos pendientes y cancelados.',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonText: 'Sí, borrar',
    cancelButtonText: 'Cancelar',
    confirmButtonColor: '#6d2e9e',
    cancelButtonColor: '#cec6d5'
  })

  if (confirmacion.isConfirmed) {
    try {
      await axios.delete('/pedidos/historial')
      await obtenerPedidos()

      Swal.fire('Borrado', 'Pedidos pendientes y cancelados eliminados.', 'success')
    } catch (error) {
      console.error('Error al borrar historial:', error)
      Swal.fire('Error', 'No se pudo borrar el historial.', 'error')
    }
  }
}

</script>


<style scoped>
@keyframes fade-in {
  0% {
    opacity: 0;
    transform: scale(0.9);
  }
  100% {
    opacity: 1;
    transform: scale(1);
  }
}

.animate-fade-in {
  animation: fade-in 0.3s ease-out forwards;
}
</style>

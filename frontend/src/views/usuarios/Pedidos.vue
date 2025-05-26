<template>
  <div class="max-w-4xl mx-auto p-6 text-white">
    <h1 class="text-3xl font-bold mb-6">Tus Pedidos</h1>

    <div v-if="pedidos.length === 0">
      <p>No tienes pedidos registrados.</p>
    </div>

    <div v-else class="space-y-4">
          <!-- Selector de Año -->
<div class="mb-6 flex items-center space-x-4">
  <label for="año" class="text-lg font-semibold text-white">Filtrar por año:</label>
  <select
    v-model="añoSeleccionado"
    id="año"
    class="bg-gray-800 text-white px-3 py-2 rounded border border-gray-600"
  >
    <option v-for="año in añosDisponibles" :key="año" :value="año">
      {{ año }}
    </option>
  </select>
</div>
      <div
        v-for="pedido in pedidosPaginados"
        :key="pedido.id"
        class="bg-gray-800 border border-gray-600 rounded-xl shadow-md p-6"
      >
        <div class="flex items-center justify-between border-b border-gray-700 pb-3 mb-4">
          <h2 class="text-xl font-bold">Pedido #{{ pedido.id }}</h2>
          <span
            :class="claseEstado(pedido.estado)"
            class="px-3 py-1 rounded text-sm font-bold capitalize"
          >
            {{ pedido.estado }}
          </span>
        </div>

        <button
          @click="toggleDetalle(pedido.id)"
          class="bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700 mb-4"
        >
          {{ pedido.mostrarDetalle ? 'Ocultar productos' : 'Ver productos' }}
        </button>

    
        <div
          v-if="pedido.mostrarDetalle"
          class="overflow-y-auto max-h-[300px] space-y-2 bg-gray-700 rounded-lg p-4"
        >
          <ul class="space-y-3">
            <li
              v-for="(producto, index) in pedido.productos"
              :key="index"
              class="flex items-center justify-between"
            >
              <div class="flex items-center space-x-3">
                <img
                  :src="`/${producto.imagen}`"
                  alt="Carátula"
                  class="w-16 h-16 object-contain rounded"
                />
                <div>
                  <p class="font-semibold">{{ producto.nombre }}</p>
                  <p class="text-sm text-gray-300">
                    {{ Number(producto.pivot.precio_unitario).toFixed(2) }} € (c/u)
                  </p>
                </div>
              </div>
              <span class="text-sm text-white font-medium">× {{ producto.pivot.cantidad }}</span>
            </li>
          </ul>

          <div class="mt-4 text-right">
            <p class="text-lg font-bold text-emerald-400">
              Total: {{ calcularPrecioTotal(pedido) }} €
            </p>
          </div>
        </div>
      </div>
    </div>

    <div class="flex justify-center mt-6 space-x-2" v-if="totalPaginas > 1">
      <button
        :disabled="paginaActual === 1"
        @click="paginaActual--"
        class="px-3 py-1 bg-indigo-600 text-white rounded hover:bg-indigo-700 disabled:opacity-50"
      >
        Anterior
      </button>

      <button
        v-for="n in totalPaginas"
        :key="n"
        @click="paginaActual = n"
        :class="[
          'px-3 py-1 rounded',
          n === paginaActual ? 'bg-indigo-800 text-white' : 'bg-gray-700 text-white hover:bg-indigo-600'
        ]"
      >
        {{ n }}
      </button>

      <button
        :disabled="paginaActual === totalPaginas"
        @click="paginaActual++"
        class="px-3 py-1 bg-indigo-600 text-white rounded hover:bg-indigo-700 disabled:opacity-50"
      >
        Siguiente
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed, watch } from 'vue'
import axios from 'axios'

const pedidos = ref([])
const paginaActual = ref(1)
const pedidosPorPagina = 5
const añoSeleccionado = ref(null)
const añosDisponibles = ref([])

// Cargar pedidos del usuario
const cargarPedidos = async () => {
  try {
    const response = await axios.get('/obtener-pedidos-usuario')
    pedidos.value = response.data.map(pedido => ({
      ...pedido,
      mostrarDetalle: false
    }))

    // Extraer los años únicos de la propiedad `fecha`
    const años = [...new Set(
      pedidos.value.map(p => new Date(p.fecha).getFullYear())
    )].sort((a, b) => b - a)

    añosDisponibles.value = años
    añoSeleccionado.value = años[0] ?? null
  } catch (error) {
    console.error('Error al obtener los pedidos:', error)
  }
}

// Computed: Pedidos filtrados por año
const pedidosFiltrados = computed(() => {
  if (!añoSeleccionado.value) return pedidos.value
  return pedidos.value.filter(p => new Date(p.fecha).getFullYear() === añoSeleccionado.value)
})

// Computed: Total de páginas según filtrado
const totalPaginas = computed(() =>
  Math.ceil(pedidosFiltrados.value.length / pedidosPorPagina)
)

// Computed: Pedidos paginados
const pedidosPaginados = computed(() => {
  const inicio = (paginaActual.value - 1) * pedidosPorPagina
  return pedidosFiltrados.value.slice(inicio, inicio + pedidosPorPagina)
})

// Resetear a página 1 al cambiar año
watch(añoSeleccionado, () => {
  paginaActual.value = 1
})

const claseEstado = (estado) => {
  switch (estado.toLowerCase()) {
    case 'cancelado': return 'bg-red-600 text-white'
    case 'pendiente de confirmación': return 'bg-yellow-500 text-black'
    case 'confirmado': return 'bg-green-600 text-white'
    default: return 'bg-gray-500 text-white'
  }
}

const toggleDetalle = (pedidoId) => {
  const pedido = pedidos.value.find(p => p.id === pedidoId)
  pedido.mostrarDetalle = !pedido.mostrarDetalle
}

const calcularPrecioTotal = (pedido) => {
  return pedido.productos.reduce((total, producto) => {
    return total + (producto.pivot.cantidad * producto.pivot.precio_unitario)
  }, 0).toFixed(2)
}

onMounted(() => {
  cargarPedidos()
})
</script>

<style scoped>
body {
  background-color: #111827;
}
</style>

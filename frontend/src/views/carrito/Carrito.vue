<template>
  <!-- Pantalla de carga -->
   <div v-if="loading" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-60 z-50">
    <LoadingScreen />
  </div>

  <!-- Contenido principal del carrito -->
  <div v-else class="max-w-4xl mx-auto p-6 text-white">
    <h1 class="text-3xl font-bold mb-6">Resumen de tu Carrito</h1>

    <div v-if="productosSeparados.length === 0">
      <p>No hay productos en el carrito.</p>
    </div>

    <div v-else>
     <div class="max-h-[50vh] overflow-y-auto pr-2">
  <ul class="divide-y divide-gray-700">
    <li
      v-for="(item, index) in productosSeparados"
      :key="`${item.id}-${index}`"
      class="py-4 flex items-center justify-between"
    >
      <div class="flex items-center space-x-4">
        <img :src="`/${item.imagen}`" class="w-28 h-28 object-contain rounded" />
        <div>
          <p class="font-bold">{{ item.nombre }}</p>
          <p class="text-sm text-gray-400">{{ parseFloat(item.precio).toFixed(2) }} €</p>
        </div>
      </div>
      <button @click="eliminarProducto(item.id)" class="text-red-400 hover:underline">
        Eliminar
      </button>
    </li>
  </ul>
</div>


   <div class="text-right mt-6">
  <p class="text-xl font-bold">Total: {{ totalCarrito.toFixed(2) }} €</p>
  <button
    class="mt-4 bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700"
    @click="mostrarModalPago = true"
  >
    Confirmar Compra
  </button>
</div>

    </div>
  </div>


<!-- Modal de método de pago -->
<div v-if="mostrarModalPago"
     class="fixed inset-0 bg-black bg-opacity-60 flex items-center justify-center z-50">
<div class="bg-white text-black rounded-xl shadow-xl w-full max-w-sm p-6 max-h-[90vh] overflow-y-auto">
    <!-- Contenido inicial: selección de método -->
    <template v-if="!pasoPagoActivo">
      <h2 class="text-lg font-bold mb-4">Selecciona método de pago</h2>

      <div class="space-y-3">
        <label class="flex items-center space-x-2">
          <input type="radio" value="paypal" v-model="metodoSeleccionado" />
          <span>PayPal</span>
        </label>
        <label class="flex items-center space-x-2">
          <input type="radio" value="bizum" v-model="metodoSeleccionado" />
          <span>Bizum</span>
        </label>
      </div>

      <div class="flex justify-end mt-6 space-x-2">
        <button @click="mostrarModalPago = false"
                class="bg-indigo-900 text-white px-4 py-2 rounded hover:bg-gray-600">
          Cancelar
        </button>
        <button :disabled="!metodoSeleccionado"
                class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 disabled:opacity-50"
                @click="procesarPago">
          Pagar ahora
        </button>
      </div>
    </template>

    <!-- Contenido cuando ya se ha confirmado el método -->
    <template v-else>
  <h2 class="text-lg font-bold mb-4">Procesando con {{ metodoSeleccionado }}</h2>
  <div v-if="mostrarBotonPaypal" id="paypal-button-container" class="mt-4"></div>

  <!-- Botón de Cancelar -->
  <div class="flex justify-end mt-6">
    <button @click="mostrarModalPago = false; pasoPagoActivo = false; mostrarBotonPaypal = false"
            class="bg-indigo-900 text-white px-4 py-2 rounded hover:bg-gray-600">
      Cancelar
    </button>
  </div>
</template>

  </div>
</div>

</template>

<script setup>
import { ref, computed, onMounted, nextTick } from 'vue'
import axios from 'axios'
import Swal from 'sweetalert2'
import LoadingScreen from '@/components/LoadingScreen.vue'

const productosCarrito = ref([])
const token = localStorage.getItem('token')
const loading = ref(true)
const mostrarModalPago = ref(false)
const metodoSeleccionado = ref('')
const mostrarBotonPaypal = ref(false)
const pasoPagoActivo = ref(false) // controla si ya se eligió y se debe mostrar solo el método

const cargarCarrito = async () => {
  try {
    const res = await axios.get('/carrito', {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    })
    productosCarrito.value = res.data.productos || []
  } catch (err) {
    console.error('Error al cargar carrito:', err)
  } finally {
    loading.value = false
  }
}

const procesarPago = () => {
  pasoPagoActivo.value = true
  if (metodoSeleccionado.value === 'paypal') {
    mostrarBotonPaypal.value = true

    nextTick(() => {
      if (window.paypal) {
        window.paypal.Buttons({
          createOrder: (data, actions) => {
            return actions.order.create({
              purchase_units: [{
                amount: {
                  value: totalCarrito.value.toFixed(2),
                  currency_code: 'EUR'
                }
              }]
            })
          },
          onApprove: async (data, actions) => {
            const details = await actions.order.capture()
            console.log('Pago completado:', details)

            Swal.fire({
              icon: 'success',
              title: 'Pago realizado',
              text: `Gracias, ${details.payer.name.given_name}`,
              confirmButtonText: 'Cerrar'
            })

            mostrarModalPago.value = false
            mostrarBotonPaypal.value = false
            metodoSeleccionado.value = ''
          },
          onError: (err) => {
            console.error('Error en el pago:', err)
            Swal.fire({
              icon: 'error',
              title: 'Error en el pago',
              text: 'Inténtalo de nuevo más tarde.'
            })
          }
        }).render('#paypal-button-container')
      }
    })
  } else {
    Swal.fire({
      icon: 'info',
      title: 'Método no implementado',
      text: 'Solo está disponible el pago por PayPal en este momento.',
      confirmButtonText: 'OK'
    })
  }
}

const productosSeparados = computed(() => {
  const lista = []
  for (const p of productosCarrito.value) {
    for (let i = 0; i < p.pivot.cantidad; i++) {
      lista.push(p)
    }
  }
  return lista
})

const totalCarrito = computed(() =>
  productosSeparados.value.reduce((sum, p) => sum + parseFloat(p.precio || 0), 0)
)

const eliminarProducto = async (productoId) => {
  try {
    await axios.delete(`/carrito/${productoId}`, {
      headers: { Authorization: `Bearer ${token}` },
    })
    await cargarCarrito()
    Swal.fire({
      position: 'top-start',
      icon: 'success',
      title: 'Producto eliminado',
      showConfirmButton: false,
      timer: 1500,
      toast: true,
    })
  } catch (e) {
    console.error('Error eliminando producto', e)
  }
}

onMounted(() => {
  cargarCarrito()
})
</script>


<style scoped>
body {
  background-color: #111827;
}
</style>

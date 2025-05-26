<template>
  <!-- Pantalla de carga -->
  <div v-if="loading" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-60 z-50">
    <LoadingScreen />
  </div>

  <!-- Contenido principal -->
  <div v-else class="max-w-4xl mx-auto p-6 text-white">
    <h1 class="text-3xl font-bold mb-6">Resumen de tu Carrito</h1>

    <div v-if="productosSeparados.length === 0" class="text-gray-300">
      <p>No hay productos en el carrito.</p>
    </div>

    <div v-else class="space-y-4">
  <div
    v-for="(item, index) in productosPaginados"
    :key="`${item.id}-${index}`"
    class="bg-gray-800 border border-gray-600 rounded-xl shadow-md p-4"
  >
    <div class="flex items-center space-x-4">
      <img :src="`/${item.imagen}`" class="w-24 h-24 object-contain rounded-lg" alt="Producto" />

      <div class="flex-1">
        <p class="text-lg font-bold">{{ item.nombre }}</p>
        <p class="text-sm text-gray-400">{{ parseFloat(item.precio).toFixed(2) }} €</p>
      </div>

      <button
        @click="eliminarProducto(item.id)"
        class="text-red-400 hover:text-red-500 hover:underline"
      >
        Eliminar
      </button>
    </div>
  </div>

  <!-- Total y acción -->
  <div class="bg-gray-900 border border-gray-700 rounded-xl p-6 mt-4 text-right">
    <p class="text-xl font-bold mb-4">Total: {{ totalCarrito.toFixed(2) }} €</p>
   <button
  class="bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700"
  @click="comprobarYMostrarPago"
>
  Confirmar Compra
</button>

  </div>

  <!-- Paginación -->
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
                class="bg-gray-400 text-black px-4 py-2 rounded hover:bg-gray-500">
          Cancelar
        </button>
        <button :disabled="!metodoSeleccionado"
                class="bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700 disabled:opacity-50"
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
            class="bg-gray-400 text-black px-4 py-2 rounded hover:bg-gray-500">
      Cancelar
    </button>
  </div>

 
</template>

  </div>
</div>
<transition
  enter-active-class="transition ease-out duration-300"
  enter-from-class="opacity-0 scale-90"
  enter-to-class="opacity-100 scale-100"
  leave-active-class="transition ease-in duration-200"
  leave-from-class="opacity-100 scale-100"
  leave-to-class="opacity-0 scale-90"
>
  <div
    v-if="mostrarModalSinStock"
    class="fixed inset-0 bg-black bg-opacity-60 flex items-center justify-center z-60"
  >
    <div
      class="bg-white text-black rounded-xl shadow-xl w-full max-w-md p-6 max-h-[80vh] overflow-y-auto"
    >
      <h2 class="text-xl font-bold mb-4 text-red-600 flex items-center space-x-2">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          class="h-6 w-6 flex-shrink-0"
          fill="none"
          viewBox="0 0 24 24"
          stroke="currentColor"
          stroke-width="2"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M12 9v2m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
          />
        </svg>
        <span>Productos sin stock</span>
      </h2>

      <p class="mb-4 text-gray-700">
        Para continuar con el pago, elimina primero los siguientes artículos sin stock:
      </p>

      <ul class="list-disc list-inside space-y-2 max-h-48 overflow-y-auto border border-red-200 rounded p-3 bg-red-50">
        <li
          v-for="producto in productosSinStock"
          :key="producto.id"
          class="text-red-700 font-semibold"
        >
          {{ producto.nombre }} - Cantidad solicitada: {{ producto.cantidad }}
        </li>
      </ul>

      <div class="flex justify-end mt-6 space-x-3">
        <button
          @click="mostrarModalSinStock = false"
          class="px-4 py-2 rounded-md border border-gray-300 hover:bg-gray-100 transition"
        >
          Cancelar
        </button>

        <button
          @click="eliminarProductosSinStock"
          class="px-4 py-2 rounded-md bg-indigo-600 text-white hover:bg-indigo-700 transition"
        >
          Eliminar productos sin stock
        </button>
      </div>
    </div>
  </div>
</transition>
</template>

<script setup>
import { ref, computed, onMounted, nextTick } from 'vue'
import axios from 'axios'
import Swal from 'sweetalert2'
import LoadingScreen from '@/components/LoadingScreen.vue'

const carritoCantidad = ref(0)
const productosCarrito = ref([])
const token = localStorage.getItem('token')
const loading = ref(true)
const mostrarModalPago = ref(false)
const metodoSeleccionado = ref('')
const mostrarBotonPaypal = ref(false)
const pasoPagoActivo = ref(false) // controla si ya se eligió y se debe mostrar solo el método
const paginaActual = ref(1)
const productosPorPagina = 3
const mostrarModalSinStock = ref(false)
const productosSinStock = ref([])


const validarStock = async () => {
  try {
    const token = localStorage.getItem('token')
    // Envía los productos con sus cantidades para validar stock en backend
    const response = await axios.post('/carrito/validar-stock', {
      productos: productosCarrito.value.map(p => ({
        id: p.id,
        cantidad: p.pivot.cantidad
      }))
    }, {
      headers: { Authorization: `Bearer ${token}` }
    })
    return response.data // espera { valid: true } o { valid: false, sinStock: [...] }
  } catch (error) {
    console.error('Error validando stock:', error)
    return { valid: false, sinStock: [] }
  }
}
const totalPaginas = computed(() => {
  return Math.ceil(productosSeparados.value.length / productosPorPagina)
})

const productosPaginados = computed(() => {
  const inicio = (paginaActual.value - 1) * productosPorPagina
  const fin = inicio + productosPorPagina
  return productosSeparados.value.slice(inicio, fin)
})

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

const eliminarProductosSinStock = async () => {
  try {
    const token = localStorage.getItem('token');
    const productoIds = productosSinStock.value.map(p => p.id);

    await axios.post('/carrito/borrar-stock', {
      producto_ids: productoIds
    }, {
      headers: { Authorization: `Bearer ${token}` }
    });

    // Actualiza el carrito
    await cargarCarrito();

    // Cerrar modal y mostrar mensaje
    mostrarModalSinStock.value = false;
    Swal.fire({
      icon: 'success',
      title: 'Productos eliminados',
      text: 'Se han eliminado los productos sin stock de tu carrito.',
      timer: 2000,
      showConfirmButton: false,
      toast: true,
      position: 'top-end'
    });

    // Emitir evento para actualizar contador en App.vue
    window.dispatchEvent(new Event('carrito-actualizado'));

  } catch (error) {
    console.error('Error eliminando productos sin stock:', error);
    Swal.fire({
      icon: 'error',
      title: 'Error',
      text: 'No se pudieron eliminar los productos sin stock.',
    });
  }
};


const comprobarYMostrarPago = async () => {
  const resultado = await validarStock()

  if (resultado.valid) {
    mostrarModalPago.value = true
  } else {
    productosSinStock.value = resultado.sinStock
    mostrarModalSinStock.value = true
  }
}

const procesarPago = async () => {
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
  try {
    const details = await actions.order.capture();

    const productos = productosCarrito.value.map((item) => ({
      id: item.id,
      cantidad: item.pivot.cantidad,
      precio: item.precio,
    }));

    const usuarioDni = localStorage.getItem('userDni');
    if (!usuarioDni) {
      Swal.fire({ icon: 'error', title: 'Error', text: 'No se encontró el DNI del usuario' });
      return;
    }

    const response = await axios.post('/crear-pedido', {
      productos,
      metodo_pago: 'paypal',
      usuario_dni: usuarioDni,
      payment_details: details,
    });

    // 🔥 Vaciar carrito visualmente
    productosCarrito.value = []
    carritoCantidad.value = 0

    // 🔥 Cerrar modal
    mostrarModalPago.value = false;
    mostrarBotonPaypal.value = false;
    metodoSeleccionado.value = '';

    // ✅ Confirmación al usuario
    Swal.fire({
      icon: 'success',
      title: '¡Gracias por su compra!',
      text: `Su número de pedido es ${response.data.pedido_id}. Espere a la confirmación del pedido.`,
      confirmButtonText: 'Cerrar'
    });

    // 🔄 Actualizar estado global si se usa evento
    window.dispatchEvent(new Event('carrito-actualizado'));

  } catch (error) {
    console.error('Error procesando el pago:', error);
    Swal.fire({
      icon: 'error',
      title: 'Error',
      text: 'Hubo un problema con el pago.',
    });
  }
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
    const token = localStorage.getItem('token')
    await axios.delete(`/carrito/${productoId}`, {
      headers: { Authorization: `Bearer ${token}` }
    })
    await cargarCarrito()

    // Emitir evento para que App.vue actualice el contador
    window.dispatchEvent(new Event('carrito-actualizado'))

    // Mostrar SweetAlert de eliminación
    Swal.fire({
      toast: true,
      position: 'top-start',
      icon: 'info',
      title: 'Producto eliminado del carrito',
      showConfirmButton: false,
      timer: 2000,
      timerProgressBar: true
    })
  } catch (error) {
    console.error('Error al eliminar producto', error)
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

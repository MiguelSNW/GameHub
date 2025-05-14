<template>
  <div>
    <!-- Mostrar pantalla de carga mientras se carga el producto -->
    <LoadingScreen v-if="cargandoProducto" class="fixed inset-0 bg-black bg-opacity-80 z-50" />

    <!-- Contenido del producto solo si ya cargó -->
    <div v-else class="max-w-4xl mx-auto p-4">
      <img
        :src="`/${producto.imagen}`"
        alt="Carátula"
        class="w-full max-h-96 object-contain mb-4"
      />

      <h1 class="text-3xl font-bold mb-2">{{ producto.nombre }}</h1>
      <p class="text-gray-600 text-lg mb-2">{{ producto.descripcion }}</p>
      <p class="text-indigo-700 text-xl font-bold mb-8">
        Fecha de lanzamiento: {{ producto.fecha_lanz }}
      </p>

      <p class="text-3xl font-bold">
        {{ producto.precio }}€
        <span
          class="ml-4 px-3 py-1 rounded-full text-white text-sm"
          :class="esPrecompra ? 'bg-violet-950' : 'bg-indigo-700'"
        >
          <button @click="añadirAlCarrito">
            {{ esPrecompra ? '¡Precompra YA!' : '¡Compra YA!' }}
          </button>
        </span>
      </p>

      <p v-if="mensaje" style="color: green; margin-top: 10px;">{{ mensaje }}</p>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'
import LoadingScreen from '@/components/LoadingScreen.vue'
import Swal from 'sweetalert2' 
import 'sweetalert2/dist/sweetalert2.min.css'

const producto = ref({})
const route = useRoute()
const router = useRouter()

const mensaje = ref('')
const cargando = ref(false)

const cargandoProducto = ref(true)

const esPrecompra = computed(() => {
  if (!producto.value.fecha_lanz) return false
  const hoy = new Date()
  const fechaLanz = new Date(producto.value.fecha_lanz)
  return fechaLanz > hoy
})

onMounted(async () => {
  try {
    const res = await axios.get(`/productos/${route.params.id}`)
    producto.value = res.data
  } catch (error) {
    console.error('Error al cargar el producto:', error)
  } finally {
    cargandoProducto.value = false // cuando termina, oculta el spinner
  }
})

const añadirAlCarrito = async () => {
  const token = localStorage.getItem('token')
  if (!token) {
    mensaje.value = 'Debes iniciar sesión para añadir al carrito.'
    setTimeout(() => {
      router.push('/login')
    }, 1500)
    return
  }

  cargando.value = true

  try {
    await axios.post(
      '/carrito',
      {
        producto_id: producto.value.id,
        cantidad: 1
      },
      {
        headers: {
          Authorization: `Bearer ${token}`
        }
      }
    )
    window.dispatchEvent(new Event('carrito-actualizado'))
    Swal.fire({
  icon: 'success',
  title: 'Añadido al carrito',
  text: `${producto.value.nombre} se ha añadido correctamente.`,
  timer: 2000,
  showConfirmButton: false,
  position: 'top-start',
  toast: true
})
  
  } catch (error) {
    console.error('Error al añadir al carrito:', error)
    mensaje.value = 'No se pudo añadir al carrito'
  } finally {
    cargando.value = false
    setTimeout(() => (mensaje.value = ''), 3000)
  }
}
</script>
<template>
 <h1 class="titulo text-white text-4xl font-bold text-center mt-8">Gestión de Productos</h1>

<!-- Contenedor del botón -->
 <!-- Filtro por nombre -->
<!-- Filtro por nombre -->
<div class="w-full flex justify-start mt-4 ml-4">
  <input
    v-model="filtroNombre"
    type="text"
    placeholder="Buscar producto por nombre..."
    class="p-2 border border-gray-300 rounded w-64"
  />
</div>
<div class="w-full flex justify-start mt-4">
  <button @click="openInsertModal" class="ml-4 flex items-center gap-2 bg-violet-700 hover:bg-violet-800 text-white px-4 py-2 rounded shadow">
    <i class="pi pi-user-plus text-lg"></i>
    <span class="text-sm">Añadir Producto</span>
  </button>
</div>

<div class="table-container relative w-full mt-4">
    
  <table class="table w-full table-auto shadow-lg rounded-lg bg-white">
    <thead class="bg-gray-800 text-white">
      <tr>
        <th class="py-4 px-4 text-sm border border-black">Imagen</th>
        <th class="py-4 px-4 text-sm border border-black">Nombre</th>
        <th class="py-4 px-4 text-sm border border-black">Precio</th>
        <th class="py-4 px-4 text-sm border border-black">Stock</th>
        <th class="py-4 px-4 text-sm border border-black">Plataforma</th>
        <th class="py-4 px-4 text-sm border border-black">Fecha Lanzamiento</th>
        <th class="py-4 px-4 text-sm border border-black text-center">Acciones</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="producto in paginatedProductos" :key="producto.id">
        <td class="py-3 px-4 border border-black">
          <img :src="getRutaImagen(producto.imagen)" alt="Producto" class="w-16 h-16 object-contain mx-auto" />
        </td>
        <td class="py-3 px-4 text-sm border border-black">{{ producto.nombre }}</td>
        <td class="py-3 px-4 text-sm border border-black">{{ producto.precio }} €</td>
        <td class="py-3 px-4 text-sm border border-black">{{ producto.stock }}</td>
        <td class="py-3 px-4 text-sm border border-black">{{ obtenerNombrePlataforma(producto.plataforma_id) }}</td>
        <td class="py-3 px-4 text-sm border border-black">{{ formatFecha(producto.fecha_lanz) }}</td>
       <td class="py-3 px-4 text-sm border border-black text-center">
  <button @click="abrirModalEditar(producto)" title="Editar">
    <i class="pi pi-pencil text-green-600 text-lg hover:text-green-800"></i>
  </button>
  <button @click="eliminarProducto(producto)" title="Eliminar" class="ml-2">
    <i class="pi pi-times text-red-600 text-lg hover:text-red-800"></i>
  </button>
</td>
      </tr>
    </tbody>
  </table>



    <!-- Paginación -->
    <div class="flex justify-center items-center space-x-4 mt-6">
      <button @click="paginaAnterior" :disabled="paginaActual === 1"
        class="bg-indigo-700 text-white py-2 px-4 rounded disabled:bg-gray-300 text-sm">
        Anterior
      </button>
      <span class="text-white text-xl">Página {{ paginaActual }} de {{ totalPaginas }}</span>
      <button @click="paginaSiguiente" :disabled="paginaActual === totalPaginas"
        class="bg-indigo-700 text-white py-2 px-4 rounded disabled:bg-gray-300 text-sm">
        Siguiente
      </button>
    </div>
  </div>



<!-- Modal Crear Producto -->
<div v-if="mostrarModalInsertar" class="fixed inset-0 bg-black bg-opacity-60 flex items-center justify-center z-50">
  <div class="bg-white rounded-lg shadow-lg w-full max-w-2xl p-6">
    <h2 class="text-2xl font-bold mb-4">Nuevo Producto</h2>

    <form @submit.prevent="guardarNuevoProducto">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
        
        <!-- Nombre -->
        <div>
          <label class="block text-sm font-semibold">Nombre</label>
          <input v-model="productoNuevo.nombre" type="text" class="w-full p-2 border rounded" />
          <p v-if="errors.nombre" class="text-red-500 text-sm mt-1">{{ errors.nombre[0] }}</p>
        </div>

        <!-- Precio -->
        <div>
          <label class="block text-sm font-semibold">Precio</label>
          <input v-model.number="productoNuevo.precio" type="number" step="0.01" class="w-full p-2 border rounded" />
          <p v-if="errors.precio" class="text-red-500 text-sm mt-1">{{ errors.precio[0] }}</p>
        </div>

        <!-- Stock -->
        <div>
          <label class="block text-sm font-semibold">Stock</label>
          <input v-model.number="productoNuevo.stock" type="number" class="w-full p-2 border rounded" />
          <p v-if="errors.stock" class="text-red-500 text-sm mt-1">{{ errors.stock[0] }}</p>
        </div>

        <!-- Fecha Lanzamiento -->
        <div>
          <label class="block text-sm font-semibold">Fecha Lanzamiento</label>
          <input v-model="productoNuevo.fecha_lanz" type="date" class="w-full p-2 border rounded" />
          <p v-if="errors.fecha_lanz" class="text-red-500 text-sm mt-1">{{ errors.fecha_lanz[0] }}</p>
        </div>

        <!-- Valoración (Admin) -->
        <div>
          <label class="block text-sm font-semibold">Valoración (Admin)</label>
          <input v-model.number="productoNuevo.valoracion" type="number" min="0" max="10" step="0.1" class="w-full p-2 border rounded" />
          <p v-if="errors.valoracion" class="text-red-500 text-sm mt-1">{{ errors.valoracion[0] }}</p>
        </div>

        <!-- Valoración (Usuarios) -->
        <div>
          <label class="block text-sm font-semibold">Valoración (Usuarios)</label>
          <input v-model.number="productoNuevo.valoruser" type="number" min="0" max="10" step="0.1" class="w-full p-2 border rounded" />
          <p v-if="errors.valoruser" class="text-red-500 text-sm mt-1">{{ errors.valoruser[0] }}</p>
        </div>

        <!-- Categoría -->
        <div>
          <label class="block text-sm font-semibold">Categoría</label>
          <select v-model="productoNuevo.categoria_id" class="w-full p-2 border rounded">
            <option disabled value="">Seleccione una categoría</option>
            <option v-for="categoria in categorias" :key="categoria.id" :value="categoria.id">
              {{ categoria.nombre }}
            </option>
          </select>
          <p v-if="errors.categoria_id" class="text-red-500 text-sm mt-1">{{ errors.categoria_id[0] }}</p>
        </div>

        <!-- Plataforma -->
        <div>
          <label class="block text-sm font-semibold">Plataforma</label>
          <select v-model="productoNuevo.plataforma_id" class="w-full p-2 border rounded">
            <option disabled value="">Seleccione una plataforma</option>
            <option v-for="plataforma in plataformas" :key="plataforma.plataforma_id" :value="plataforma.plataforma_id">
              {{ plataforma.plataforma }}
            </option>
          </select>
          <p v-if="errors.plataforma_id" class="text-red-500 text-sm mt-1">{{ errors.plataforma_id[0] }}</p>
        </div>

        <!-- Descripción -->
        <div class="col-span-2">
          <label class="block text-sm font-semibold">Descripción</label>
          <textarea v-model="productoNuevo.descripcion" class="w-full p-2 border rounded" rows="3"></textarea>
          <p v-if="errors.descripcion" class="text-red-500 text-sm mt-1">{{ errors.descripcion[0] }}</p>
        </div>

        <!-- Imagen -->
        <div class="col-span-2">
          <label class="block text-sm font-semibold">Imagen</label>
          <input type="file" @change="handleImagenNueva" class="w-full p-2 border rounded" />
          <img v-if="previewImagenNueva" :src="previewImagenNueva" alt="Vista previa" class="w-24 h-24 mt-2 object-contain" />
          <p v-if="errors.imagen" class="text-red-500 text-sm mt-1">{{ errors.imagen[0] }}</p>
        </div>
      </div>

      <!-- Botones -->
      <div class="mt-6 flex justify-end space-x-2">
        <button @click="mostrarModalInsertar = false" type="button"
          class="bg-gray-200 px-4 py-2 rounded hover:bg-gray-300 text-gray-800">
          Cancelar
        </button>
        <button type="submit"
          class="bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700">
          Guardar Producto
        </button>
      </div>
    </form>
  </div>
</div>



  <!-- Modal Edición Producto -->
<div v-if="mostrarModalEditar" class="fixed inset-0 bg-black bg-opacity-60 flex items-center justify-center z-50">
  <div class="bg-white rounded-lg shadow-lg w-full max-w-2xl p-6">
    <h2 class="text-2xl font-bold mb-4">Editar Producto</h2>

    <form @submit.prevent="guardarCambiosProducto">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <label class="block text-sm font-semibold">Nombre</label>
          <input v-model="productoEditado.nombre" type="text" class="w-full p-2 border rounded" />
        </div>

        <div>
          <label class="block text-sm font-semibold">Precio</label>
          <input v-model.number="productoEditado.precio" type="number" step="0.01" class="w-full p-2 border rounded" />
        </div>

        <div>
          <label class="block text-sm font-semibold">Stock</label>
          <input v-model.number="productoEditado.stock" type="number" class="w-full p-2 border rounded" />
        </div>

        <div>
          <label class="block text-sm font-semibold">Fecha Lanzamiento</label>
          <input v-model="productoEditado.fecha_lanz" type="date" class="w-full p-2 border rounded" />
        </div>

        <div>
          <label class="block text-sm font-semibold">Valoración (Admin)</label>
          <input v-model.number="productoEditado.valoracion" type="number" min="0" max="10" step="0.1" class="w-full p-2 border rounded" />
        </div>

        <div>
          <label class="block text-sm font-semibold">Valoración (Usuarios)</label>
          <input v-model.number="productoEditado.valoruser" type="number" min="0" max="10" step="0.1" class="w-full p-2 border rounded" />
        </div>

        <!-- Categoría -->
<div>
  <label class="block text-sm font-semibold">Categoría</label>
  <select v-model="productoEditado.categoria_id" class="w-full p-2 border rounded">
    <option disabled value="">Seleccione una categoría</option>
    <option v-for="categoria in categorias" :key="categoria.id" :value="categoria.id">
      {{ categoria.nombre }}
    </option>
  </select>
</div>

<!-- Plataforma -->
<div>
  <label class="block text-sm font-semibold">Plataforma</label>
  <select v-model="productoEditado.plataforma_id" class="w-full p-2 border rounded">
    <option disabled value="">Seleccione una plataforma</option>
   <option v-for="plataforma in plataformas" :key="plataforma.plataforma_id" :value="plataforma.plataforma_id">
  {{ plataforma.plataforma }}
</option>
  </select>
</div>

        <div class="col-span-2">
          <label class="block text-sm font-semibold">Descripción</label>
          <textarea v-model="productoEditado.descripcion" class="w-full p-2 border rounded" rows="3"></textarea>
        </div>

        <!-- Input archivo imagen -->
<div class="col-span-2">
  <label class="block text-sm font-semibold">Imagen</label>
  <input type="file" @change="handleImagen" class="w-full p-2 border rounded" />
  <img :src="previewImagen" alt="Vista previa" class="w-24 h-24 mt-2 object-contain" />
</div>
      </div>

      <div class="mt-6 flex justify-end space-x-2">
        <button @click="mostrarModalEditar = false" type="button"
          class="bg-gray-200 px-4 py-2 rounded hover:bg-gray-300 text-gray-800">
          Cancelar
        </button>
        <button type="submit"
          class="bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700">
          Guardar Cambios
        </button>
      </div>
    </form>
  </div>
</div>

</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import axios from 'axios'
import Swal from 'sweetalert2'

const errors = ref({})
const productos = ref([])
const productosPorPagina = 5
const paginaActual = ref(1)
const mostrarModalEditar = ref(false)
const productoEditado = ref({})
const archivoImagen = ref(null)
const previewImagen = ref('')
const mostrarModalInsertar = ref(false)
const productoNuevo = ref({
  nombre: '',
  descripcion: '',
  precio: 0,
  stock: 0,
  fecha_lanz: '',
  valoracion: 0,
  valoruser: 0,
  categoria_id: '',
  plataforma_id: '',
})
const filtroNombre = ref('')
// Filtro
const productosFiltrados = computed(() => {
  return productos.value.filter(producto =>
    producto.nombre.toLowerCase().includes(filtroNombre.value.toLowerCase())
  )
})
const obtenerNombrePlataforma = (id) => {
  const plataforma = plataformas.value.find(p => p.plataforma_id === id)
  return plataforma ? plataforma.plataforma : 'Desconocida'
}

const imagenNueva = ref(null)
const previewImagenNueva = ref('')
const openInsertModal = () => {
  productoNuevo.value = {
    nombre: '',
    descripcion: '',
    precio: 0,
    stock: 0,
    fecha_lanz: '',
    valoracion: 0,
    valoruser: 0,
    categoria_id: '',
    plataforma_id: '',
  }
  imagenNueva.value = null
  previewImagenNueva.value = ''
  mostrarModalInsertar.value = true
}
const handleImagenNueva = (e) => {
  imagenNueva.value = e.target.files[0]
  previewImagenNueva.value = URL.createObjectURL(imagenNueva.value)
}
const guardarNuevoProducto = async () => {
  try {
    errors.value = {} // Limpiar errores anteriores

    const formData = new FormData()
    Object.entries(productoNuevo.value).forEach(([key, value]) => {
      formData.append(key, value)
    })

    if (imagenNueva.value) {
      formData.append('imagen', imagenNueva.value)
    }

    await axios.post('/productos', formData, {
      headers: { 'Content-Type': 'multipart/form-data' }
    })

    Swal.fire('Éxito', 'Producto añadido correctamente.', 'success')
    mostrarModalInsertar.value = false
    await obtenerProductos()
  } catch (error) {
    if (error.response && error.response.status === 422) {
      // Mostrar errores de validación
      errors.value = error.response.data.errors
    } else {
      console.error('Error al insertar producto:', error)
      Swal.fire('Error', 'No se pudo insertar el producto.', 'error')
    }
  }
}

const handleImagen = (e) => {
  archivoImagen.value = e.target.files[0]
  previewImagen.value = URL.createObjectURL(archivoImagen.value)
}

// Abrir modal edición con datos
const abrirModalEditar = (producto) => {
  productoEditado.value = { ...producto } // clonar datos
  previewImagen.value = getRutaImagen(producto.imagen) // <-- Aquí se carga la imagen antigua
  mostrarModalEditar.value = true
}
const categorias = ref([])
const plataformas = ref([])

const obtenerProductos = async () => {
  try {
    const res = await axios.get('/productos')
    productos.value = res.data
  } catch (error) {
    console.error('Error al cargar productos:', error)
  }
}

const cargarCategoriasYPlataformas = async () => {
  try {
    const [resCategorias, resPlataformas] = await Promise.all([
      axios.get('/categorias'),
      axios.get('/plataformas'),
    ])
    categorias.value = resCategorias.data
    plataformas.value = resPlataformas.data
  } catch (error) {
    console.error('Error al cargar categorías o plataformas:', error)
  }
}

onMounted(async () => {
  await obtenerProductos()
  await cargarCategoriasYPlataformas()
})

// Guardar cambios modal edición
const guardarCambiosProducto = async () => {
  try {
    const formData = new FormData()
    formData.append('nombre', productoEditado.value.nombre)
    formData.append('descripcion', productoEditado.value.descripcion)
    formData.append('precio', productoEditado.value.precio)
    formData.append('stock', productoEditado.value.stock)
    formData.append('fecha_lanz', productoEditado.value.fecha_lanz)
    formData.append('valoracion', productoEditado.value.valoracion)
    formData.append('valoruser', productoEditado.value.valoruser)
    formData.append('categoria_id', productoEditado.value.categoria_id)
    formData.append('plataforma_id', productoEditado.value.plataforma_id)

    if (archivoImagen.value) {
      formData.append('imagen', archivoImagen.value)
    }

    await axios.post(`/productos/${productoEditado.value.id}/actualizar`, formData, {
      headers: { 'Content-Type': 'multipart/form-data' }
    })

    Swal.fire('Éxito', 'Producto actualizado', 'success')
    mostrarModalEditar.value = false
    await obtenerProductos()
  } catch (error) {
    console.error('Error al actualizar producto:', error)
    Swal.fire('Error', 'No se pudo actualizar el producto.', 'error')
  }
}

const getRutaImagen = (path) => {
  return `/${path}` // como ya está en la BD como 'images/...'
}

const formatFecha = (fecha) => {
  return new Date(fecha).toLocaleDateString()
}

onMounted(async () => {
  try {
    const res = await axios.get('/productos')
    productos.value = res.data
  } catch (error) {
    console.error('Error al cargar productos:', error)
  }
})
// Paginación basada en productosFiltrados
const paginatedProductos = computed(() => {
  const inicio = (paginaActual.value - 1) * productosPorPagina
  return productosFiltrados.value.slice(inicio, inicio + productosPorPagina)
})

const totalPaginas = computed(() => {
  return Math.max(1, Math.ceil(productosFiltrados.value.length / productosPorPagina))
})

const paginaAnterior = () => {
  if (paginaActual.value > 1) paginaActual.value--
}

const paginaSiguiente = () => {
  if (paginaActual.value < totalPaginas.value) paginaActual.value++
}

const eliminarProducto = async (producto) => {
  const confirmacion = await Swal.fire({
    title: '¿Eliminar producto?',
    text: `¿Estás seguro de eliminar "${producto.nombre}"? Esta acción no se puede deshacer.`,
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#6d2e9e',
    cancelButtonColor: '#cec6d5',
    confirmButtonText: 'Sí, eliminar',
    cancelButtonText: 'Cancelar'
  })

  if (confirmacion.isConfirmed) {
    try {
      await axios.delete(`/productos/${producto.id}/eliminar`)
      Swal.fire('Eliminado', 'Producto eliminado correctamente.', 'success')
      await obtenerProductos()
    } catch (error) {
      console.error('Error al eliminar producto:', error)
      Swal.fire('Error', 'No se pudo eliminar el producto.', 'error')
    }
  }
}
</script>

<style scoped>
.table-container {
  overflow-x: auto;
}
</style>

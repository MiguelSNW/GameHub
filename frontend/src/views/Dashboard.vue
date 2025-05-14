<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'
import axios from 'axios'
import { Swiper, SwiperSlide } from 'swiper/vue'
import { Autoplay, Pagination, Navigation } from 'swiper/modules'
import 'swiper/css'
import 'swiper/css/pagination'
import 'swiper/css/navigation'
import { useRouter } from 'vue-router'
import LoadingScreen from '@/components/LoadingScreen.vue'

const router = useRouter()

// Datos para los carruseles
const mejoresValorados = ref([])
const proximosLanzamientos = ref([])

// Variable para el loader
const isLoading = ref(true)

// Dropdown de búsqueda
const terminoBusqueda = ref('')
const resultados = ref([])
const mostrarDropdown = ref(false)
const buscadorRef = ref(null)

const handleClickOutside = (event) => {
  if (buscadorRef.value && !buscadorRef.value.contains(event.target)) {
    mostrarDropdown.value = false
  }
}

onMounted(() => {
  document.addEventListener('click', handleClickOutside)
})
onBeforeUnmount(() => {
  document.removeEventListener('click', handleClickOutside)
})

// Buscar en tiempo real
const buscarEnTiempoReal = async () => {
  const termino = terminoBusqueda.value.trim()
  if (termino.length < 2) {
    resultados.value = []
    mostrarDropdown.value = false
    return
  }
  if (!termino) {
    resultados.value = []
    mostrarDropdown.value = false
    return
  }
  try {
    const res = await axios.get(`/productos/buscar?q=${encodeURIComponent(termino)}`)
    resultados.value = res.data
    mostrarDropdown.value = true
  } catch (err) {
    console.error('Error buscando en tiempo real:', err)
    resultados.value = []
    mostrarDropdown.value = false
  }
}

// Ir al detalle de producto
const irADetalle = (id) => {
  router.push(`/producto/${id}`)
  resetBuscador()
}

// Ir a la vista completa de la búsqueda
const irABusqueda = () => {
  if (terminoBusqueda.value.trim()) {
    router.push({ name: 'Busqueda', query: { q: terminoBusqueda.value } })
    resetBuscador()
  }
}

const resetBuscador = () => {
  terminoBusqueda.value = ''
  resultados.value = []
  mostrarDropdown.value = false
}

// Categorías
const categorias = [
  { nombre: 'PlayStation 5', imagen: '/images/categorias/ps5.jpg', ruta: '/categoria/ps5' },
  { nombre: 'Nintendo Switch', imagen: '/images/categorias/switch.jpg', ruta: '/categoria/nintendo-switch' },
  { nombre: 'PlayStation 4', imagen: '/images/categorias/ps4.jpg', ruta: '/categoria/ps4' },
  { nombre: 'Xbox Series', imagen: '/images/categorias/xbox.jpg', ruta: '/categoria/xbox' },
  { nombre: 'Consolas', imagen: '/images/categorias/consolas.jpg', ruta: '/categoria/consolas' },
  { nombre: 'PC', imagen: '/images/categorias/pc.jpg', ruta: '/categoria/pc' },
  { nombre: 'Merchandising', imagen: '/images/categorias/merchandising.jpg', ruta: '/categoria/merchandising' },
  { nombre: 'Cómics', imagen: '/images/categorias/comic.jpg', ruta: '/categoria/comics' }
]

// Productos destacados y próximos lanzamientos
onMounted(() => {
  axios.get('/productos/mejoresval')
    .then(res => {
      mejoresValorados.value = res.data
    })
    .catch(err => {
      console.error('Error al cargar productos mejor valorados:', err)
    })

  axios.get('/productos/proxlanzamientos')
    .then(res => {
      proximosLanzamientos.value = res.data
    })
    .catch(err => {
      console.error('Error al cargar productos de próximo lanzamiento:', err)
    })

  // Simular carga: Mostrar el loader por 4 segundos
  setTimeout(() => {
    isLoading.value = false
  }, 4000)
})
</script>

<template>
  <div class="min-h-screen">

    <section class="max-w-6xl mx-auto mb-8 py-8 px-4">
      <h2 class="text-xl font-bold text-violet-700 mb-4">NOVEDADES EN GAMEHUB</h2>

      <Swiper :modules="[Autoplay, Pagination, Navigation]" :slides-per-view="1" :loop="true"
        :pagination="{ clickable: true }" :navigation="true" :autoplay="{ delay: 5000, disableOnInteraction: false }"
        :simulate-touch="false" class="h-[600px] rounded overflow-hidden shadow mb-8">
        <!-- Slide 1 -->
        <SwiperSlide>
          <router-link to="/producto/14">
            <img src="/images/swiper/slide1.jpg" alt="Slide 1" class="w-full h-full object-contain cursor-pointer" />
          </router-link>
        </SwiperSlide>

        <!-- Slide 2 -->
        <SwiperSlide>
          <router-link to="/producto/16">
            <img src="/images/swiper/slide2.jpg" alt="Slide 2" class="w-full h-full object-contain cursor-pointer" />
          </router-link>
        </SwiperSlide>

        <!-- Slide 3 -->
        <SwiperSlide>
          <router-link to="/categoria/xbox">
            <img src="/images/swiper/slide3.jpg" alt="Slide 3" class="w-full h-full object-contain cursor-pointer" />
          </router-link>
        </SwiperSlide>
      </Swiper>

      <!-- BUSCADOR -->
      <div ref="buscadorRef" class="relative w-full md:w-96 mx-auto mb-6 z-0">
        <input v-model="terminoBusqueda" @input="buscarEnTiempoReal" @keyup.enter="irABusqueda" type="text"
          placeholder="🔍 Busca tu próximo juego favorito..."
          class="w-full px-5 py-3 rounded-full bg-gray-800 text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-violet-600 shadow-md transition" />

        <!-- Dropdown -->
        <ul v-if="resultados.length && mostrarDropdown"
          class="absolute top-full left-0 w-full bg-gray-800 text-white rounded-b-lg shadow-lg max-h-64 overflow-y-auto">
          <li v-for="producto in resultados" :key="producto.id" class="px-4 py-2 hover:bg-violet-700 cursor-pointer"
            @click="irADetalle(producto.id)">
            {{ producto.nombre }}
          </li>
        </ul>
      </div>
    </section>

    <!-- Artículos por salir -->
    <div class="max-w-7xl mx-auto px-4 mb-8">
      <div class="flex justify-between items-center mb-2 ml-2">
        <h2 class="text-xl font-bold text-violet-700">¡PRÓXIMOS LANZAMIENTOS!</h2>
        <a href="/productos" class="text-violet-700 hover:text-blue-800 text-xl font-bold transition-colors">
          VER TODOS LOS BOMBAZOS | >
        </a>
      </div>

      <section class="border border-indigo-500 rounded px-4 py-8">
  <!-- Contenedor con alto mínimo y centrado para el loader -->
  <div class="min-h-[400px] flex items-center justify-center">
    <template v-if="isLoading">
      <LoadingScreen />
    </template>
    <template v-else>
      <!-- Si ya cargó, se muestra el listado en grid -->
      <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-5 gap-6">
        <router-link
          v-for="producto in proximosLanzamientos"
          :key="producto.id"
          :to="`/producto/${producto.id}`"
          class="block"
        >
          <div class="border border-slate-900 bg-indigo-950 p-4 rounded shadow transition-transform transform hover:-translate-y-1 hover:shadow-lg h-[400px] flex flex-col justify-between">
            <img :src="`/${producto.imagen}`" alt="Carátula del juego"
                 class="h-[250px] w-full object-contain mb-4 rounded" />
            <div>
              <h3 class="text-lg font-semibold text-violet-700 hover:text-blue-800 transition-colors">
                {{ producto.nombre }}
              </h3>
              <p class="text-gray-700">{{ producto.precio }}€</p>
            </div>
          </div>
        </router-link>
      </div>
    </template>
  </div>
</section>
    </div>



    <!-- Banner -->
    <section class="bg-violet-950 text-white py-8 text-center mb-8">
      <h2 class="text-3xl font-bold mb-2 tracking-wide">¿TIENES CONSOLAS ANTIGUAS?</h2>
      <p class="text-lg mb-4">Nosotros te la compramos a un precio suculento.</p>
      <a href="/novedades"
        class="inline-block bg-white text-violet-950 font-semibold px-6 py-2 rounded hover:bg-gray-100 transition">
        Ver más
      </a>
    </section>





    <!-- Los artículos mejores valorados -->
    <div class="max-w-7xl mx-auto px-4">
      <div class="flex justify-between items-center mb-2 ml-2">
        <h2 class="text-xl font-bold text-violet-700">¡ARTÍCULOS MEJORES VALORADOS!</h2>
        <a href="/productos" class="text-violet-700 hover:text-blue-800 text-xl font-bold transition-colors">
          VER TODOS NUESTROS ARTÍCULOS | >
        </a>
      </div>

      <section class="border border-indigo-500 rounded px-4 py-8 mb-8">
  <!-- Contenedor con alto mínimo y centramiento -->
  <div class="min-h-[400px] flex items-center justify-center">
    <template v-if="isLoading">
      <!-- Se muestra el loading screen centrado -->
      <LoadingScreen />
    </template>
    <template v-else>
      <!-- Si no está cargando, se muestra el listado -->
      <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-5 gap-6">
        <router-link 
          v-for="producto in mejoresValorados" 
          :key="producto.id" 
          :to="`/producto/${producto.id}`" 
          class="block"
        >
          <div class="bg-white p-4 rounded shadow transition-transform transform hover:-translate-y-1 hover:shadow-lg h-[400px] flex flex-col justify-between">
            <img :src="`/${producto.imagen}`" alt="Carátula del juego"
                 class="h-[250px] w-full object-contain mb-4 rounded" />
            <div>
              <h3 class="text-lg font-semibold text-violet-700 hover:text-blue-800 transition-colors">
                {{ producto.nombre }}
              </h3>
              <p class="text-gray-700">{{ producto.precio }}€</p>
            </div>
          </div>
        </router-link>
      </div>
    </template>
  </div>
</section>


    </div>

    <section class="bg-violet-950 text-white py-8 text-center mb-8">
      <h2 class="text-3xl font-bold mb-2 tracking-wide">¿TIENES ALGÚN PROBLEMA TÉCNICO?</h2>
      <p class="text-lg mb-4">Nosotros te contactamos en el momento.</p>
      <a href="/novedades"
        class="inline-block bg-white text-violet-950 font-semibold px-6 py-2 rounded hover:bg-gray-100 transition">
        Abrir asistente virtual
      </a>
    </section>
  </div>



  <!-- Artículos destacados -->
  <div class="max-w-7xl mx-auto px-4 mb-8">
    <div class="flex justify-between items-center mb-2 ml-2">
      <h2 class="text-xl font-bold text-violet-700">¡ARTÍCULOS MÁS VENDIDOS!</h2>
      <a href="/productos" class="text-violet-700 hover:text-blue-800 text-xl font-bold transition-colors">
        VER TODOS NUESTROS ARTÍCULOS | >
      </a>
    </div>

    <section class="border border-indigo-500 rounded px-4 py-8">
  <!-- Contenedor con alto mínimo y centrado -->
  <div class="min-h-[400px] flex items-center justify-center">
    <template v-if="isLoading">
      <LoadingScreen />
    </template>
    <template v-else>
      <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-5 gap-6">
        <router-link 
          v-for="producto in proximosLanzamientos" 
          :key="producto.id" 
          :to="`/producto/${producto.id}`" 
          class="block"
        >
          <div class="bg-white p-4 rounded shadow transition-transform transform hover:-translate-y-1 hover:shadow-lg h-[400px] flex flex-col justify-between">
            <img 
              :src="`/${producto.imagen}`" 
              alt="Carátula del juego" 
              class="h-[250px] w-full object-contain mb-4 rounded" 
            />
            <div>
              <h3 class="text-lg font-semibold text-violet-700 hover:text-blue-800 transition-colors">
                {{ producto.nombre }}
              </h3>
              <p class="text-gray-700">{{ producto.precio }}€</p>
            </div>
          </div>
        </router-link>
      </div>
    </template>
  </div>
</section>

    <section class="max-w-7xl mx-auto px-4 py-8 mb-8">
      <h2 class="text-xl font-bold text-violet-700 mb-8">EXPLORA POR CATEGORÍAS</h2>

      <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-4">
        <router-link v-for="categoria in categorias" :key="categoria.nombre" :to="categoria.ruta"
          class="relative group overflow-hidden rounded shadow-lg cursor-pointer">
          <img :src="categoria.imagen" :alt="categoria.nombre"
            class="w-full h-40 object-cover transform group-hover:scale-105 transition duration-300" />
          <div class="absolute top-2 left-2 text-sm text-white font-bold">GAMEHUB</div>
          <div class="absolute bottom-2 right-2 text-white font-bold text-lg drop-shadow">
            {{ categoria.nombre }}
          </div>
          <div class="absolute inset-0 bg-black bg-opacity-40 group-hover:bg-opacity-60 transition duration-300"></div>
        </router-link>
      </div>
    </section>
  </div>


</template>

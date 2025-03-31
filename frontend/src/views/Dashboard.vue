<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import { Swiper, SwiperSlide } from 'swiper/vue'
import { Autoplay, Pagination, Navigation } from 'swiper/modules'
import 'swiper/css'
import 'swiper/css/pagination'
import 'swiper/css/navigation'

const datos = ref({
  usuarios: 0,
  ventas: 0,
  ingresos: 0
})

const categorias = [
  {
    nombre: 'PlayStation 5',
    imagen: '/images/categorias/ps5.jpg',
    ruta: '/categoria/playstation5'
  },
  {
    nombre: 'Nintendo Switch',
    imagen: '/images/categorias/switch.jpg',
    ruta: '/categoria/nintendo-switch'
  },
  {
    nombre: 'PlayStation 4',
    imagen: '/images/categorias/ps4.jpg',
    ruta: '/categoria/playstation4'
  },
  {
    nombre: 'Xbox Series',
    imagen: '/images/categorias/xbox.jpg',
    ruta: '/categoria/xbox-series'
  },
  {
    nombre: 'Consolas',
    imagen: '/images/categorias/consolas.jpg',
    ruta: '/categoria/consolas'
  },
  {
    nombre: 'PC',
    imagen: '/images/categorias/pc.jpg',
    ruta: '/categoria/pc'
  },
  {
    nombre: 'Merchandising',
    imagen: '/images/categorias/merchandising.jpg',
    ruta: '/categoria/merchandising'
  },
  {
    nombre: 'Cómics',
    imagen: '/images/categorias/comic.jpg',
    ruta: '/categoria/comics'
  }
]

onMounted(() => {
  axios.get('http://localhost:8000/')
    .then(res => {
      datos.value = res.data
    })
    .catch(err => {
      console.error('Error al cargar dashboard:', err)
    })
})
</script>

<template>
  <div class="min-h-screen">
    
    <section class="max-w-6xl mx-auto mb-8 py-8 px-4">
  <h2 class="text-xl font-bold text-violet-700 mb-4">NOVEDADES EN GAMEHUB</h2>

  <Swiper
    :modules="[Autoplay, Pagination, Navigation]"
    :slides-per-view="1"
    :loop="true"
    :pagination="{ clickable: true }"
    :navigation="true"
    :autoplay="{ delay: 5000, disableOnInteraction: false }"
    :simulate-touch="false"
    class="h-[600px] rounded overflow-hidden shadow"
  >
    <!-- Slide 1 -->
    <SwiperSlide>
      <router-link to="/categoria/switch2">
        <img
          src="/images/swiper/slide1.jpg"
          alt="Slide 1"
          class="w-full h-full object-contain cursor-pointer"
        />
      </router-link>
    </SwiperSlide>

    <!-- Slide 2 -->
    <SwiperSlide>
      <router-link to="/categoria/ps5">
        <img
          src="/images/swiper/slide2.jpg"
          alt="Slide 2"
          class="w-full h-full object-contain cursor-pointer"
        />
      </router-link>
    </SwiperSlide>

    <!-- Slide 3 -->
    <SwiperSlide>
      <router-link to="/categoria/xbox">
        <img
          src="/images/swiper/slide3.jpg"
          alt="Slide 3"
          class="w-full h-full object-contain cursor-pointer"
        />
      </router-link>
    </SwiperSlide>
  </Swiper>
</section>


    <!-- Artículos destacados -->
    <div class="max-w-7xl mx-auto px-4 mb-8">
      <div class="flex justify-between items-center mb-2 ml-2">
      <h2 class="text-xl font-bold text-violet-700">¡ARTÍCULOS MÁS VENDIDOS!</h2>
      <a
  href="/todos-los-articulos"
  class="text-violet-700 hover:text-blue-800 text-xl font-bold transition-colors"
>
  VER TODOS NUESTROS ARTÍCULOS | >
</a>
  </div>

  <section class="border border-indigo-500 rounded px-4 py-8">

      <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-5 gap-6 " >
        <!-- Tarjeta de producto -->
        <div class="bg-white p-4 rounded shadow">
          <div class="bg-gray-300 h-32 w-full mb-4 rounded"></div>
          <h3 class="text-lg font-semibold">ART 1</h3>
          <p class="text-gray-700">20€</p>
        </div>

        <div class="bg-white p-4 rounded shadow">
          <div class="bg-gray-300 h-32 w-full mb-4 rounded"></div>
          <h3 class="text-lg font-semibold">ART 1</h3>
          <p class="text-gray-700">20€</p>
        </div>

        <div class="bg-white p-4 rounded shadow">
          <div class="bg-gray-300 h-32 w-full mb-4 rounded"></div>
          <h3 class="text-lg font-semibold">ART 1</h3>
          <p class="text-gray-700">20€</p>
        </div>

        <div class="bg-white p-4 rounded shadow">
          <div class="bg-gray-300 h-32 w-full mb-4 rounded"></div>
          <h3 class="text-lg font-semibold">ART 1</h3>
          <p class="text-gray-700">20€</p>
        </div>

        <div class="bg-white p-4 rounded shadow">
          <div class="bg-gray-300 h-32 w-full mb-4 rounded"></div>
          <h3 class="text-lg font-semibold">ART 1</h3>
          <p class="text-gray-700">20€</p>
        </div>

        
      </div>


    </section>
  </div>
  

  <section class="bg-violet-950 text-white py-8 text-center mb-8">
  <h2 class="text-3xl font-bold mb-2 tracking-wide">¿TIENES CONSOLAS ANTIGUAS?</h2>
  <p class="text-lg mb-4">Nosotros te la compramos a un precio suculento.</p>
  <a
    href="/novedades"
    class="inline-block bg-white text-violet-950 font-semibold px-6 py-2 rounded hover:bg-gray-100 transition"
  >
    Ver más
  </a>
</section>


  <!-- Los artículos mejores valorados -->
  <div class="max-w-7xl mx-auto px-4">
      <div class="flex justify-between items-center mb-2 ml-2">
      <h2 class="text-xl font-bold text-violet-700">¡ARTÍCULOS MEJORES VALORADOS!</h2>
      <a
  href="/todos-los-articulos"
  class="text-violet-700 hover:text-blue-800 text-xl font-bold transition-colors"
>
  VER TODOS NUESTROS ARTÍCULOS | >
</a>
  </div>

  <section class="border border-indigo-500 rounded px-4 py-8">

      <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-5 gap-6 " >
        <!-- Tarjeta de producto -->
        <div class="bg-white p-4 rounded shadow">
          <div class="bg-gray-300 h-32 w-full mb-4 rounded"></div>
          <h3 class="text-lg font-semibold">ART 1</h3>
          <p class="text-gray-700">20€</p>
        </div>

        <div class="bg-white p-4 rounded shadow">
          <div class="bg-gray-300 h-32 w-full mb-4 rounded"></div>
          <h3 class="text-lg font-semibold">ART 1</h3>
          <p class="text-gray-700">20€</p>
        </div>

        <div class="bg-white p-4 rounded shadow">
          <div class="bg-gray-300 h-32 w-full mb-4 rounded"></div>
          <h3 class="text-lg font-semibold">ART 1</h3>
          <p class="text-gray-700">20€</p>
        </div>

        <div class="bg-white p-4 rounded shadow">
          <div class="bg-gray-300 h-32 w-full mb-4 rounded"></div>
          <h3 class="text-lg font-semibold">ART 1</h3>
          <p class="text-gray-700">20€</p>
        </div>

        <div class="bg-white p-4 rounded shadow">
          <div class="bg-gray-300 h-32 w-full mb-4 rounded"></div>
          <h3 class="text-lg font-semibold">ART 1</h3>
          <p class="text-gray-700">20€</p>
        </div>
      </div>
    </section>

    <section class="max-w-7xl mx-auto px-4 py-8 mb-8">
    <h2 class="text-xl font-bold text-violet-700 mb-8">EXPLORA POR CATEGORÍAS</h2>

    <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-4">
      <router-link
        v-for="categoria in categorias"
        :key="categoria.nombre"
        :to="categoria.ruta"
        class="relative group overflow-hidden rounded shadow-lg cursor-pointer"
      >
        <img
          :src="categoria.imagen"
          :alt="categoria.nombre"
          class="w-full h-40 object-cover transform group-hover:scale-105 transition duration-300"
        />
        <div class="absolute top-2 left-2 text-sm text-white font-bold">GAMEHUB</div>
        <div class="absolute bottom-2 right-2 text-white font-bold text-lg drop-shadow">
          {{ categoria.nombre }}
        </div>
        <div class="absolute inset-0 bg-black bg-opacity-40 group-hover:bg-opacity-60 transition duration-300"></div>
      </router-link>
    </div>
  </section>
  </div>
  
  <section class="bg-violet-950 text-white py-8 text-center mb-8">
  <h2 class="text-3xl font-bold mb-2 tracking-wide">¿TIENES ALGÚN PROBLEMA TÉCNICO?</h2>
  <p class="text-lg mb-4">Nosotros te reparamos cualquier consola sujeta a tarifa fija.</p>
  <a
    href="/novedades"
    class="inline-block bg-white text-violet-950 font-semibold px-6 py-2 rounded hover:bg-gray-100 transition"
  >
    Ver tarifas
  </a>
</section>
  </div>

   <!-- Artículos por salir -->
   <div class="max-w-7xl mx-auto px-4 mb-8">
      <div class="flex justify-between items-center mb-2 ml-2">
      <h2 class="text-xl font-bold text-violet-700">¡PRÓXIMOS LANZAMIENTOS!</h2>
      <a
  href="/todos-los-articulos"
  class="text-violet-700 hover:text-blue-800 text-xl font-bold transition-colors"
>
  VER TODOS LOS BOMBAZOS | >
</a>
  </div>

  <section class="border border-indigo-500 rounded px-4 py-8">

      <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-5 gap-6 " >
        <!-- Tarjeta de producto -->
        <div class="bg-white p-4 rounded shadow">
          <div class="bg-gray-300 h-32 w-full mb-4 rounded"></div>
          <h3 class="text-lg font-semibold">ART 1</h3>
          <p class="text-gray-700">20€</p>
        </div>

        <div class="bg-white p-4 rounded shadow">
          <div class="bg-gray-300 h-32 w-full mb-4 rounded"></div>
          <h3 class="text-lg font-semibold">ART 1</h3>
          <p class="text-gray-700">20€</p>
        </div>

        <div class="bg-white p-4 rounded shadow">
          <div class="bg-gray-300 h-32 w-full mb-4 rounded"></div>
          <h3 class="text-lg font-semibold">ART 1</h3>
          <p class="text-gray-700">20€</p>
        </div>

        <div class="bg-white p-4 rounded shadow">
          <div class="bg-gray-300 h-32 w-full mb-4 rounded"></div>
          <h3 class="text-lg font-semibold">ART 1</h3>
          <p class="text-gray-700">20€</p>
        </div>

        <div class="bg-white p-4 rounded shadow">
          <div class="bg-gray-300 h-32 w-full mb-4 rounded"></div>
          <h3 class="text-lg font-semibold">ART 1</h3>
          <p class="text-gray-700">20€</p>
        </div>

        
      </div>


    </section>
  </div>
</template>

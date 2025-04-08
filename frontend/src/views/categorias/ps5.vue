<template>
    <div class="min-h-screen bg-cover bg-center" :style="{ backgroundImage: 'url(/images/wallpaper/PS.jpg)' }">
      <div class="flex items-center justify-center min-h-screen">
        <div class="max-w-7xl mx-auto mt-8 mb-8 bg-gray-900 p-8 rounded-lg shadow-lg">
          <div class="flex justify-between items-center mb-2 ml-2">
            <h2 class="text-xl font-bold text-violet-700">PLAYSTATION 5</h2>
          </div>
      
          <section>
            <!-- Verifica si la lista de productos está vacía -->
            <div v-if="catPs5.length === 0" class="text-center text-white">
              <p class="text-lg">¡Aún no existen juegos en nuestro inventario para esta categoría!</p>
            </div>
            
            <!-- Si hay productos, los muestra en un grid -->
            <div v-else class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-5 gap-6">
              <router-link v-for="producto in catPs5" :key="producto.id" :to="`/producto/${producto.id}`" class="block">
                <div class="bg-white p-4 rounded shadow transition-transform transform hover:-translate-y-1 hover:shadow-lg h-[400px] flex flex-col justify-between">
                  <img :src="`/${producto.imagen}`" alt="Carátula del juego" class="h-[250px] w-full object-contain mb-4 rounded" />
                  <div>
                    <h3 class="text-lg font-semibold text-violet-700 hover:text-blue-800 transition-colors">
                      {{ producto.nombre }}
                    </h3>
                    <p class="text-gray-700">{{ producto.precio }}€</p>
                  </div>
                </div>
              </router-link>
            </div>
          </section>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted } from 'vue'
  import axios from 'axios'
  
  // Datos para los carruseles
  const catPs5 = ref([])
  
  // Productos destacados
  onMounted(() => {
    axios.get('/productos/categorias/ps5')
      .then(res => {
        catPs5.value = res.data
      })
      .catch(err => {
        console.error('Error al cargar productos de PlayStation 5', err)
      })
  })
  </script>
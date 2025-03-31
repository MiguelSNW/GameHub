<template>
  <div class="min-h-screen flex flex-col bg-gray-900 text-white">
    <!-- Navbar -->
    <nav class="bg-violet-950 text-white shadow-md sticky top-0 z-50">
      <div class="px-4 py-4 flex justify-between items-center">
        <!-- IZQUIERDA: Menú + Logo -->
        <div class="flex items-center space-x-4">
          <!-- Botón de menú hamburguesa (siempre visible) -->
          <button @click.stop="toggleMenu" class="focus:outline-none">
            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
            </svg>
          </button>

          <!-- Logo -->
          <h1 class="font-[Never] text-5xl font-bold text-white tracking-widest">
            GameHub
          </h1>
        </div>

        <!-- DERECHA: Enlaces -->
        <div class="flex space-x-4">
          <router-link to="/" class="hover:bg-gray-700 px-3 py-2 rounded transition" exact-active-class="bg-gray-900">
            Inicio
          </router-link>
          <router-link to="/vistauser" class="hover:bg-gray-700 px-3 py-2 rounded transition"
            active-class="bg-gray-900">
            Lista de Usuarios
          </router-link>
        </div>
      </div>

      <!-- Menú desplegable justo debajo del botón -->
      <transition name="fade">
        <div v-if="showMenu" ref="menuRef"
          class="absolute top-full left-0 mt-2 w-56 bg-violet-900 shadow-lg rounded z-50 py-3 px-4 ml-5">
          <ul class="space-y-2">
            <li><router-link to="/categoria/nintendo-switch" @click="toggleMenu"
                class="block hover:bg-violet-500">Nintendo Switch</router-link></li>
            <li><router-link to="/categoria/nintendo-switch" @click="toggleMenu"
                class="block hover:bg-violet-500">Nintendo Switch 2</router-link></li>
            <li><router-link to="/categoria/ps4" @click="toggleMenu" class="block hover:bg-violet-500">PlayStation
                4</router-link></li>
            <li><router-link to="/categoria/ps5" @click="toggleMenu" class="block hover:bg-violet-500">PlayStation
                5</router-link></li>
            <li><router-link to="/categoria/xbox" @click="toggleMenu"
                class="block hover:bg-violet-500">Xbox</router-link></li>
            <li><router-link to="/categoria/pc" @click="toggleMenu" class="block hover:bg-violet-500">PC</router-link>
            </li>
            <li><router-link to="/categoria/comics" @click="toggleMenu"
                class="block hover:bg-violet-500">Cómics</router-link></li>
            <li><router-link to="/categoria/merchandising" @click="toggleMenu"
                class="block hover:bg-violet-500">Merchandising</router-link></li>
          </ul>
        </div>
      </transition>
    </nav>



    <!-- Contenido -->
    <main class="p-6 bg-gray-900 text-violet-700 flex-1">
      <router-view />
    </main>

    <!-- Footer -->
    <footer class="bg-violet-950 text-white py-6">
      <div class="max-w-7xl mx-auto px-4 flex flex-col md:flex-row justify-between items-center text-sm">
        <p class="mb-4 md:mb-0">
          &copy; {{ new Date().getFullYear() }} GameHub. Todos los derechos reservados.
        </p>

        <div class="flex space-x-4">
          <a href="/politica-privacidad" class="hover:underline">Política de Privacidad</a>
          <a href="/terminos" class="hover:underline">Términos y Condiciones</a>
          <a href="/contacto" class="hover:underline">Contacto</a>
        </div>
      </div>
    </footer>
  </div>
</template>



<script>
export default {
  name: 'App',
  data() {
    return {
      showMenu: false,
    }
  },
  methods: {
    toggleMenu() {
      this.showMenu = !this.showMenu
    },
    handleClickOutside(event) {
      const menu = this.$refs.menuRef
      if (menu && !menu.contains(event.target)) {
        this.showMenu = false
      }
    }
  },
  mounted() {
    document.addEventListener('click', this.handleClickOutside)
  },
  beforeUnmount() {
    document.removeEventListener('click', this.handleClickOutside)
  }
}
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>

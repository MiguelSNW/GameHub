<template>
  <div class="min-h-screen flex flex-col bg-gray-900 text-white">
    <!-- Navbar -->
    <nav class="bg-violet-950 text-white shadow-md sticky top-0 z-50">
      <div class="px-4 py-4 flex justify-between items-center">
        <!-- IZQUIERDA: Menú + Logo -->
        <div class="flex items-center space-x-4">
          <!-- Botón de menú hamburguesa (siempre visible) -->
          <button @click.stop="toggleMainMenu" class="focus:outline-none">
            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
            </svg>
          </button>
          <!-- Menú desplegable justo debajo del botón -->
          <transition name="fade">
            <div v-if="showMainMenu" ref="mainMenuRef"
              class="absolute top-full left-0 mt-2 w-56 bg-violet-900 shadow-lg rounded z-50 py-3 px-4 ml-5">
              <ul class="space-y-2">
                <li><router-link to="/categoria/nintendo-switch" @click="toggleMainMenu"
                    class="block hover:bg-violet-500">Nintendo Switch</router-link></li>
                <li><router-link to="/categoria/nintendo-switch" @click="toggleMainMenu"
                    class="block hover:bg-violet-500">Nintendo Switch 2</router-link></li>
                <li><router-link to="/categoria/ps4" @click="toggleMainMenu"
                    class="block hover:bg-violet-500">PlayStation
                    4</router-link></li>
                <li><router-link to="/categoria/ps5" @click="toggleMainMenu"
                    class="block hover:bg-violet-500">PlayStation
                    5</router-link></li>
                <li><router-link to="/categoria/xbox" @click="toggleMainMenu"
                    class="block hover:bg-violet-500">Xbox</router-link></li>
                <li><router-link to="/categoria/pc" @click="toggleMainMenu"
                    class="block hover:bg-violet-500">PC</router-link>
                </li>
                <li><router-link to="/categoria/comics" @click="toggleMainMenu"
                    class="block hover:bg-violet-500">Cómics</router-link></li>
                <li><router-link to="/categoria/merchandising" @click="toggleMainMenu"
                    class="block hover:bg-violet-500">Merchandising</router-link></li>
              </ul>
            </div>
          </transition>

          <!-- Logo -->
          <router-link to="/">
            <h1 class="font-[Never] text-5xl font-bold text-white tracking-widest">
              GameHub
            </h1>
          </router-link>
        </div>

        <!-- DERECHA: Enlaces -->
        <div>
          <div class="flex items-center justify-between space-x-4">
            <!-- Botón Inicio -->
            <router-link to="/"
              class="inline-flex items-center justify-center hover:bg-gray-700 px-4 py-2 rounded transition text-white"
              exact-active-class="bg-gray-900">
              Inicio
            </router-link>

            <!-- Opción para administradores -->
            <router-link v-if="isLoggedIn && userRole === 'admin'" to="/administrador"
              class="inline-flex items-center justify-center hover:bg-gray-700 px-4 py-2 rounded transition text-white"
              active-class="bg-gray-900">
              Panel de Control
            </router-link>


            <!-- Mostrar botón de iniciar sesión si no está logueado -->
            <div v-if="!isLoggedIn">
              <button @click="openModal"
                class="inline-flex items-center justify-center hover:bg-gray-700 px-4 py-2 rounded transition text-white">
                Iniciar Sesión
              </button>
            </div>

            
            <!-- Mostrar nombre de usuario y menú desplegable si está logueado -->
            <div v-else class="relative">
              <button @click.stop="toggleUserMenu"
                class="inline-flex items-center justify-center text-white px-4 py-2 rounded hover:bg-gray-700">
                {{ userName }}
              </button>
           
<!-- Botón del carrito (abre modal) -->
<button @click="abrirModalCarrito"
  class="relative inline-flex items-center justify-center text-white px-4 py-2 rounded hover:bg-gray-700 transition">
  🛒

  <!-- Spinner cargando -->
  <span v-if="cargandoCarrito" class="absolute -top-1 -right-1">
    <i class="pi pi-spin pi-spinner text-white text-xs bg-gray-800 rounded-full p-1"></i>
  </span>

  <!-- Contador si hay productos -->
  <span v-else-if="carritoCantidad > 0"
        class="absolute top-0 right-0 bg-red-500 text-xs text-white rounded-full px-2 py-0.5">
    {{ carritoCantidad }}
  </span>
</button>

              <!-- Menú desplegable -->
              <div v-if="showUserMenu" ref="userMenuRef"
                class="absolute right-0 mt-2 w-48 bg-gray-700 text-white rounded-lg shadow-lg">
                <router-link to="/profile" @click="toggleUserMenu" class="block px-4 py-2 hover:bg-gray-600">
                  Mis Datos
                </router-link>

                <!-- Botón Logout -->
                <button @click="logout" class="block w-full text-left px-4 py-2 hover:bg-gray-600">
                  Cerrar Sesión
                </button>
              </div>
            </div>
          </div>

          <!-- Modal de Iniciar sesión -->
          <div v-if="isModalOpen"
            class="fixed inset-0 bg-gray-800 bg-opacity-50 flex justify-center items-center z-50 transition-opacity"
            :class="{ 'opacity-100': isModalOpen, 'opacity-0': !isModalOpen }">
            <div class="bg-white p-8 rounded-2xl shadow-xl transition-transform transform max-w-md w-full"
              :class="{ 'scale-100': isModalOpen, 'scale-95': !isModalOpen }">
              <!-- Título del Modal -->
              <h2 class="text-2xl font-semibold text-center text-gray-800 mb-6">Iniciar Sesión</h2>

              <!-- Formulario de Inicio de Sesión -->
              <form @submit.prevent="submitLogin" class="text-black">
                <div class="mb-4">
                  <input v-model="email" type="text"
                    class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition"
                    placeholder="Correo electrónico" required />
                  <p v-if="errors.email" class="text-red-500 text-sm mt-2">{{ errors.email }}</p>
                </div>

                <div class="mb-6">
                  <input v-model="password" type="password"
                    class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition"
                    placeholder="Contraseña" required />
                  <p v-if="errors.password" class="text-red-500 text-sm mt-2">{{ errors.password }}</p>
                </div>

                <!-- Botón de Enviar -->
                <button type="submit"
                  class="w-full bg-blue-500 text-white p-3 rounded-lg hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500 transition">
                  Iniciar Sesión
                </button>
              </form>

              <!-- Mensaje de error general -->
              <p v-if="loginError" class="text-red-500 text-sm mt-4 text-center">
                {{ loginError }}
              </p>

              <!-- Cerrar Modal -->
              <button @click="closeModal"
                class="absolute top-2 right-2 text-gray-500 hover:text-gray-800 focus:outline-none">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                  xmlns="http://www.w3.org/2000/svg">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                </svg>
              </button>
            </div>
          </div>
        </div>
      </div>

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

  <!-- MODAL CARRITO -->
<div v-if="carritoModalAbierto"
     class="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center z-50">
  <div class="bg-white text-black p-6 rounded-xl w-full max-w-2xl relative shadow-lg">
    <h2 class="text-xl font-bold mb-4">Tu Carrito</h2>

    <div v-if="productosCarrito.length === 0">
      <p>No tienes productos en el carrito.</p>
    </div>

    <ul v-else class="divide-y divide-gray-300 max-h-[300px] overflow-y-auto">
  <li
    v-for="(item, index) in productosSeparados"
    :key="`${item.id}-${index}`"
    class="py-2 flex justify-between items-center"
  >
    <div class="flex items-center space-x-2">
      <img
        :src="`/${item.imagen}`"
        alt="Carátula"
        class="w-20 h-20 object-contain rounded"
      />
      <div>
        <p class="font-semibold">{{ item.nombre }}</p>
        <p class="text-sm text-gray-600">{{ item.precio }} €</p>
      </div>
    </div>

    <button
  @click="eliminarProducto(item.id)"
  class="text-red-600 hover:underline mr-4"
>
  Eliminar
</button>
  </li>
</ul>

<div class="flex justify-end mt-4">
  <p class="text-lg font-semibold">Total: {{ totalCarrito }} €</p>
</div>

    <div class="flex justify-end mt-4 space-x-2">
      <button @click="cerrarModalCarrito"
              class="bg-gray-600 text-white px-4 py-2 rounded hover:bg-gray-700">Cerrar</button>
      <router-link to="/checkout"
                   class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700"
                   @click="cerrarModalCarrito">Finalizar compra</router-link>
    </div>
  </div>
</div>
</template>
<script>
import axios from 'axios';
import LoadingScreen from '@/components/LoadingScreen.vue';
import 'primeicons/primeicons.css';
import Swal from 'sweetalert2';
export default {
  components: {
    LoadingScreen
  },
  data() {
    return {
      email: '',
      userName: '',
      password: '',
      userRole: '',   // Aquí se almacenará el rol del usuario
      isModalOpen: false,
      isMenuOpen: false, // Estado del menú hamburguesa
      isLoggedIn: false, // Control del login
      showMainMenu: false, // Menú hamburguesa
      showUserMenu: false, // Menú usuario
      errors: {
        email: '',
        password: ''
      },
      loginError: '', // Aquí se mostrará el error general (credenciales)
      carritoModalAbierto: false,
      carritoCantidad: 0,
      cargandoCarrito: false,
    productosCarrito: [],
    };
  },
  methods: {
    openModal() {
      this.isModalOpen = true;
    },
    closeModal() {
      this.isModalOpen = false;
      this.showUserMenu = false;
      this.showMainMenu = false;
    },
    toggleMainMenu() {
      this.showMainMenu = !this.showMainMenu;
      if (this.showMainMenu) this.showUserMenu = false;
    },
    toggleUserMenu() {
      this.showUserMenu = !this.showUserMenu;
      if (this.showUserMenu) this.showMainMenu = false;
    },
    handleClickOutside(event) {
      const mainMenu = this.$refs.mainMenuRef;
      const userMenu = this.$refs.userMenuRef;
      if (mainMenu && !mainMenu.contains(event.target)) {
        this.showMainMenu = false;
      }
      if (userMenu && !userMenu.contains(event.target)) {
        this.showUserMenu = false;
      }
    },


    async submitLogin() {
  
      this.errors = { email: '', password: '' };
      this.loginError = '';

      if (!this.email) {
        this.errors.email = 'El correo electrónico es requerido.';
        return;
      }
      if (!this.password) {
        this.errors.password = 'La contraseña es requerida.';
        return;
      }

      try {
        const response = await axios.post('/login', {
  correo: this.email,
  clave: this.password
}, {
  withCredentials: true // esto es clave para que la cookie de sesión se guarde
});

        localStorage.setItem('token', response.data.token);
        localStorage.setItem('userName', response.data.user.usuario);
        localStorage.setItem('userRole', response.data.user.tipouser);

        this.userName = response.data.user.usuario;
        this.userRole = response.data.user.tipouser; // Almacena el rol del usuario
        this.isLoggedIn = true;

            // 🔥 Cargar productos del carrito tras login
await this.cargarProductosCarrito();
          // Mostrar SweetAlert de éxito
   Swal.fire({
  position: 'center', // 👈 Centro de la pantalla
  icon: 'success',
  title: 'Producto añadido al carrito',
  showConfirmButton: false,
  timer: 2000,
  timerProgressBar: true
});


        this.$router.push('/');
        this.closeModal();
      } catch (error) {
        if (error.response?.data?.message) {
          this.loginError = error.response.data.message;
        } else if (error.response?.data?.errors) {
          const errors = error.response.data.errors;
          this.loginError = Object.values(errors)[0][0];
        } else {
          this.loginError = 'Error desconocido. Intenta de nuevo.';
        }
      }
    },
    logout() {
      localStorage.removeItem('token');
      localStorage.removeItem('userName');

      this.isLoggedIn = false;
      this.userName = '';
        // 🔥 Limpiar el carrito visualmente
  this.productosCarrito = [];
  this.carritoCantidad = 0;
      this.$router.push('/');
    },
    abrirModalCarrito() {
    this.carritoModalAbierto = true
    this.cargarProductosCarrito()
  },
  cerrarModalCarrito() {
    this.carritoModalAbierto = false
  },

  async cargarProductosCarrito() {
  const token = localStorage.getItem('token')
  if (!token) {
    console.warn('No hay token, usuario no autenticado')
    return
  }

  this.cargandoCarrito = true // 🔄 Mostrar spinner

  try {
    const res = await axios.get('/carrito', {
      headers: {
        Authorization: `Bearer ${token}`
      }
    })

    this.productosCarrito = res.data?.productos || []
    this.carritoCantidad = this.productosCarrito.reduce((sum, p) => sum + p.pivot.cantidad, 0)
  } catch (e) {
    console.error('Error cargando carrito', e)
    this.productosCarrito = []
    this.carritoCantidad = 0
  } finally {
    this.cargandoCarrito = false // ✅ Ocultar spinner
  }
},


async eliminarProducto(productoId) {
  try {
    const token = localStorage.getItem('token')
    await axios.delete(`/carrito/${productoId}`, {
      headers: { Authorization: `Bearer ${token}` }
    })
    await this.cargarProductosCarrito()

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
  } catch (e) {
    console.error('Error al eliminar producto', e)
  }
}
  },


  mounted() {

    // Comprobar si hay token al cargar el componente
    const token = localStorage.getItem('token');
    if (token) {
      this.isLoggedIn = true;
      this.userName = localStorage.getItem('userName');
      this.userRole = localStorage.getItem('userRole'); // Recupera el rol también
      setTimeout(() => {
      this.cargarProductosCarrito()
    }, 50)
    }
    document.addEventListener('click', this.handleClickOutside);
    window.addEventListener('carrito-actualizado', this.cargarProductosCarrito);

  },
  beforeUnmount() {
  window.removeEventListener('carrito-actualizado', this.cargarProductosCarrito);
},
computed: {
  productosSeparados() {
    const lista = []
    for (const producto of this.productosCarrito) {
      const cantidad = producto.pivot.cantidad
      for (let i = 0; i < cantidad; i++) {
        lista.push(producto)
      }
    }
    return lista
  },
  totalCarrito() {
  return this.productosCarrito.reduce((total, item) => {
    const cantidad = item.pivot?.cantidad || 1;
    return total + (parseFloat(item.precio) * cantidad);
  }, 0).toFixed(2);
}

},
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

/* Estilos para el menú desplegable */
.relative {
  position: relative;
}

/* Estilos para el efecto de transición */
.transition-opacity {
  transition: opacity 0.3s ease;
}

.transition-transform {
  transition: transform 0.3s ease;
}

@keyframes spin-slow {
  from {
    transform: rotate(0deg);
  }

  to {
    transform: rotate(360deg);
  }
}

.animate-spin-slow {
  animation: spin-slow 3s linear infinite;
  filter: drop-shadow(0 0 10px white);
}
</style>

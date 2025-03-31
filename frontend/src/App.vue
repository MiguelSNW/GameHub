<template>
  <div class="min-h-screen bg-gray-100">
    <!-- Navbar -->
    <nav class="bg-gray-800 text-white shadow-md sticky top-0 z-10">
      <div class="max-w-7xl mx-auto px-4 py-4 flex justify-between items-center">
        <h1 class="text-xl font-bold text-white">GameHub</h1>

        <div class="flex space-x-4">
          <router-link
            to="/"
            class="hover:bg-gray-700 px-3 py-2 rounded transition"
            exact-active-class="bg-gray-900"
          >
            Inicio
          </router-link>
          <router-link
            to="/vistauser"
            class="hover:bg-gray-700 px-3 py-2 rounded transition"
            active-class="bg-gray-900"
          >
            Lista de Usuarios
          </router-link>
        </div>
      </div>
    </nav>

    <!-- Contenido -->
    <main class="p-6">
      <router-view />
    </main>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

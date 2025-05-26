<template>
    <div class="container mx-auto p-6">
        <h1 class="text-3xl font-bold text-center mb-8">Panel de Control</h1>
        <!-- Grid para máximo 3 columnas en pantallas grandes -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">

            <!-- Card 2: Gestión de Usuarios -->
            <router-link to="/admin/viewuser" class="card transform transition duration-300 hover:scale-105">
                <div class="bg-white p-6 rounded-xl shadow-lg flex flex-col justify-center items-center h-64">
                    <i class="pi pi-user" style="font-size: 2.5rem"></i>

                    <p class="mt-2 text-gray-600 text-center">Administrar la base de usuarios.</p>
                </div>
            </router-link>

            <!-- Card 3: Gestión de Productos -->
            <router-link to="/gestion-productos" class="card transform transition duration-300 hover:scale-105">
                <div class="bg-white p-6 rounded-xl shadow-lg flex flex-col justify-center items-center h-64">
                    <i class="pi pi-bitcoin" style="font-size: 2.5rem"></i>

                    <p class="mt-2 text-gray-600 text-center">Gestionar catálogo y stock.</p>
                </div>
            </router-link>

              <!-- Card 3: Gestión de Pedidos -->
              <router-link to="/gestion-pedidos" class="card transform transition duration-300 hover:scale-105">
                <div class="bg-white p-6 rounded-xl shadow-lg flex flex-col justify-center items-center h-64">
                    <i class="pi pi-box" style="font-size: 2.5rem"></i>

                    <p class="mt-2 text-gray-600 text-center">Gestionar pedidos.</p>
                </div>
            </router-link>


            <!-- Agrega más cards según las secciones que necesites -->
        </div>
    </div>
</template>

<script setup>
// Si necesitas lógica adicional, la puedes añadir acá
</script>

<style scoped>
/* Puedes personalizar aún más los estilos para las cards */
.card {
    cursor: pointer;
    /* Añade sombra extra, si lo deseas */
    /* También podrías definir animaciones personalizadas aquí */
}
</style>
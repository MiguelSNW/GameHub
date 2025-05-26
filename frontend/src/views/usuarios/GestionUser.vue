<template>
    <h1 class="titulo text-white text-4xl font-bold text-center mt-8">Gestión de Usuarios</h1>

    <!-- Condicional para mostrar el LoadingScreen -->
    <template v-if="isLoading">
        <div class="loading-screen flex justify-center items-center absolute inset-0 z-10">
            <LoadingScreen />
        </div>
    </template>

    <div class="table-container relative w-full">
        <div class="w-full flex justify-start mt-4">
  <button @click="openInsertModal" class="ml-4 flex items-center gap-2 bg-violet-700 hover:bg-violet-800 text-white px-4 py-2 rounded shadow">
    <i class="pi pi-user-plus text-lg"></i>
    <span class="text-sm">Añadir Usuario</span>
  </button>
</div>

<!-- Filtro por nombre -->
<div class="flex items-center gap-2 mb-4 mt-6">
  <label for="filtroNombre" class="text-white font-semibold">Filtrar por nombre:</label>
  <input
    id="filtroNombre"
    v-model="filtroNombre"
    type="text"
    placeholder="Buscar nombre..."
    class="p-2 border rounded w-64"
  />
</div>

        <table class="table w-full table-auto shadow-lg rounded-lg bg-white mt-6">
            <thead class="bg-gray-800 text-white">
                <tr>
                    <th class="py-4 px-4 text-sm w-1/5 border border-black">Nombre</th>
                    <th class="py-4 px-4 text-sm w-1/5 border border-black">Correo</th>
                    <th class="py-4 px-4 text-sm w-1/5 border border-black">DNI</th>
                    <th class="py-4 px-4 text-sm w-1/5 border border-black">Tipo de Usuario</th>
                    <th class="py-4 px-4 text-sm w-1/5 border border-black">Acciones</th>
                </tr>
            </thead>

            <tbody>
                <tr v-for="usuario in paginatedUsuarios" :key="usuario.id">
                    <td class="py-2 px-4 text-sm border border-black">{{ usuario.nombre }}</td>
                    <td class="py-2 px-4 text-sm border border-black">{{ usuario.correo }}</td>
                    <td class="py-2 px-4 text-sm border border-black">{{ usuario.dni }}</td>
                    <td class="py-2 px-4 text-sm border border-black">{{ usuario.tipouser }}</td>
                    <td class="py-2 px-4 text-sm border border-black">
                      <!-- Botón de Editar (icono lápiz) -->
<button @click="openModModal(usuario)" class="text-green-500 hover:text-green-700 text-xl mr-3">
  <i class="pi pi-pencil"></i>
</button>

<!-- Botón de Eliminar (icono papelera) -->
<button @click="deleteUser(usuario)" class="text-red-500 hover:text-red-700 text-xl">
  <i class="pi pi-trash"></i>
</button>
                    </td>
                </tr>
            </tbody>
        </table>
<!-- Modal de Inserción de Usuario -->
<div v-if="showInsertModal" class="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center z-20 text-black">
  <div class="bg-white p-6 rounded-lg shadow-lg w-96 max-w-sm">
    <h2 class="text-xl mb-4 text-center">INSERTAR NUEVO USUARIO</h2>
    <form @submit.prevent="insertUser">
      <div class="mb-3">
        <label for="dni" class="block text-sm">DNI</label>
        <input v-model="user.dni" type="text" id="dni" class="w-full px-3 py-2 border rounded" />
        <p v-if="errors.dni" class="text-red-500 text-sm">{{ errors.dni[0] }}</p> <!-- Mensaje de error -->
      </div>

      <div class="mb-3">
        <label for="nombre" class="block text-sm">Nombre</label>
        <input v-model="user.nombre" type="text" id="nombre" class="w-full px-3 py-2 border rounded" />
        <p v-if="errors.nombre" class="text-red-500 text-sm">{{ errors.nombre[0] }}</p> <!-- Mensaje de error -->
      </div>

      <div class="mb-3">
        <label for="apellidos" class="block text-sm">Apellidos</label>
        <input v-model="user.apellidos" type="text" id="apellidos" class="w-full px-3 py-2 border rounded" />
        <p v-if="errors.apellidos" class="text-red-500 text-sm">{{ errors.apellidos[0] }}</p> <!-- Mensaje de error -->
      </div>

      <div class="mb-3">
        <label for="usuario" class="block text-sm">Usuario</label>
        <input v-model="user.usuario" type="text" id="usuario" class="w-full px-3 py-2 border rounded" />
        <p v-if="errors.usuario" class="text-red-500 text-sm">{{ errors.usuario[0] }}</p> <!-- Mensaje de error -->
      </div>

      <div class="mb-3">
        <label for="correo" class="block text-sm">Correo</label>
        <input v-model="user.correo" type="email" id="correo" class="w-full px-3 py-2 border rounded" />
        <p v-if="errors.correo" class="text-red-500 text-sm">{{ errors.correo[0] }}</p> <!-- Mensaje de error -->
      </div>

      <div class="mb-3">
        <label for="telefono" class="block text-sm">Teléfono</label>
        <input v-model="user.telefono" type="text" id="telefono" class="w-full px-3 py-2 border rounded" />
        <p v-if="errors.telefono" class="text-red-500 text-sm">{{ errors.telefono[0] }}</p> <!-- Mensaje de error -->
      </div>

      <div class="mb-3">
        <label for="tipouser" class="block text-sm">Tipo de Usuario</label>
        <select v-model="user.tipouser" id="tipouser" class="w-full px-3 py-2 border rounded">
          <option value="admin">Administrador</option>
          <option value="usuario">Usuario</option>
        </select>
        <p v-if="errors.tipouser" class="text-red-500 text-sm">{{ errors.tipouser[0] }}</p> <!-- Mensaje de error -->
      </div>

      <!-- Campo de Contraseña -->
      <div class="mb-3">
        <label for="clave" class="block text-sm">Contraseña</label>
        <input v-model="user.clave" type="password" id="clave" class="w-full px-3 py-2 border rounded" />
        <p v-if="errors.clave" class="text-red-500 text-sm">{{ errors.clave[0] }}</p> <!-- Mensaje de error -->
      </div>

      <div class="flex justify-between mt-4">
        <button type="button" @click="closeInsertModal" class="bg-gray-400 text-black py-2 px-4 rounded text-sm">Cancelar</button>
        <button type="submit" class="bg-indigo-600 text-white py-2 px-4 rounded text-sm">Guardar</button>
      </div>
    </form>
  </div>
</div>




    
<!-- Modal de Modificación -->
<div v-if="showModModal" class="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center z-20 text-black">
    <div class="bg-white p-6 rounded-lg shadow-lg w-1/3">
        <h2 class="text-xl mb-4">MODIFICACIÓN DE USUARIO</h2>
        <form @submit.prevent="updateUser">
            <div class="mb-4">
                <label for="dni" class="block text-sm">DNI</label>
                <input v-model="user.dni" type="text" id="dni" class="w-full px-3 py-2 border rounded" />
                <!-- Error de validación -->
                <p v-if="errors.dni" class="text-red-500 text-sm">{{ errors.dni[0] }}</p>
            </div>
            <div class="mb-4">
                <label for="nombre" class="block text-sm">Nombre</label>
                <input v-model="user.nombre" type="text" id="nombre" class="w-full px-3 py-2 border rounded" />
                <p v-if="errors.nombre" class="text-red-500 text-sm">{{ errors.nombre[0] }}</p>
            </div>
            <div class="mb-4">
                <label for="apellidos" class="block text-sm">Apellidos</label>
                <input v-model="user.apellidos" type="text" id="apellidos" class="w-full px-3 py-2 border rounded" />
                <p v-if="errors.apellidos" class="text-red-500 text-sm">{{ errors.apellidos[0] }}</p>
            </div>
            <div class="mb-4">
                <label for="usuario" class="block text-sm">Usuario</label>
                <input v-model="user.usuario" type="text" id="usuario" class="w-full px-3 py-2 border rounded" />
                <p v-if="errors.usuario" class="text-red-500 text-sm">{{ errors.usuario[0] }}</p>
            </div>
            <div class="mb-4">
                <label for="correo" class="block text-sm">Correo</label>
                <input v-model="user.correo" type="email" id="correo" class="w-full px-3 py-2 border rounded" />
                <p v-if="errors.correo" class="text-red-500 text-sm">{{ errors.correo[0] }}</p>
            </div>
            <div class="mb-4">
                <label for="telefono" class="block text-sm">Teléfono</label>
                <input v-model="user.telefono" type="text" id="telefono" class="w-full px-3 py-2 border rounded" />
                <p v-if="errors.telefono" class="text-red-500 text-sm">{{ errors.telefono[0] }}</p>
            </div>
            <div class="mb-4">
                <label for="tipouser" class="block text-sm">Tipo de Usuario</label>
                <select v-model="user.tipouser" id="tipouser" class="w-full px-3 py-2 border rounded">
                    <option value="admin">Administrador</option>
                    <option value="usuario">Usuario</option>
                </select>
                <p v-if="errors.tipouser" class="text-red-500 text-sm">{{ errors.tipouser[0] }}</p>
            </div>

            <!-- Campo de Contraseña (Opcional) -->
            <div class="mb-4">
                <label for="clave" class="block text-sm">Contraseña (Opcional)</label>
                <input v-model="user.clave" type="password" id="clave" class="w-full px-3 py-2 border rounded" placeholder="Deja en blanco para no cambiar la contraseña" />
            </div>

            <div class="flex justify-between">
                <button type="button" @click="closeModModal" class="bg-gray-400 text-black py-2 px-4 rounded">Cancelar</button>
                <button type="submit" class="bg-indigo-600 text-white py-2 px-4 rounded">Guardar</button>
            </div>
        </form>
    </div>
</div>



        <!-- Mensaje de confirmación de actualización -->
        <div v-if="updateSuccessMessage" class="mt-4 text-green-500 text-sm">
            Usuario actualizado correctamente.
        </div>

        <!-- Paginación -->
        <div class="flex justify-center items-center space-x-4 mt-6">
            <button @click="previousPage" :disabled="currentPage === 1"
                class="bg-indigo-700 text-white py-2 px-4 rounded disabled:bg-gray-300 text-sm">
                Anterior
            </button>
            <span class="text-xl">Página {{ currentPage }} de {{ totalPages }}</span>
            <button @click="nextPage" :disabled="currentPage === totalPages"
                class="bg-indigo-700 text-white py-2 px-4 rounded disabled:bg-gray-300 text-sm">
                Siguiente
            </button>
        </div>
    </div>

    <!-- Botón independiente arriba a la izquierda, con tamaño reducido -->
    <a href="/administrador"
        class="fixed top-24 left-5 bg-violet-700 text-white text-lg font-bold py-2 px-4 rounded-lg shadow-lg transition-colors hover:bg-blue-800">
        VOLVER AL PANEL DE CONTROL
    </a>
</template>

<script>
import { ref, onMounted, computed } from 'vue'
import axios from 'axios'
import Swal from 'sweetalert2'
import LoadingScreen from '@/components/LoadingScreen.vue'

export default {
    data() {
        return {
             usuarios: [],
isLoading: true,
filtroNombre: '',
            showModModal: false,  // Estado del modal
            showInsertModal: false,  // Estado del modal de inserción
            user: {
                dni: '',
                usuario: '',
                correo: '',
                telefono: '',
                tipouser: 'usuario',
            },
            originalDni: '',  // Guardamos el DNI original para la comparación
            updateSuccessMessage: false,  // Mensaje de confirmación
            errors: {} // Objeto para almacenar errores de validación
        };
    },
    methods: {
         async obtenerUsuarios() {
        try {
            const response = await axios.get('/viewuser');
            this.usuarios = response.data;
            this.isLoading = false;
        } catch (error) {
            console.error('Error al obtener los usuarios:', error);
            this.isLoading = false;
        }
        },

        openInsertModal() {
      this.showInsertModal = true;
      this.user = { // Reiniciar el objeto user al abrir el modal
        dni: '',
        nombre: '',
        apellidos: '',
        usuario: '',
        correo: '',
        telefono: '',
        tipouser: 'usuario',
      };
      this.errors = {}; // Limpiar errores al abrir el modal
    },

    closeInsertModal() {
      this.showInsertModal = false;
    },

   async insertUser() {
    this.errors = {}; // Limpiar errores anteriores

    try {
       const response = await axios.post('/insertuser', this.user);

if (response.status === 201) {
    Swal.fire({
        title: 'Usuario creado!',
        text: 'El nuevo usuario fue creado correctamente.',
        icon: 'success'
    });

    this.closeInsertModal();
    await this.obtenerUsuarios();
} else {
    throw new Error('Respuesta inesperada del servidor');
}
    } catch (error) {
    if (error.response && error.response.status === 422) {
        this.errors = error.response.data.errors; // errores de validación
    } else {
        console.error('Detalles del error:', error.response?.data || error);
        Swal.fire({
            title: 'Error',
            text: error.response?.data?.message || 'Hubo un problema al crear el usuario.',
            icon: 'error'
        });
    }
}
},
    validEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    },

        openModModal(userData) {
    this.user = {
        ...userData,
        clave: '' // Vaciar campo contraseña
    };
    this.errors = {}; // Limpiar errores previos
    this.originalDni = userData.dni;
    this.showModModal = true;
    this.updateSuccessMessage = false;
},
        closeModModal() {
            this.showModModal = false;
        },

        // Función para modificar el usuario 
        async updateUser() {
            this.errors = {}; // Limpiar errores previos
            // Validación de los campos
            if (!this.validateFields()) {
                alert("Por favor, corrige los errores.");
                return;
            }

            try {
                // Llamada a la API para actualizar el usuario
                const response = await axios.put(`/updateuser/${this.originalDni}`, this.user, {
                    headers: {
                        'Authorization': `Bearer ${localStorage.getItem('token')}`
                    }
                });

                // Mostrar mensaje de confirmación
                this.updateSuccessMessage = true;

                // Después de 3 segundos, ocultar el mensaje de confirmación
                setTimeout(() => {
                    this.updateSuccessMessage = false;
                }, 3000);

                // Actualizar el usuario en la lista local
                const index = this.usuarios.findIndex(u => u.dni === this.user.dni);
                if (index !== -1) {
                    // Reemplazar los datos del usuario modificado
                    this.usuarios[index] = { ...this.user };
                }

                // Cerrar el modal
                this.closeModModal();

                // Mostrar la alerta con SweetAlert2
                Swal.fire({
                    position: "top-end",
                    icon: "success",
                    title: "Usuario actualizado correctamente",
                    showConfirmButton: false,
                    timer: 1500
                });

            } catch (error) {
    console.error('Error al actualizar el usuario:', error);

    // Captura errores de validación 422
    if (error.response && error.response.status === 422) {
        this.errors = error.response.data.errors;
    } else {
        Swal.fire({
            title: 'Error',
            text: 'Hubo un problema al actualizar el usuario.',
            icon: 'error'
        });
    }
}


        },

        validateFields() {
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const phonePattern = /^[0-9]{9}$/; // Validar teléfono (9 dígitos)
            const dniPattern = /^[0-9]{8}[A-Za-z]$/; // Validar DNI (8 dígitos + letra)

            // Validación de los campos
            if (!dniPattern.test(this.user.dni)) {
                alert("DNI no válido.");
                return false;
            }
            if (!emailPattern.test(this.user.correo)) {
                alert("Correo no válido.");
                return false;
            }
            if (!phonePattern.test(this.user.telefono)) {
                alert("Teléfono no válido.");
                return false;
            }
            return true;
        },

        // Función para eliminar el usuario usando SweetAlert2
        async deleteUser(usuario) {
            Swal.fire({
                title: "¿Estás seguro?",
                text: "¡No podrás revertir esto!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#6d2e9e",
                cancelButtonColor: "#cec6d5",
                confirmButtonText: "Sí, eliminarlo!"
            }).then(async (result) => {
                if (result.isConfirmed) {
                    try {
                        const token = localStorage.getItem('token');
                        if (!token) {
                            console.error('No se encontró el token de autenticación');
                            return;
                        }

                        await axios.delete(`/deleteuser/${usuario.dni}`, {
                            headers: {
                                'Authorization': `Bearer ${token}`
                            }
                        });

                        // Filtrar el usuario eliminado de la lista
                        this.usuarios = this.usuarios.filter(u => u.dni !== usuario.dni);

                        // Mostrar alerta de éxito
                        Swal.fire("¡Eliminado!", "El usuario ha sido eliminado.", "success");
                    } catch (error) {
                        console.error('Error al eliminar el usuario:', error);
                    }
                }
            });
        }
    },
    mounted() {
    this.obtenerUsuarios();
},
    components: {
        LoadingScreen
    },
    setup() {
        const filtroNombre = ref('');
        const usuarios = ref([]);
        const isLoading = ref(true);
        const currentPage = ref(1);
        const usersPerPage = 8;
        const showDelModal = ref(false); // Para mostrar u ocultar el modal
        const userToDelete = ref(null); // Usuario seleccionado para eliminar

        const obtenerUsuarios = async () => {
            try {
                const response = await axios.get('/viewuser');
                usuarios.value = response.data;
                isLoading.value = false;
            } catch (error) {
                console.error('Error al obtener los usuarios:', error);
                isLoading.value = false;
            }
        }

        onMounted(obtenerUsuarios);

        // Calculamos el total de páginas
        const totalPages = computed(() => Math.ceil(usuarios.value.length / usersPerPage));

const usuariosFiltrados = computed(() => {
    return usuarios.value.filter(usuario =>
        usuario.nombre.toLowerCase().includes(filtroNombre.value.toLowerCase())
    );
});

const paginatedUsuarios = computed(() => {
    const startIndex = (currentPage.value - 1) * usersPerPage;
    const endIndex = startIndex + usersPerPage;
    return usuariosFiltrados.value.slice(startIndex, endIndex);
});
        // Función para cambiar a la página siguiente
        const nextPage = () => {
            if (currentPage.value < totalPages.value) {
                currentPage.value++;
            }
        }

        // Función para cambiar a la página anterior
        const previousPage = () => {
            if (currentPage.value > 1) {
                currentPage.value--;
            }
        }

    

        return {
              filtroNombre,
                usuariosFiltrados,
            usuarios,
            isLoading,
            currentPage,
            totalPages,
            paginatedUsuarios,
            nextPage,
            previousPage,
            showDelModal,
            userToDelete,
        }
    }
}
</script>

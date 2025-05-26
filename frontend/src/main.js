import './assets/main.css';
import router from './router';
import { createApp } from 'vue';
import App from './App.vue';
import './assets/fonts.css';
import axios from 'axios';


const app = createApp(App);
app.use(router);
app.mount('#app');

// Configura Axios globalmente
axios.defaults.baseURL = 'http://localhost:8000/api';  // URL de tu backend Laravel
axios.defaults.withCredentials = true;  // Permite el uso de cookies, si es necesario
axios.defaults.headers.common['Authorization'] = `Bearer ${localStorage.getItem('token')}`;

// Configura Axios para enviar el token CSRF y JWT en las solicitudes
axios.interceptors.request.use(config => {
  // Obtiene el token CSRF del meta tag
  const csrfToken = document.head.querySelector('meta[name="csrf-token"]');  
  if (csrfToken) {
    config.headers['X-CSRF-TOKEN'] = csrfToken.content;  // Enviar el CSRF token en los encabezados
  }

  // Obtiene el token JWT de localStorage y lo agrega a los encabezados si existe
  const jwtToken = localStorage.getItem('token');
  if (jwtToken) {
    config.headers['Authorization'] = `Bearer ${jwtToken}`;  // Enviar el JWT token en los encabezados
  }

  return config;
}, error => {
  return Promise.reject(error);
});

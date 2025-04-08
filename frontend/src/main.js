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

// Configura Axios para enviar el token CSRF en las solicitudes
axios.interceptors.request.use(config => {
  const token = document.head.querySelector('meta[name="csrf-token"]');  // Obtener el token CSRF del meta tag

  if (token) {
    config.headers['X-CSRF-TOKEN'] = token.content;  // Enviar el token en los encabezados de la solicitud
  }

  return config;
}, error => {
  return Promise.reject(error);
});
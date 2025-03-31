import './assets/main.css'
import router from './router' // 👈 ¡Esta línea es la clave!
import { createApp } from 'vue'
import App from './App.vue'
import './assets/fonts.css';
const app = createApp(App)
app.use(router)
app.mount('#app')

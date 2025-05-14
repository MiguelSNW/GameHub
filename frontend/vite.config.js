import { fileURLToPath, URL } from 'node:url'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueJsx from '@vitejs/plugin-vue-jsx'
import vueDevTools from 'vite-plugin-vue-devtools'

export default defineConfig({
  define: {
    'process.env': {},
  },
  plugins: [
    vue(),
    vueJsx(),
    vueDevTools(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
      'vue3-range-slider': fileURLToPath(new URL('./node_modules/vue3-range-slider/dist/vue3-range-slider.umd.js', import.meta.url))
    },
  },
  server: {
    hmr: {
      // Puedes forzar el host si es necesario:
      host: 'localhost'
      // Si usas HTTPS o tienes configuraciones particulares, agrega otras opciones aquí.
    }
  },
})

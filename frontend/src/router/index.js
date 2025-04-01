// frontend/src/router/index.js

import { createRouter, createWebHistory } from 'vue-router'
import Dashboard from '../views/Dashboard.vue'
import VistaUser from '../views/vistauser.vue'
import ProductoDetalle from '../views/ProductoDetalle.vue'
import Busqueda from '../views/Busqueda.vue'
import { name } from '@vue/eslint-config-prettier/skip-formatting'


const routes = [
    { path: '/', component: Dashboard },
    { path: '/vistauser', component: VistaUser },
    { path: '/producto/:id', component: ProductoDetalle },
    { path: '/busqueda', name: 'Busqueda', component: Busqueda },
  ]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router

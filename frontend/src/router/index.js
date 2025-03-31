// frontend/src/router/index.js

import { createRouter, createWebHistory } from 'vue-router'
import Dashboard from '../views/Dashboard.vue'
import VistaUser from '../views/vistauser.vue'

const routes = [
    { path: '/', component: Dashboard },
    { path: '/vistauser', component: VistaUser },
  ]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router

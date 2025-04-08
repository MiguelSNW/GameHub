// frontend/src/router/index.js

import { createRouter, createWebHistory } from 'vue-router'
import Dashboard from '../views/Dashboard.vue'
import ProductoDetalle from '../views/productos/ProductoDetalle.vue'
import Busqueda from '../views/productos/Busqueda.vue'
import catSwitch from '../views/categorias/switch.vue'
import catSwitch2 from '../views/categorias/switch2.vue'
import catPs4 from '../views/categorias/ps4.vue'
import catPs5 from '../views/categorias/ps5.vue'
import catXbox from '../views/categorias/xbox.vue'
import catPc from '../views/categorias/pc.vue'
import catComic from '../views/categorias/comic.vue'
import catMerchan from '../views/categorias/merchandising.vue'
import catConsola from '../views/categorias/consolas.vue'
import Login from '../views/auth/login.vue'
import Profile from '../views/usuarios/Perfil.vue'
import PaneldeControl from '@/views/usuarios/administrador/PaneldeControl.vue'

const routes = [
    { path: '/', name: 'Index', component: Dashboard },
    { path: '/producto/:id', component: ProductoDetalle },
    { path: '/busqueda', name: 'Busqueda', component: Busqueda },
    { path: '/categoria/nintendo-switch', name: 'Nitendo Switch', component: catSwitch },
    { path: '/categoria/nintendo-switch2', name: 'Nitendo Switch 2', component: catSwitch2 },
    { path: '/categoria/ps4', name: 'PlayStation 4', component: catPs4 },
    { path: '/categoria/ps5', name: 'PlayStation 5', component: catPs5 },
    { path: '/categoria/xbox', name: 'Xbox Series X', component: catXbox},
    { path: '/categoria/pc', name: 'PC', component: catPc},
    { path: '/categoria/comics', name: 'Cómics', component: catComic},
    { path: '/categoria/merchandising', name: 'Merchandising', component: catMerchan},
    { path: '/categoria/consolas', name: 'Consolas', component: catConsola},
    { path: '/auth/login', name: 'Login', component: Login},
    { path: '/profile', name: 'Profile', component: Profile, meta: { requiresAuth: true } },
    { path: '/administrador', name: 'Panel de Control', component: PaneldeControl, meta: { requiresAuth: true } },
  ]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

// Navigation guard global
router.beforeEach((to, from, next) => {
  // Comprueba si la ruta requiere autenticación
  if (to.matched.some(record => record.meta.requiresAuth)) {
    // Aquí verificamos si el token existe (u otra condición de autenticación)
    const token = localStorage.getItem('token')
    if (!token) {
      // Si no hay token, redirige al login
      next({ name: 'Index', query: { redirect: to.fullPath } })
    } else {
      next() // Hay token, permite el acceso
    }
  } else {
    next() // Si la ruta no requiere autenticación, continúa
  }
})

export default router


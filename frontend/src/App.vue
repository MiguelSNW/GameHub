<template>
  <div class="min-h-screen bg-gray-100">
    <router-view />
  </div>
</template>

<script>
import Dashboard from './components/Dashboard.vue'

export default {
  name: 'App',
  components: { Dashboard }
}
</script>

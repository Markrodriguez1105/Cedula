<template>
  <v-toolbar app>
    <v-app-bar-nav-icon class="hidden-lg-and-up" variant="text" @click="drawer = !drawer"></v-app-bar-nav-icon>
    <v-toolbar-title>{{ header }}</v-toolbar-title>
  </v-toolbar>
  <v-navigation-drawer app expand-on-hover v-model="drawer">
    <v-list>
      <v-list-item prepend-avatar="../assets/images/logo.jpg" title="Barangay Palestina"></v-list-item>
    </v-list>

    <v-divider></v-divider>

    <v-list v-for="list in lists" :key="list.text">
      <v-list-item class="navigationsIcons" :prepend-icon="list.icon" :title="list.text" :to="list.route"
        min-height="50" @click="getHeader(list.text), overlay = !overlay"></v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>

<style scoped>
.navigationsIcons:hover {
  background-color: #3A53A5;
  color: white;
}

.logo {
  position: absolute;
  opacity: 90%;
  top: 50%;
  left: 50%;
  transform: translate(-50%,-50%);
  width: 90%;
  /* animation: spin 2s linear infinite; */
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }

  100% {
    transform: rotate(360deg);
  }
}
</style>

<script>
export default {
  data() {
    return {
      overlay: false,
      header: 'Barangay Management System',
      drawer: true,
      rail: true,
      lists: [
        { icon: 'mdi-view-dashboard', text: 'Dashboard', route: '/Dashboard' },
        { icon: 'mdi-receipt-text-outline', text: 'Cedula', route: '/Cedula' },
      ]
    }
  },
  methods: {
    getHeader(value) {
      this.header = value;
    }
  },
  watch: {
    overlay(val) {
      val && setTimeout(() => {
        this.overlay = false
      }, 2000)
    },
  },
}
</script>
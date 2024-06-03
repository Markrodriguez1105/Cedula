<template>
  <v-app>
    <v-main>
      <SideNav />
      <router-view />
    </v-main>
  </v-app>
</template>

<script setup>
import SideNav from './components/SideNav.vue';
</script>

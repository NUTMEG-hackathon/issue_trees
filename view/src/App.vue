<template>
  <v-app>
    <Header />
      <Sidebar />
      <v-main class=main>
        <transition mode="out-in">
        <v-layout align-center justify-center>
          <router-view />
        </v-layout>
        </transition>
      </v-main>
      <Footer />
  </v-app>
</template>

<script>
import Header from '@/components/Header.vue'
import Footer from '@/components/Footer.vue'
import Sidebar from '@/components/Sidebar.vue'

export default {
  name: 'App',

  components: {
    Header,
    Footer,
    Sidebar
  },
  data: () => ({
    //
  }),
}
</script>

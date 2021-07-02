<template>
  <div
    v-if="this.$route.path === '/tree' ||
          this.$route.path === '/information'
  ">
    <v-footer dark app color="#74905D">
      <v-layout align-center justify-center>
      efficientree
      </v-layout>
    </v-footer>
  </div>
</template>
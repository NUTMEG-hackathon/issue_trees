<template>
  <v-container>
    <v-dialog v-model="openh" max-width="700">
      <v-card>
        <v-img src="../assets/Tree2.png" class="logo" >
          <v-row no-gutters>
            <v-card-title class="my-3 text-h3">
              <h4 class="logo1">長岡技大-学園祭実行委員会（通称NUTMEG）</h4>
            </v-card-title>
          </v-row>
        </v-img>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      openh: false,
    }
  }
}
</script>
<style scoped>
  .logo{
    max-height: 250px;
    opacity: 80%;
  }
  .logo1{
    font-weight: bold;
    color: black;
  }
</style>
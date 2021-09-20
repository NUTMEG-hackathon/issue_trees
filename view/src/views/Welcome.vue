<template>
  <v-img src="../assets/Tree3.png" class="logo">
    <v-container>
      <v-row no-gutters>
        <v-col cols="6">
          <p class="logo1">Efficientree</p>
          <p class="logo2">Streamline Development Tool</p>
        </v-col>
        <v-col cols="6">
          <v-card class="logo3">
            <br />
              <h2 class="logo4">WELCOME</h2>
              <v-tooltip right>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    v-bind="attrs"
                    v-on="on"
                    class="ma-2"
                    color="green"
                    outlined
                    large
                    @click="openIn"
                    >SignIn</v-btn
                  >
                </template>
                <div>サインインする</div>
              </v-tooltip>
              <SignIn ref="opendialogi" />

              <v-tooltip right>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    v-bind="attrs"
                    v-on="on"
                    class="ma-2"
                    color="green"
                    outlined
                    large
                    @click="openUp"
                    >SignUp</v-btn
                  >
                </template>
                <div>サインアップ(新規登録)する</div>
              </v-tooltip>
              <SignUp ref="opendialogu" />

               <v-tooltip right>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    v-bind="attrs"
                    v-on="on"
                    class="ma-2"
                    color="green"
                    outlined
                    large
                    @click="openhome"
                    >Introduction</v-btn
                  >
                </template>
                <div>アプリの紹介</div>
              </v-tooltip>
              <Homepage ref="opendialogh" />

          </v-card>
        </v-col>
        </v-row>
    </v-container>
  </v-img>
</template>

<script>
import SignUp from "../components/SignUp.vue";
import SignIn from "../components/SignIn.vue";
import Homepage from "../components/Homepage.vue";
export default {
  components: {
    SignUp,
    SignIn,
    Homepage,
  },
  data() {
    return {
    };
  },
  methods: {
    openIn(){
      this.$refs.opendialogi.openi = true
    },
    openUp(){
      this.$refs.opendialogu.openu = true
    },
    openhome(){
      this.$refs.opendialogh.openh = true
    },
  },
};
</script>

<style scoped>
  .logo{
    position: relative;
    background-position: center;
    height: 100vh;
    width:auto;
  }
  .logo1{
    font-weight: bold;
    margin-top: 200px;
    position: center;
    top: calc(50% - 0.5em);
    width: 80%;
    text-align: center;
    line-height: 1;
    font-size: 5vw;
    font-family: "Montserrat", sans-serif;
    color: #008800;
    text-shadow: 7px 7px 0 #fff;
  }
    .logo2{
    font-weight: bold;
    margin-top: 20px;
    position: center;
    top: calc(50% - 0.5em);
    width: 80%;
    text-align: center;
    line-height: 1;
    font-size: 4vw;
    font-family: "Montserrat", sans-serif;
    color: #008800;
    text-shadow: 7px 7px 0 #fff;
  }
  .logo3{
    margin-top: 200px;
    opacity: 90%;
  }
  .logo4{
    text-align: center;
    color: black;
    margin: 10px;
  }
</style>
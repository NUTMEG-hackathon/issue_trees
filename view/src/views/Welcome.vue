<template>
  <v-container class="terget">
    <v-parallax src="../assets/Tree1.png">
      <v-row align="center" justify="center">
        <v-col cols="12">
          <br />
          <h1 class="text-h1 font-weight-bold mb-4">
            Efficientree
          </h1>
          <br />
          <h3 class="text-h2 font-weight-bold mb-4">
            Streamline development
          </h3>
        </v-col>
      </v-row>
    </v-parallax>

    <v-row justify="center">
      <v-col cols="4">
        <v-menu open-on-hover offset-y bottom disable-keys :close-on-content-click="false" :close-on-click="false">
          <template v-slot:activator="{ on, attrs }" :close-on-content-click="false" :close-on-click="false">
            <v-card rounded v-bind="attrs" v-on="on" :close-on-content-click="false" :close-on-click="false">
              <br /><br />
              <v-card-title  class="text-h4 justify-center light-green lighten-2 lighten-2">
                <v-icon x-large>mdi-text-box-plus</v-icon>
                SignUp
              </v-card-title>
              <br /><br />
            </v-card>
          </template>
          <v-list>
            <v-list-item>
              <v-list-item-title>
                <Signup />
              </v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu>
      </v-col>

      <v-col cols="4">
        <v-menu open-on-hover offset-y bottom disable-keys :close-on-content-click="false" :close-on-click="false">
          <template v-slot:activator="{ on, attrs }" :close-on-content-click="false" :close-on-click="false">
            <v-card rounded v-bind="attrs" v-on="on" :close-on-content-click="false" :close-on-click="false">
              <br /><br />
              <v-card-title  class="text-h4 justify-center light-green lighten-2 lighten-2">
                <v-icon x-large>mdi-login</v-icon>
                SignIn
              </v-card-title>
              <br /><br />
            </v-card>
          </template>
          <v-list>
            <v-list-item>
              <v-list-item-title>
                <Signin />
              </v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu>
      </v-col>

      <v-col cols="4">
        <v-menu open-on-hover offset-y bottom :close-on-content-click="false" :close-on-click="false" disable-keys>
          <template v-slot:activator="{ on, attrs }" :close-on-content-click="false" :close-on-click="false">
            <v-card rounded v-bind="attrs" v-on="on" :close-on-content-click="false" :close-on-click="false">
              <br /><br />
              <v-card-title  class="text-h4 justify-center light-green lighten-2 lighten-2">
                <v-icon x-large>mdi-book-open-page-variant</v-icon>
                instruction manual
              </v-card-title>
              <br /><br />
            </v-card>
          </template>
          <v-list>
            <v-list-item>
              <v-list-item-title>
                <Homepage />
              </v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu>
      </v-col>
    </v-row>

  </v-container>
</template>

<script>
import Signup from "../components/SignUp.vue";
import Signin from "../components/SignIn.vue";
import Homepage from "../components/Homepage.vue";
export default {
  components: {
    Signup,
    Signin,
    Homepage,
  },
  data() {
    return {
    };
  },
};
</script>

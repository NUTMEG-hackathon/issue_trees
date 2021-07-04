<template>
  <div
    v-if="
      this.$route.path === '/tree' ||
      this.$route.path === '/information' ||
      this.$route.path === '/about'
    "
  >
    <v-container>
      <v-app-bar app color="#91BA58" dark clipped-left>
        <v-menu open-on-hover offset-y>
          <template v-slot:activator="{ on, attrs }">
            <v-row>
              <v-col cols="11"></v-col>
              <v-col cols="1">
                <v-btn x-large fab text v-bind="attrs" v-on="on">
                  <v-icon large>mdi-account-circle</v-icon>
                </v-btn>
              </v-col>
            </v-row>
          </template>

          <v-list dense>
            <v-list-item to="/tree">
              <v-list-item-content>
                <v-list-item-title class="font-weight-bold">
                  <v-icon large>mdi-file-tree</v-icon>
                  ツリー構造
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>

            <v-list-item to="/information">
              <v-list-item-content>
                <v-list-item-title class="font-weight-bold">
                  <v-icon large>mdi-account-box</v-icon>
                  ユーザー情報詳細
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>

            <v-list-item @click="logout = true">
              <v-list-item-content>
                <v-list-item-title class="font-weight-bold">
                  <v-icon large>mdi-lock-reset</v-icon>
                  ログアウト
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list>
        </v-menu>
      </v-app-bar>

      <v-dialog v-model="logout" max-width="600">
        <v-card>
          <v-card-title
            class="text-h4 justify-center light-green lighten-2 lighten-2"
            >logout</v-card-title
          >
          <v-container class="justify-content-center">
            <v-card-actions>
              <v-layout align-center justify-center>
                <v-spacer />
                <v-btn class="error" flat @click="logout = false"
                  >取り消し</v-btn
                >
                <v-spacer />
                <v-btn class="primary" flat @click="ok">決定</v-btn>
                <v-spacer />
              </v-layout>
            </v-card-actions>
          </v-container>
        </v-card>
      </v-dialog>
    </v-container>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      users: [],
      projects: [],
      logout: false,
    };
  },
  mounted() {
    const url = process.env.VUE_APP_URL;
    axios
      .get(url + "/api/v1/users/show", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.users = response.data.data;
      });
  },
  methods: {
    ok: function () {
      axios
        .delete("http://localhost:3000/api/auth/sign_out", {
          headers: {
            "Content-Type": "application/json",
            "access-token": localStorage.getItem("access-token"),
            client: localStorage.getItem("client"),
            uid: localStorage.getItem("uid"),
          },
        })
        .then(
          this.$router.push("/"),
          (this.logout = false),
          localStorage.removeItem("access-token"),
          localStorage.removeItem("client"),
          localStorage.removeItem("uid")
        );
    },
  },
};
</script>
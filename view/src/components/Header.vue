<template>
  <div
    v-if="this.$route.path === '/tree' || this.$route.path === '/information'"
  >
    <v-container>
      <v-app-bar app color="#91BA58" dark clipped-left>
        <v-row align="center">
          <v-col cols="4"></v-col>
          <v-col cols="4">
            <v-select
              label="カテゴリ"
              ref="groupCategory"
              v-model="groupCategoryId"
              :items="groupCategories"
              :menu-props="{
                top: true,
                offsetY: true,
              }"
              item-text="name"
              item-value="id"
              outlined
            />
          </v-col>
          <v-col cols="4"></v-col>
        </v-row>

        <v-menu open-on-hover offset-y>
          <template v-slot:activator="{ on, attrs }">
            <v-btn text color="yellow" dark v-bind="attrs" v-on="on">
              <v-icon large>mdi-home-circle</v-icon>
            </v-btn>
          </template>
          <v-list dense>
            <v-list-item to="/tree">
              <v-list-item-content>
                <v-list-item-title class="font-weight-bold">
                  <v-icon size="30">mdi-file-tree</v-icon>
                  ツリー構造
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>

            <v-list-item to="/Information">
              <v-list-item-content>
                <v-list-item-title class="font-weight-bold">
                  <v-icon size="30">mdi-account-box</v-icon>
                  ユーザー情報詳細
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>

            <v-list-item @click="logout = true">
              <v-list-item-content>
                <v-list-item-title class="font-weight-bold">
                  <v-icon size="30">mdi-lock-reset</v-icon>
                  ログアウト
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list>
        </v-menu>
      </v-app-bar>

      <v-dialog v-model="logout" max-width="600" persistent>
        <v-card>
          <v-card-title>ログアウトするの～さみしいよー</v-card-title>
          <v-container class="justify-content-center">
            <v-card-actions>
              <v-layout align-center justify-center>
                <v-spacer />
                <v-btn
                  color="#91BA58"
                  flat="flat"
                  to="/"
                  @click="logout = false"
                  >決定</v-btn
                >
                <v-spacer />
                <v-btn color="#74905D" flat="flat" @click="logout = false"
                  >取り消し</v-btn
                >
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
      logout: false,
      groupCategories: [
        { id: 1, name: "この木なんの木きになる木" },
        { id: 2, name: "efficientree" },
        { id: 3, name: "ryusei" },
        { id: 4, name: "NUTMEG" },
        { id: 5, name: "yushiro" },
        { id: 6, name: "tomoe" },
      ],
    };
  },
  mounted() {
    const url = process.env.VUE_APP_URL + "/api/v1/users/show";
    axios
      .get(url, {
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
};
</script>

<template>
  <v-container>
    <v-card>
      <v-card-title class="text-h3 justify-center">スキルの登録</v-card-title>
      <v-card-text class="text-h5 justify-center">複数選択が可能です</v-card-text>
        <v-row>
          <v-col cols="2"></v-col>
          <v-col cols="8">
                <v-select
                  multiple
                  v-model="selected"
                  :options="options"
                  :reduce="(options) => options.id"
                  key="id"
                  label="skill"
                  @input="onInput"
                  placeholder="Filter Skills ..."
                  :items="this.s_list"
                  :menu-props="{
                    top: true,
                    offsetY: true,
                  }"
                  item-text="name"
                  item-value="id"
                  outlined
                />
          </v-col>
          <v-col cols="2"></v-col>
        </v-row>
        <v-container class="justify-content-center">
          <v-card-actions>
            <v-layout align-center justify-center>
              <v-spacer />
              <v-btn class="error" flat to="/information">終了</v-btn>
              <v-spacer />
              <v-btn class="primary" flat @click="regist">追加</v-btn>
              <v-spacer />
            </v-layout>
          </v-card-actions>
        </v-container>
    </v-card>
  </v-container>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      users: [],
      s_list: [],
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

    const s_url = process.env.VUE_APP_URL + "/skills";
      axios
      .get(s_url, {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.s_list = response.data;
        console.log("---");
        console.log(this.issues);
      });
  },
};
</script>
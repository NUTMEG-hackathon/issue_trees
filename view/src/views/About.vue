<template>
  <v-container>
    <v-card>
      <v-card-title class="text-h3 justify-center">スキルの登録</v-card-title>
      <v-card-text class="text-h5 justify-center">複数選択が可能です</v-card-text>
        <v-row>
          <v-col cols="2"></v-col>
          <v-col cols="8">
          <v-select
            label="skill"
            ref="skill"
            v-model="skillid"
            :items="skills"
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
        <v-row>
          <v-col cols="2"></v-col>
          <v-col cols="8">
          <v-select
            label="level"
            ref="level"
            v-model="levelid"
            :items="levels"
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
      skills: [
        { id: 1, name: "この木なんの木きになる木" },
        { id: 2, name: "efficientree" },
        { id: 3, name: "ryusei" },
        { id: 4, name: "NUTMEG" },
        { id: 5, name: "yushiro" },
        { id: 6, name: "tomoe" },
      ],
      levels: [
        { id: 1, name: "level_1 芋虫" },
        { id: 2, name: "level_2 カブトムシ" },
        { id: 3, name: "level_3 下僕" },
        { id: 4, name: "level_4 人間" },
        { id: 5, name: "level_5 神と人間のハーフ" },
        { id: 6, name: "level_6 神" },
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
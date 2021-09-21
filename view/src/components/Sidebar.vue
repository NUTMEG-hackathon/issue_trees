<template>
  <div
    v-if="
      this.$route.path === '/tree' ||
      this.$route.path === '/information' ||
      this.$route.path === '/about' ||
      this.$route.path === '/projectregist'
    "
  >
    <v-container>information
      <v-navigation-drawer fixed permanent clipped app color="#FFF">
        <v-sheet>
          <v-list>
            <v-list-item to= /tree class="font-weight-bold py-1">
              <v-icon class="pr-3" color="#7da453"> mdi-family-tree </v-icon>
                ProjectTree
            </v-list-item>
            <v-list-item class="font-weight-bold py-1">
              <v-icon class="pr-3" color="#7da453"> mdi-account </v-icon>
                AllUser
            </v-list-item>
            <v-list-item to=/projectregist class="font-weight-bold py-1">
              <v-icon class="pr-3" color="#7da453">
                mdi-text-box-plus-outline
              </v-icon>
              Add Project
            </v-list-item>
            
            
          </v-list>
        </v-sheet>
      </v-navigation-drawer>

      <v-dialog v-model="dialog" max-width="600" persistent>
        <v-card>
          <v-card-title
            class="text-h4 justify-center light-green lighten-2 lighten-2"
            >プロジェクトの追加</v-card-title
          >
          <v-container class="justify-content-center">
            <v-card-title class="text-h5 justify-center"
              >project名</v-card-title
            >
            <v-row>
              <v-col cols="2"></v-col>
              <v-col cols="8">
                <v-text-field
                  label="project_name"
                  v-model="name"
                  text
                  outlined
                  clearable
                />
              </v-col>
              <v-col cols="2"></v-col>
            </v-row>

            <v-card-title class="text-h5 justify-center"
              >参加メンバーの選択</v-card-title
            >
            <v-row>
              <v-col cols="2"></v-col>
              <v-col cols="8">
                <v-select
                  multiple
                  v-model="selected"
                  :options="options"
                  :reduce="(options) => options.id"
                  key="id"
                  label="name"
                  @input="onInput"
                  placeholder="Filter Skills ..."
                  :items="member"
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
          </v-container>
          <v-card-actions>
            <v-layout align-center justify-center>
              <v-spacer />
              <v-btn class="error" flat="flat" @click="dialog = false"
                >取り消し</v-btn
              >
              <v-spacer />
              <v-btn class="primary" flat="flat" @click="dialog = true"
                >決定</v-btn
              >
              <v-spacer />
            </v-layout>
          </v-card-actions>
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
      i : 0,
      dialog: false,
      member: [
        { id: 1, name: "yushiro" },
        { id: 2, name: "ryusei" },
        { id: 3, name: "tomoe" },
        { id: 4, name: "99A" },
        { id: 5, name: "mizu" },
        { id: 6, name: "masi-" },
        { id: 7, name: "masashi" },
      ],
    };
  },
  mounted() {
    const url = process.env.VUE_APP_URL + "/api/v1/users/index";
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
<template>
    <v-app-bar
      app
      color="#91BA58"
      dark
      clipped-left
      >
        <v-layout justify-center align-center>
            <v-row>
              <v-col cols="5"></v-col>
              <v-col cols="2">
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
                ></v-select>
              </v-col>
              <v-col cols="5"></v-col>
            </v-row>
        </v-layout>

            <v-menu
              open-on-hover
              offset-y
            >
              <template v-slot:activator="{ on, attrs }">
                <v-btn text color="yellow" dark v-bind="attrs" v-on="on">
                  <v-icon large>mdi-home-circle</v-icon>
                </v-btn>
              </template>
              <v-list dense>
                <v-list-item to="/Information">
                  <v-list-item-content>
                    <v-list-item-title class="font-weight-bold">
                      <v-icon class="pr-2" size="30">mdi-account-box</v-icon>
                        ユーザー情報詳細
                    </v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
                <v-list-item to="/Logout">
                  <v-list-item-content>
                    <v-list-item-title class="font-weight-bold">
                      <v-icon class="pr-2" size="30">mdi-lock-reset</v-icon>
                        ログアウト
                    </v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </v-list>
            </v-menu>
    </v-app-bar>
</template>

<script>
export default {
  data () {
    return {
      groupCategories: [
      { id: 1, name: 'この木なんの木きになる木' },
      { id: 2, name: 'efficientree' },
      { id: 3, name: 'ryusei' },
      { id: 4, name: 'NUTMEG' },
      { id: 5, name: 'yushiro' },
      { id: 6, name: 'tomoe' }
      ],
    }
  }
}
</script>

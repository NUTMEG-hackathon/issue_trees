<template>
  <div
    v-if="
      this.$route.path === '/tree' ||
      this.$route.path === '/information'
  ">
    <v-container>
        <v-navigation-drawer fixed permanent clipped app color="#B4CF9B">
          <br>
          <v-row>
            <v-col cols="1"></v-col>
            <v-col cols="10">
              <v-card
                @click="dialog=true"
              >
                <v-card-title>プロジェクト追加</v-card-title>
              </v-card>
            </v-col>
            <v-col cols="1"></v-col>
          </v-row>
          <br>
          <v-row>
            <v-col cols="1"></v-col>
            <v-col cols="10">
              <v-card>
                <v-card-title>詳細</v-card-title>
              </v-card>
            </v-col>
            <v-col cols="1"></v-col>
          </v-row>
          <br>
          <v-row>
            <v-col cols="1"></v-col>
            <v-col cols="10">
              <v-card>
                <v-card-title>参加メンバー</v-card-title>
              </v-card>
            </v-col>
            <v-col cols="1"></v-col>
          </v-row>
        </v-navigation-drawer>

      <v-dialog
        v-model="dialog"
        max-width="600"
        persistent
        >
        <v-card>
          <v-card-title>project追加</v-card-title>
          <v-card-text>追加の手続きを行います</v-card-text>
            <v-container class="justify-content-center">
              <v-row>
                <v-col cols="1"></v-col>
                <v-col cols="10" align="center">
                  <v-card-text>
                    <v-form ref="form">
                      <v-text-field
                        label="project_name"
                        v-model="name"
                        text
                        outlined
                        clearable
                      ></v-text-field>
                      <h1>Select member</h1>
                      <v-select
                        multiple
                        v-model="selected"
                        :options="options"
                        :reduce="options => options.id"
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
                    </v-form>
                  </v-card-text>
                </v-col>
                <v-col cols="1"></v-col>
              </v-row>
            </v-container>
          <v-card-actions>
            <v-layout align-center justify-center>
              <v-spacer />
              <v-btn color="#91BA58" flat="flat" @click="dialog=true">決定</v-btn>
              <v-spacer />
              <v-btn color="#74905D" flat="flat" @click="dialog=false">取り消し</v-btn>
              <v-spacer />
            </v-layout>
          </v-card-actions>
        </v-card>
      </v-dialog>

    </v-container>
  </div>
</template>

<script>
export default {
  data () {
    return {
      dialog: false,
      member: [
        { id: 1, name: 'yushiro' },
        { id: 2, name: 'ryusei' },
        { id: 3, name: 'tomoe' },
        { id: 4, name: '99A' },
        { id: 5, name: 'mizu' },
        { id: 6, name: 'masi-' },
        { id: 7, name: 'masashi' }
      ],
    }
  }
}
</script>

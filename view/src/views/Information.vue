<template>
  <div>
    <v-container>
      <v-card>
        <v-row align="center">
          <v-col cols="5"></v-col>
          <v-card-title>
            Personal Page
          </v-card-title>
          <v-col cols="3"></v-col>
            <v-btn
              color="#74905D"
              @click="password=true"
            >
              <v-icon>mdi-lock-question</v-icon>
            </v-btn>
          <v-col cols="4"></v-col>
        </v-row>

        <v-row>
          <v-card-text>
            個人情報
          </v-card-text>
          <v-layout align-center justify-center>
            <v-btn
              @click="edit=true"
              color="#91BA58"
            >
              <v-icon>mdi-pencil</v-icon>
            </v-btn>
          </v-layout>
        </v-row>

        <v-row>
          <v-card-text>
            MySkill
          </v-card-text>
          <v-layout align-center justify-center>
            <v-btn
              text
              color="green"
              dark
              @click="skill=true"
              >
              <v-icon large>mdi-plus-box-multiple</v-icon>
            </v-btn>
          </v-layout>
        </v-row>

        <v-row>
          <v-card-text>
            参加project
          </v-card-text>
        </v-row>

        <v-row>
          <v-card-text>
            My issue
          </v-card-text>
        </v-row>
      </v-card>

      <v-dialog
        v-model="skill"
        max-width="600"
        persistent
        >
        <v-card>
          <v-card-title>MySkill追加</v-card-title>
            <v-container class="justify-content-center">
              <v-row>
                <v-col cols="1"></v-col>
                <v-col cols="10" align="center">
                  <v-card-text>
                    <v-form>
                      <v-select
                        multiple
                        v-model="selected"
                        :options="options"
                        :reduce="options => options.id"
                        key="id"
                        label="skill"
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
              <v-btn color="#91BA58" flat="flat" @click="dialog=true">登録</v-btn>
              <v-spacer />
              <v-btn color="#74905D" flat="flat" @click="skill=false">取り消し</v-btn>
              <v-spacer />
            </v-layout>
          </v-card-actions>
        </v-card>
      </v-dialog>

      <v-dialog
        v-model="edit"
        max-width="600"
        persistent
      >
        <v-card>
          <v-card-title>個人情報の編集</v-card-title>
          <v-container class="justify-content-center">
            <v-text-field
              label="name"
              v-model="name"
              text
              outlined
              clearable
            />
            <v-text-field
              label="email"
              v-model="name"
              text
              outlined
              clearable
            />
          </v-container>
          <v-card-actions>
            <v-layout align-center justify-center>
              <v-spacer />
              <v-btn color="#91BA58" flat="flat" @click="dialog=true">登録</v-btn>
              <v-spacer />
              <v-btn color="#74905D" flat="flat" @click="edit=false">取り消し</v-btn>
              <v-spacer />
            </v-layout>
          </v-card-actions>
        </v-card>
      </v-dialog>

      <v-dialog
        v-model="password"
        max-width="600"
        persistent
      >
        <v-card>
          <v-card-title>パスワードの変更</v-card-title>
          <v-container class="justify-content-center">
            <v-text-field
              label="現在のパスワード"
              v-model="name"
              text
              outlined
              clearable
            />
            <v-text-field
              label="新しいパスワード"
              v-model="name"
              text
              outlined
              clearable
            />
            <v-text-field
              label="新しいパスワードの確認"
              v-model="name"
              text
              outlined
              clearable
            />
          </v-container>
          <v-card-actions>
            <v-layout align-center justify-center>
              <v-spacer />
              <v-btn color="#91BA58" flat="flat" @click="dialog=true">登録</v-btn>
              <v-spacer />
              <v-btn color="#74905D" flat="flat" @click="password=false">取り消し</v-btn>
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
      skill: false,
      edit: false,
      password: false,
      member: [
        { id: 1, name: 'vue' },
        { id: 2, name: 'rails' },
        { id: 3, name: 'python' },
        { id: 4, name: 'fortran' },
        { id: 5, name: 'C' },
        { id: 6, name: 'C#' },
        { id: 7, name: 'C++' }
      ],
    }
  }
}
</script>
<template>
  <div>
    <v-container>
      <v-card>
        <v-card-title class="text-h3 justify-center">Personal Page</v-card-title>
        <v-card-title class="text-h5 justify-center">Personal Information</v-card-title>
        <v-row>
          <v-layout align-center justify-center>
            <v-list>
              <v-list-title>
                {{users}}
              </v-list-title>
            </v-list>
            <v-tooltip left>
              <template v-slot:activator="{ on, attrs  }">
                  <v-btn
                      rounded
                      v-bind="attrs"
                      v-on="on"
                      @click="send">
                      編集
                      <v-icon>mdi-pencil</v-icon>
                  </v-btn>
              </template>
              <span>ユーザー情報を編集する</span>
            </v-tooltip>

            <v-tooltip right>
              <template v-slot:activator="{ on, attrs  }">
                  <v-btn
                    rounded
                    v-bind="attrs"
                    v-on="on"
                      @click="password = true">
                      変更
                    <v-icon>mdi-lock-question</v-icon>
                  </v-btn>
              </template>
              <span>パスワードの変更</span>
            </v-tooltip>
          </v-layout>

            <EditUser ref="editdialog"
                :userId="users.id"
                :name="users.name"
                :email="users.email"
                >
            </EditUser>
        </v-row>

        <v-card-title class="text-h5 justify-center">Myskill</v-card-title>
        <v-row>
          <v-layout align-center justify-center>
            <v-tooltip left>
              <template v-slot:activator="{ on, attrs  }">
                  <v-btn
                      rounded
                      v-bind="attrs"
                      v-on="on"
                      @click="skill = true">
                      編集
                      <v-icon>mdi-plus-box-multiple</v-icon>
                  </v-btn>
              </template>
              <span>Myskillの編集</span>
            </v-tooltip>
          </v-layout>
        </v-row>
        <br />

          <v-card-title class="text-h5 justify-center">参加project</v-card-title>
          <v-card-title class="text-h5 justify-center">Myissue</v-card-title>

      </v-card>

      <v-dialog v-model="skill" max-width="600" persistent>
        <v-card>
          <v-card-title class="text-h4 justify-center light-green lighten-2 lighten-2">スキル(技術)の変更</v-card-title>
          <v-container class="justify-content-center">

            <v-row>
              <v-col cols="2"></v-col>
              <v-col cols="8" align="center">
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

          </v-container>
          <v-card-actions>
            <v-layout align-center justify-center>
              <v-spacer />
              <v-btn class="error" flat @click="skill=false">取り消し</v-btn>
              <v-spacer />
              <v-btn class="primary" flat @click="skill=true">登録</v-btn>
              <v-spacer />
            </v-layout>
          </v-card-actions>
        </v-card>
      </v-dialog>

      <v-dialog v-model="password" max-width="600" persistent>
        <v-card>
          <v-card-title class="text-h4 justify-center light-green lighten-2 lighten-2">パスワードの変更</v-card-title>
          <v-container class="justify-content-center">

            <v-row>
              <v-col cols="2"></v-col>
              <v-col cols="8">
              <v-text-field
                label="現在のパスワード"
                v-model="name"
                text
                outlined
                clearable
              />
              </v-col>
              <v-col cols="2"></v-col>
            </v-row>

            <v-row>
              <v-col cols="2"></v-col>
              <v-col cols="8">
              <v-text-field
                label="新しいパスワード"
                v-model="name"
                text
                outlined
                clearable
              />
              </v-col>
              <v-col cols="2"></v-col>
            </v-row>

            <v-row>
              <v-col cols="2"></v-col>
              <v-col cols="8">
              <v-text-field
                label="新しいパスワードの確認"
                v-model="name"
                text
                outlined
                clearable
              />
              </v-col>
              <v-col cols="2"></v-col>
            </v-row>

          </v-container>
          <v-card-actions>
            <v-layout align-center justify-center>
              <v-spacer />
              <v-btn class="error" flat @click="password=false">取り消し</v-btn>
              <v-spacer />
              <v-btn class="primary" flat @click="password=true">登録</v-btn>
              <v-spacer />
            </v-layout>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-container>
  </div>
</template>

<script>
import EditUser from '@/components/edit_user.vue'
import axios from 'axios'
export default {
  components:{
    EditUser,
  },
  data() {
    return {
      users: [],
      issues: [],
      skills: [],
      projects: [],
      p_list: [],
      c_list: [],
      s_list: [],
      skill: false,
      edit: false,
      password: false,
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

    const issue_url = process.env.VUE_APP_URL + "/api/v1/get_user_issue";
      axios
      .get(issue_url, {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.issues = response.data;
        console.log("---");
        console.log(this.issues);
      });

    const skill_url = process.env.VUE_APP_URL + "/api/v1/get_user_skill";
      axios
      .get(skill_url, {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.skills = response.data;
        console.log("---");
        console.log(this.issues);
      });

    const project_url = process.env.VUE_APP_URL + "/api/v1/get_project_user";
      axios
      .get(project_url, {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.projects = response.data;
        console.log("---");
        console.log(this.issues);
      });

    const p_url = process.env.VUE_APP_URL + "/api/v1/projects/index";
      axios
      .get(p_url, {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.p_list = response.data;
        console.log("---");
        console.log(this.issues);
      });

    const c_url = process.env.VUE_APP_URL + "/api/v1/get_client_issue";
      axios
      .get(c_url, {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.c_list = response.data;
        console.log("---");
        console.log(this.issues);
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
  methods:{
    send: function(){
      this.$refs.editdialog.edit=true
    },
  },
};
</script>
<template>
  <v-container>
    <v-card-title class="text-center justify-center py-6">
      <h1 id="maintitle" class="display-1 font-weight-bold">Personal Page</h1>
    </v-card-title>

    <v-tabs grow color="green darken-3">
      <v-tab v-for="title in titles" :key="title" id="subtitle">{{
        title
      }}</v-tab>

      <v-tab-item>
        <br /><br />
        <hr style="height: 6px; background-color: #3cb371" />
        <v-row>
          <v-col cols="2"></v-col>
          <v-col cols="4">
            <h2><v-icon>mdi-account</v-icon>name</h2>
          </v-col>
          <v-col cols="4">
            <h2><v-icon>mdi-email-open-outline</v-icon>email</h2>
          </v-col>
          <v-col cols="2"></v-col>
        </v-row>
        <hr style="height: 6px; background-color: #3cb371" />
        <br />
        <v-row>
          <v-col cols="2"></v-col>
          <v-col cols="4" class="green lighten-5 pa-3 ma-3">
            <h3>{{ users.name }}</h3>
          </v-col>
          <v-col cols="4" class="green lighten-5 pa-3 ma-3">
            <h3>{{ users.email }}</h3>
          </v-col>
          <v-col cols="2"></v-col>
        </v-row>
        <br /><br />
        <v-row>
          <v-col cols="3"></v-col>
          <v-col cols="3">
            <v-tooltip left>
              <template v-slot:activator="{ on, attrs }">
                <v-btn rounded v-bind="attrs" v-on="on" @click="edit" large>
                  編集
                  <v-icon>mdi-pencil</v-icon>
                </v-btn>
              </template>
              <div>ユーザー情報を編集する</div>
            </v-tooltip>
          </v-col>
          <v-col cols="3">
            <v-tooltip right>
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  rounded
                  v-bind="attrs"
                  v-on="on"
                  @click="password = true"
                  large
                >
                  変更
                  <v-icon>mdi-lock-question</v-icon>
                </v-btn>
              </template>
              <div>パスワードの変更</div>
            </v-tooltip>
          </v-col>
          <v-col cols="3"></v-col>
        </v-row>
        <EditUser
          ref="edit1dialog"
          :userId="users.id"
          :name="users.name"
          :email="users.email"
        >
        </EditUser>
      </v-tab-item>

      <v-tab-item>
        <br /><br />
        <hr style="height: 6px; background-color: #3cb371" />
        <v-row>
          <v-col cols="4">
            <h2>name</h2>
          </v-col>
          <v-col cols="4">
            <h2>status</h2>
          </v-col>
          <v-col cols="4">
            <h2>level</h2>
          </v-col>
        </v-row>
        <hr style="height: 6px; background-color: #3cb371" />
        <br />
        <div v-for="skill in skills" :key="skill.id">
          <v-row>
            <v-col cols="4" class="green lighten-5 pa-3">
              <h3>{{ skill.name }}</h3>
            </v-col>
            <v-col cols="4" class="green lighten-5 pa-3">
              <h3>{{ skill.status }}</h3>
            </v-col>
            <v-col cols="4" class="green lighten-5 pa-3">
              <v-btn
                @click="minuslevelskill(skill.name, skill.status, skill.level)"
                small
                class="green lighten-3"
                ><v-icon>mdi-minus</v-icon></v-btn
              >
              {{ skill.level }}
              <v-btn
                @click="pluslevelskill(skill.name, skill.status, skill.level)"
                small
                class="green lighten-3"
                ><v-icon>mdi-plus</v-icon></v-btn
              >
            </v-col>
          </v-row>
          <br />
          <hr />
          <br />
        </div>
        <v-tooltip right>
          <template v-slot:activator="{ on, attrs }">
            <v-btn
              @click="addskill = true"
              v-bind="attrs"
              v-on="on"
              large
              class="green lighten-2"
            >
              <v-icon>mdi-text-box-plus</v-icon>
              <h2>追加</h2></v-btn
            >
          </template>
          <div>スキルの複数登録</div>
        </v-tooltip>
      </v-tab-item>

      <v-tab-item>
        <br /><br />
        <hr style="height: 6px; background-color: #3cb371" />
        <v-row>
          <v-col cols="4"> </v-col>
          <v-col cols="4">
            <h2>name</h2>
          </v-col>
          <v-col cols="4"> </v-col>
        </v-row>
        <hr style="height: 6px; background-color: #3cb371" />
        <br />
        <div v-for="project in projects" :key="project.id">
          <v-row>
            <v-col cols="4"></v-col>
            <v-col cols="4" class="green lighten-5 pa-3 ma-3">
              <h3>{{ project.name }}</h3>
            </v-col>
            <v-col cols="4"></v-col>
          </v-row>
          <hr />
          <br />
        </div>
      </v-tab-item>

      <v-tab-item>
        <br /><br />
        <hr style="height: 6px; background-color: #3cb371" />
        <v-row>
          <v-col cols="4">
            <h2>name</h2>
          </v-col>
          <v-col cols="4">
            <h2>description</h2>
          </v-col>
          <v-col cols="4">
            <h2>level</h2>
          </v-col>
        </v-row>
        <hr style="height: 6px; background-color: #3cb371" />
        <br />
        <div v-for="issue in issues" :key="issue.id">
          <v-row>
            <v-col cols="4" class="green lighten-5 pa-3">
              <h3>{{ issue.name }}</h3>
            </v-col>
            <v-col cols="4" class="green lighten-5 pa-3">
              <h3>{{ issue.description }}</h3>
            </v-col>
            <v-col cols="4" class="green lighten-5 pa-3">
              <v-btn
                @click="
                  minuslevelissue(issue.name, issue.description, issue.level)
                "
                small
                class="green lighten-3"
                ><v-icon>mdi-minus</v-icon></v-btn
              >
              {{ issue.level }}
              <v-btn
                @click="
                  pluslevelissue(issue.name, issue.description, issue.level)
                "
                small
                class="green lighten-3"
                ><v-icon>mdi-plus</v-icon></v-btn
              >
            </v-col>
          </v-row>
          <br />
          <hr />
          <br />
        </div>
      </v-tab-item>
    </v-tabs>

    <!-- パスワードの変更コンポーネント -->
    <v-dialog v-model="password" max-width="600" persistent>
      <v-card>
        <v-card-title
          class="text-h4 justify-center light-green lighten-2 lighten-2"
          >パスワードの変更</v-card-title
        >
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
            <v-btn class="error" flat @click="password = false">取り消し</v-btn>
            <v-spacer />
            <v-btn class="primary" flat @click="regist">登録</v-btn>
            <v-spacer />
          </v-layout>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <v-dialog v-model="addskill" max-width="600" persistent>
      <v-card>
        <v-card-title
          class="text-h4 justify-center light-green lighten-2 lighten-2"
          >新しいスキルの追加</v-card-title
        >
        <v-container class="justify-content-center">
          <v-row>
            <v-col cols="2"></v-col>
            <v-col cols="8">
              <v-select
                v-model="name"
                label="skill"
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

          <v-row>
            <v-col cols="2"></v-col>
            <v-col cols="8">
              <v-select
                v-model="status"
                label="status"
                :items="this.statuses"
                :menu-props="{
                  top: true,
                  offsetY: true,
                }"
                outlined
              />
            </v-col>
            <v-col cols="2"></v-col>
          </v-row>

          <v-row>
            <v-col cols="2"></v-col>
            <v-col cols="8">
              <v-select
                v-model="level"
                label="level"
                :items="this.levels"
                :menu-props="{
                  top: true,
                  offsetY: true,
                }"
                outlined
              />
            </v-col>
            <v-col cols="2"></v-col>
          </v-row>
        </v-container>
        <v-card-actions>
          <v-layout align-center justify-center>
            <v-spacer />
            <v-btn class="error" flat @click="addskill = false">取り消し</v-btn>
            <v-spacer />
            <v-btn class="primary" flat @click="regist">登録</v-btn>
            <v-spacer />
          </v-layout>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
import EditUser from "@/components/edit_user.vue";
import axios from "axios";
export default {
  components: {
    EditUser,
  },
  data() {
    return {
      titles: ["Personal Information", "My Skill", "My Project", "My Issue"],
      levels: ["1(復習レベル)", "2", "3", "4", "5(新しい技術に挑戦)"],
      statuses: ["front", "backencd", "server", "infra"],
      users: [],
      p_list: [],
      c_list: [],
      s_list: [],
      password: false,
      addskill: false,
      name: [],
      status: [],
      description: [],
      level: [],
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
        console.log(url);
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
        console.log(this.projects);
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

  methods: {
    edit: function () {
      this.$refs.edit1dialog.edit1 = true;
    },
    pluslevelissue(name, status, level) {
      this.name = name;
      this.status = status;
      this.level = level;

        const url = process.env.VUE_APP_URL + '/issues' ;
        var params =  {
            'name': this.name,
            'status': this.status,
            'level': this.level+1,
        }
            axios.put(url, params, {
            headers: {
              'Content-Type': 'application/json',
              'access-token': localStorage.getItem('access-token'),
              'client': localStorage.getItem('client'),
              'uid': localStorage.getItem('uid')
            }
          }
        ).then(
          (response) => {
            console.log(response)
            console.log('put')
          },
          (error) => {
            console.log('登録できませんでした')
            return error;
          }
        )
    },
    minuslevelissue(name, status, level) {
      this.name = name;
      this.status = status;
      this.level = level;
    },
    pluslevelskill(name, description, level) {
      this.name = name;
      this.description = description;
      this.level = level;
    },
    minuslevelskill(name, description, level) {
      this.name = name;
      this.description = description;
      this.level = level;
    },
    reload() {
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
          console.log(this.projects);
        });
    },
  },
};
</script>

<style>
#maintitle {
  color: #005500;
  font-weight: bold;
}
#subtitle {
  color: #006b3e;
  font-weight: bold;
}
</style>
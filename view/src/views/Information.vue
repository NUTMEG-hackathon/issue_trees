<template>
  <v-container>
    <v-card-title class="text-center justify-center py-6">
      <h1 id="maintitle" class="display-1 font-weight-bold">Personal Information</h1>
    </v-card-title>

    <v-tabs grow color="green darken-3">
      <v-tab v-for="title in titles" :key="title" id="subtitle">{{title}}</v-tab>

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
          <v-col cols="4" class="green lighten-4 pa-3 ma-3">
            <h3>{{ users.name }}</h3>
          </v-col>
          <v-col cols="4" class="green lighten-4 pa-3 ma-3">
            <h3>{{ users.email }}</h3>
          </v-col>
          <v-col cols="2"></v-col>
        </v-row>
        <br /><br />
        <v-card-actions>
          <v-spacer>
            <v-tooltip left>
              <template v-slot:activator="{ on, attrs }">
                <v-btn class="green lighten-2" v-bind="attrs" v-on="on" @click="edit(users.name,users.email)" large>
                  <h2>編集</h2>
                  <v-icon>mdi-pencil</v-icon>
                </v-btn>
              </template>
              <div>ユーザー情報を編集する</div>
            </v-tooltip>
          </v-spacer>
        </v-card-actions>
            <!-- <v-tooltip right>
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
            </v-tooltip> -->

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
          <v-col cols="6">
            <h2>name</h2>
          </v-col>
          <v-col cols="6">
            <h2>status</h2>
          </v-col>
          <!-- <v-col cols="4">
            <h2>level</h2>
          </v-col> -->
        </v-row>
        <hr style="height: 6px; background-color: #3cb371" />
        <br />
        <div v-for="skill in skills" :key="skill.id">
          <v-row>

            <v-col cols="6" class="green lighten-4 pa-3">
              <h3>{{ skill.name }}</h3>
            </v-col>
            <v-col cols="6" class="green lighten-5 pa-3">
              <h3>{{ skill.status }}</h3>
            </v-col>
          </v-row>
          <br />
          <hr />
          <br />
        </div>
        <v-tooltip left>
          <template v-slot:activator="{ on, attrs }">
            <v-btn
              @click="addskill = true"
              v-bind="attrs"
              v-on="on"
              large
              class="green lighten-2"
            >
              <v-icon>mdi-text-box-plus</v-icon>
              <h2>追加</h2></v-btn>
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
            <v-col cols="4" class="green lighten-4 pa-3 ma-3">
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
            <v-col cols="4" class="green lighten-3 pa-3">
              <h3>{{ issue.name }}</h3>
            </v-col>
            <v-col cols="4" class="green lighten-4 pa-3">
              <h3>{{ issue.description }}</h3>
            </v-col>
            <v-col cols="4" class="green lighten-5 pa-3">
              <h3>{{ issue.level }}</h3>
            </v-col>
          </v-row>
          <br />
          <hr />
          <br />
        </div>
      </v-tab-item>
    </v-tabs>

    <!-- パスワードの変更コンポーネント -->
    <v-dialog v-model="password" max-width="700" persistent>
      <v-card>
        <v-card-title class="text-h4 lighten-2 justify-center my-3 light-green--text">パスワードの変更</v-card-title>
          <v-row no-gutters>
            <v-col cols="1"></v-col>
            <v-col cols="10">
              <v-text-field
                label="current password"
                v-model="name"
                text
                outlined
                clearable
              />
            </v-col>
            <v-col cols="1"></v-col>
          </v-row>

          <v-row no-gutters>
            <v-col cols="1"></v-col>
            <v-col cols="10">
              <v-text-field
                label="new password"
                v-model="name"
                text
                outlined
                clearable
              />
            </v-col>
            <v-col cols="1"></v-col>
          </v-row>

          <v-row no-gutters>
            <v-col cols="1"></v-col>
            <v-col cols="10">
              <v-text-field
                label="again"
                v-model="name"
                text
                outlined
                clearable
              />
            </v-col>
            <v-col cols="1"></v-col>
          </v-row>

        <v-card-actions>
            <v-spacer />
              <v-tooltip left>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn v-bind="attrs" v-on="on" class="ma-2" color="blue" outlined @click="password = false">cancel</v-btn>
                </template>
                <div>編集を取り消しする</div>
              </v-tooltip>
            <v-spacer />
              <v-tooltip right>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn v-bind="attrs" v-on="on" class="ma-2" color="red" outlined @click="regist">edit</v-btn>
                </template>
                <div>編集を決定する</div>
              </v-tooltip>
            <v-spacer />
        </v-card-actions>
      </v-card>
    </v-dialog>

    <v-dialog v-model="addskill" max-width="700">
      <v-card>
        <v-card-title class="text-h4 lighten-2 justify-center my-3 light-green--text">add new skill</v-card-title>
          <v-row no-gutters>
            <v-col cols="1"></v-col>
            <v-col cols="10">
              <v-select
                multiple
                :key="id"
                v-model="userSkills"
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
            <v-col cols="1"></v-col>
          </v-row>

        <v-card-actions>
            <v-spacer />
              <v-tooltip left>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn v-bind="attrs" v-on="on" class="ma-2" color="blue" outlined @click="addskill = false">cancel</v-btn>
                </template>
                <div>編集を取り消しする</div>
              </v-tooltip>
            <v-spacer />
              <v-tooltip right>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn v-bind="attrs" v-on="on" class="ma-2" color="red" outlined @click="registskill">edit</v-btn>
                </template>
                <div>編集を決定する</div>
              </v-tooltip>
            <v-spacer />
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
      users: [],
      p_list: [],
      c_list: [],
      s_list: [],
      password: false,
      addskill: false,
      name: [],
      status: [],
      level: [],
      skillname: [],
      skillstatus: [],
      skilllevel: [],
      userSkills: [],
      uname: [],
      umail: [],
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
        this.reload
        this.users = response.data.data;
          const skill_ids_url = process.env.VUE_APP_URL + "/api/v1/get_user_skill_ids/" + this.users.id;
          axios
            .get(skill_ids_url, {
              headers: {
                "Content-Type": "application/json",
                "access-token": localStorage.getItem("access-token"),
                client: localStorage.getItem("client"),
                uid: localStorage.getItem("uid"),
              },
            })
            .then((response) => {
              this.userSkills = response.data;
              console.log(this.userSkills)
              this.addskill=false

            });
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
      registskill:async function () {
      const url = process.env.VUE_APP_URL;
      var params = {
        skill_ids: this.userSkills,
      };
      axios.defaults.headers.common["Content-Type"] = "application/json";
      await axios
        .put(
          url + "/api/v1/edit_user_skills/" + this.users.id, params,
          {
            headers: {
              "access-token": localStorage.getItem("access-token"),
              client: localStorage.getItem("client"),
              uid: localStorage.getItem("uid"),
            },
          }
        )
        .then((response) => {
          console.log(response);
          console.log(params);
        })
        .catch((error) => {
          console.log(error.response);
        });

      const skill_url = process.env.VUE_APP_URL + "/api/v1/get_user_skill_ids/" + this.users.id;
      await axios
        .get(skill_url, {
          headers: {
            "Content-Type": "application/json",
            "access-token": localStorage.getItem("access-token"),
            client: localStorage.getItem("client"),
            uid: localStorage.getItem("uid"),
          },
        })
        .then((response) => {
          this.userSkills = response.data;
          console.log(this.userSkills)
          this.addskill=false
          location.reload();
        });
      },
    edit(uname,uemail) {
      this.uname=uname
      this.uemail=uemail
      this.$refs.edit1dialog.edit1 = true

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
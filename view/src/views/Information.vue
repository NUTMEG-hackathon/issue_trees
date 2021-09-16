<template>
  <v-container>
    <template>
      <v-card-title class="text-center justify-center py-6">
        <h1 id="maintitle" class="display-1 font-weight-bold">Personal Page</h1>
      </v-card-title>
      <v-tabs grow color="green darken-3">
        <v-tab v-for="title in titles" :key="title" id="subtitle">{{ title }}</v-tab>

        <v-tab-item>
          <v-layout class="text-center justify-center py-6">
            <template>
              <v-list rounded>
                <v-list-item>
                  <v-list-item-icon class="pa-3 ma-3">
                    <v-icon>mdi-account</v-icon>
                    name:
                  </v-list-item-icon>
                  <v-list-item-title class="green lighten-3 pa-2 ma-3">
                    {{ users.name }}
                  </v-list-item-title>
                </v-list-item>
                <v-list-item>
                  <v-list-item-icon class="pa-3 ma-5">
                    <v-icon>mdi-email-open-outline</v-icon>
                    email:
                  </v-list-item-icon>
                  <v-list-item-title class="green lighten-3 pa-3 ma-3">
                    {{ users.email }}
                  </v-list-item-title>
                </v-list-item>
                <br/>
                <v-row>
                  <v-tooltip left>
                    <template v-slot:activator="{ on, attrs }">
                      <v-btn rounded v-bind="attrs" v-on="on" @click="send">
                        編集
                        <v-icon>mdi-pencil</v-icon>
                      </v-btn>
                    </template>
                    <div>ユーザー情報を編集する</div>
                  </v-tooltip>
                  <v-spacer/>
                  <v-tooltip right>
                    <template v-slot:activator="{ on, attrs }">
                      <v-btn rounded v-bind="attrs" v-on="on" @click="password = true">
                        変更
                        <v-icon>mdi-lock-question</v-icon>
                      </v-btn>
                    </template>
                    <div>パスワードの変更</div>
                  </v-tooltip>
                </v-row>

              </v-list>
            </template>
          </v-layout>
          <EditUser
            ref="edit1dialog"
            :userId="users.id"
            :name="users.name"
            :email="users.email">
          </EditUser>
        </v-tab-item>

        <v-tab-item>
          <v-layout align-center justify-center>
            <template>
              <v-list rounded>
                <span v-for="skill in skills" :key="skill.id">
                  <v-list-item>
                    <v-list-item-title class="green lighten-3 pa-3 ma-3">
                      {{ skill.name }}
                    </v-list-item-title>
                  </v-list-item>
                  <v-row>
                    <v-tooltip left>
                      <template v-slot:activator="{ on, attrs }">
                        <v-btn rounded v-bind="attrs" v-on="on" @click="editskill(skill.id,skill.name, skill.status, skill.level)">
                          編集
                          <v-icon>mdi-pencil</v-icon>
                        </v-btn>
                      </template>
                      <div>Myskillの編集</div>
                    </v-tooltip>
                    <v-spacer />
                    <v-tooltip right>
                      <template v-slot:activator="{ on, attrs }">
                        <v-btn rounded v-bind="attrs" v-on="on" @click="detailskill(skill.name, skill.status, skill.level)">
                          詳細情報
                          <v-icon>mdi-ballot-outline</v-icon>
                        </v-btn>
                      </template>
                      <div>詳細情報の確認</div>
                    </v-tooltip>
                  </v-row>
                  <br/><br/><br/>
                </span>
              </v-list>
            </template>
          </v-layout>
          <MySkill
            ref="edit2dialog"
            :id="this.skillI"                     
            :name="this.skillN"
            :status="this.skillS"
            :level="this.skillL">
          </MySkill>
        </v-tab-item>

        <v-tab-item>
          <v-layout align-center justify-center>
            <template>
              <v-list rounded>
                <div v-for="project in projects" :key="project.id">
                  <v-list-item>
                    <v-list-item-title class="green lighten-3 pa-3 ma-3">
                      {{ project.name }}
                    </v-list-item-title>
                  </v-list-item>
                    <v-tooltip left>
                      <template v-slot:activator="{ on, attrs }">
                        <v-btn rounded v-bind="attrs" v-on="on" @click="editproject(project.name,project.id)">
                          編集
                          <v-icon>mdi-pencil</v-icon>
                        </v-btn>
                      </template>
                      <div>ユーザー情報を編集する</div>
                    </v-tooltip>

                    <v-tooltip right>
                      <template v-slot:activator="{ on, attrs }">
                        <v-btn rounded v-bind="attrs" v-on="on" @click="detailproject(project.name,project.id)">
                          詳細情報
                          <v-icon>mdi-ballot-outline</v-icon>
                        </v-btn>
                      </template>
                      <div>詳細情報の確認</div>
                    </v-tooltip>
                  <br/><br/><br/>
                </div>
              </v-list>
            </template>
          </v-layout>
          <Project
            ref="edit3dialog"
            :name="this.projectN"
            :id="this.projectid">
          </Project>
        </v-tab-item>

        <v-tab-item>
          <v-layout align-center justify-center>
            <template>
              <v-list rounded>
                <div v-for="issue in issues" :key="issue.id">
                  <v-list-item>
                    <v-list-item-title class="green lighten-3 pa-3 ma-3">
                      {{ issue.name }}
                    </v-list-item-title>
                  </v-list-item>

                  <v-tooltip left>
                    <template v-slot:activator="{ on, attrs }">
                      <v-btn rounded v-bind="attrs" v-on="on" @click="editissue(issue.id,issue.name,issue.description,issue.level)">
                        編集
                        <v-icon>mdi-pencil</v-icon>
                      </v-btn>
                    </template>
                    <div>Myskillの編集</div>
                  </v-tooltip>

                  <v-tooltip right>
                    <template v-slot:activator="{ on, attrs }">
                      <v-btn rounded v-bind="attrs" v-on="on" @click="detailissue(issue.name,issue.description,issue.level)">
                        詳細情報
                        <v-icon>mdi-ballot-outline</v-icon>
                      </v-btn>
                    </template>
                    <div>詳細情報の確認</div>
                  </v-tooltip>

                  <v-tooltip right>
                    <template v-slot:activator="{ on, attrs }">
                      <v-btn rounded v-bind="attrs" v-on="on" @click="deleteissue(issue.id)">
                        完了
                        <v-icon>mdi-check-underline</v-icon>
                      </v-btn>
                    </template>
                    <div>issueの完了と削除</div>
                  </v-tooltip>
                  <br/><br/><br/>
                </div>
              </v-list>
            </template>
          </v-layout>
          <MyIssue
            ref="edit4dialog"
            :name="this.issueN"
            :discription="this.issueD"
            :level="this.issueL">
          </MyIssue>
        </v-tab-item>
      </v-tabs>
    </template>

    <!-- ユーザー情報の詳細コンポーネント -->
    <v-dialog v-model="detailU" max-width="600" persistent>
      <v-card>
        <v-card-title class="text-h4 justify-center light-green lighten-2 lighten-2">
          ユーザーの詳細情報
          <v-spacer />
          <v-btn class="text-h4 justify-center light-green lighten-2 lighten-2" @click="detailU=false">
            <v-icon>mdi-close</v-icon>
          </v-btn>
        </v-card-title>
        <v-container class="justify-content-center">
          <template>
            <v-list rounded>
              <v-list-item-group>
                <v-list-item>
                  <v-list-item-icon>
                    <v-icon>mdi-account</v-icon>name:{{ users.name }}
                  </v-list-item-icon>
                </v-list-item>
                <v-list-item>
                  <v-list-item-icon>
                    <v-icon>mdi-email-open-outline</v-icon>email:{{ users.email }}
                  </v-list-item-icon>
                </v-list-item>
              </v-list-item-group>
            </v-list>
          </template>
        
        <MyIssue
          ref="edit4dialog"
          :id ="this.issueI"
          :name="this.issueN"
          :description="this.issueD"
          :level="this.issueL">
        </MyIssue>
        </v-container>
      </v-card>
    </v-dialog>

    <!-- スキル情報の詳細コンポーネント -->
    <v-dialog v-model="detailS" max-width="600" persistent>
      <v-card>
        <v-card-title class="text-h4 justify-center light-green lighten-2 lighten-2">
          スキルの詳細情報
          <v-spacer />
          <v-btn class="text-h4 justify-center light-green lighten-2 lighten-2" @click="detailS=false">
            <v-icon>mdi-close</v-icon>
          </v-btn>
        </v-card-title>
        <v-container class="justify-content-center">
          <template>
            <v-list rounded>
              <v-list-item-group>
                <v-list-item>
                  <v-list-item-icon>
                    <v-icon>mdi-account</v-icon>name : {{ skillNN }}
                  </v-list-item-icon>
                </v-list-item>
                <v-list-item>
                  <v-list-item-icon>
                    <v-icon>mdi-account</v-icon>status : {{ skillSS }}
                  </v-list-item-icon>
                </v-list-item>
                <v-list-item>
                  <v-list-item-icon>
                    <v-icon>mdi-account</v-icon>level : {{ skillLL }}
                  </v-list-item-icon>
                </v-list-item>
              </v-list-item-group>
            </v-list>
          </template>
        </v-container>
      </v-card>
    </v-dialog>

    <!-- プロジェクト情報の詳細コンポーネント -->
    <v-dialog v-model="detailP" max-width="600" persistent>
      <v-card>
        <v-card-title class="text-h4 justify-center light-green lighten-2 lighten-2">
          プロジェクトの詳細情報
          <v-spacer />
          <v-btn class="text-h4 justify-center light-green lighten-2 lighten-2" @click="detailP=false">
            <v-icon>mdi-close</v-icon>
          </v-btn>
        </v-card-title>
        <v-container class="justify-content-center">
          <template>
            <v-list rounded>
              <v-list-item-group>
                <v-list-item>
                  <v-list-item-icon>
                    <v-icon>mdi-account</v-icon>name : {{ projectNN }}
                  </v-list-item-icon>
                </v-list-item>
              </v-list-item-group>
            </v-list>
          </template>
        </v-container>
      </v-card>
    </v-dialog>

    <!-- issue情報の詳細コンポーネント -->
    <v-dialog v-model="detailI" max-width="600" persistent>
      <v-card>
        <v-card-title class="text-h4 justify-center light-green lighten-2 lighten-2">
          issueの詳細情報
          <v-spacer />
          <v-btn class="text-h4 justify-center light-green lighten-2 lighten-2" @click="detailI=false">
            <v-icon>mdi-close</v-icon>
          </v-btn>
        </v-card-title>
        <v-container class="justify-content-center">
          <template>
            <v-list rounded>
              <v-list-item-group>
                <v-list-item>
                  <v-list-item-icon>
                    <v-icon>mdi-account</v-icon>name : {{ issueNN }}
                  </v-list-item-icon>
                </v-list-item>
                <v-list-item>
                  <v-list-item-icon>
                    <v-icon>mdi-email-open-outline</v-icon>description : {{ issueDD }}
                  </v-list-item-icon>
                </v-list-item>
                <v-list-item>
                  <v-list-item-icon>
                    <v-icon>mdi-email-open-outline</v-icon>level : {{ issueLL }}
                  </v-list-item-icon>
                </v-list-item>
              </v-list-item-group>
            </v-list>
          </template>
        </v-container>
      </v-card>
    </v-dialog>

    <!-- issue情報の詳細コンポーネント -->
    <v-dialog v-model="deleteI" max-width="600" persistent>
      <v-card>
        <v-card-title class="text-h4 justify-center light-green lighten-2 lighten-2">
          issueの完了と削除
          <v-spacer />
          <v-btn class="text-h4 justify-center light-green lighten-2 lighten-2" @click="detailI=false">
            <v-icon>mdi-close</v-icon>
          </v-btn>
        </v-card-title>
        <v-container class="justify-content-center">
          <template>
            <v-card-actions>
              <v-layout align-center justify-center>
                <v-spacer />
                <v-btn class="error" flat @click="deleteI = false">閉じる</v-btn>
                <v-spacer />
                <v-btn class="primary" flat @click="trash()">完了</v-btn>
                <v-spacer />
              </v-layout>
            </v-card-actions>
          </template>
        </v-container>
      </v-card>
    </v-dialog>

    <!-- パスワードの変更コンポーネント -->
    <v-dialog v-model="password" max-width="600" persistent>
      <v-card>
        <v-card-title class="text-h4 justify-center light-green lighten-2 lighten-2">パスワードの変更</v-card-title>
        <v-container class="justify-content-center">
          <v-row>
            <v-col cols="2"></v-col>
            <v-col cols="8">
              <v-text-field label="現在のパスワード" v-model="name" text outlined clearable />
            </v-col>
            <v-col cols="2"></v-col>
          </v-row>

          <v-row>
            <v-col cols="2"></v-col>
            <v-col cols="8">
              <v-text-field label="新しいパスワード" v-model="name" text outlined clearable/>
            </v-col>
            <v-col cols="2"></v-col>
          </v-row>

          <v-row>
            <v-col cols="2"></v-col>
            <v-col cols="8">
              <v-text-field label="新しいパスワードの確認" v-model="name" text outlined clearable />
            </v-col>
            <v-col cols="2"></v-col>
          </v-row>
        </v-container>
        <v-card-actions>
          <v-layout align-center justify-center>
            <v-spacer />
            <v-btn class="error" flat @click="detail = false">取り消し</v-btn>
            <v-spacer />
            <v-btn class="primary" flat @click="password = true">登録</v-btn>
            <v-spacer />
          </v-layout>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
import EditUser from "@/components/edit_user.vue";
import MyIssue from "@/components/edit_myissue.vue";
import MySkill from "@/components/edit_myskill.vue";
import Project from "@/components/edit_project.vue";
import axios from "axios";
export default {
  components: {
    EditUser,
    MyIssue,
    MySkill,
    Project,
  },
  data() {
    return {
      titles: [
          'Personal Information', 'My Skill', 'My Project', 'My Issue',
        ],
      users: [],
      issueI: [],
      issues: [],
      issueN: [],
      issueNN: [],
      issueD: [],
      issueDD: [],
      issueL: [],
      issueLL: [],
      issueid: [],
      skillI: [],
      skills: [],
      skillN: [],
      skillNN: [],
      skillS: [],
      skillSS: [],
      skillL: [],
      skillLL: [],
      projects: [],
      projectid: [],
      projectN: [],
      projectNN: [],
      p_list: [],
      c_list: [],
      s_list: [],
      skill: false,
      edit: false,
      password: false,
      detailU: false,
      detailS: false,
      detailP: false,
      detailI: false,
      deleteI: false,
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
    send: function () {
      this.$refs.edit1dialog.edit1 = true;
    },
    editskill(id,name, status, level) {
      this.skillI =id;
      this.skillN = name;
      this.skillS = status;
      this.skillL = level;
      this.$refs.edit2dialog.edit2 = true;
    },
    detailskill(name, status, level) {
      this.skillNN = name;
      this.skillSS = status;
      this.skillLL = level;
      this.detailS = true;
    },
    editproject(name,id) {
      this.projectN = name;
      this.projectid = id;
      this.$refs.edit3dialog.edit3 = true;
    },
    detailproject(name) {
      this.projectNN = name;
      this.detailP = true;
    },
    editissue(id,name, description, level) {
      this.issueI = id;
      this.issueN = name;
      this.issueD = description;
      this.issueL = level;
      this.$refs.edit4dialog.edit4 = true;
    },
    detailissue(name, description, level) {
      this.issueNN = name;
      this.issueDD = description;
      this.issueLL = level;
      this.detailI = true;
    },
    deleteissue(id) {
      this.issueid = id
      this.deleteI = true;
    },
    submit: function() {
        const url = process.env.VUE_APP_URL + '/projects' + '/' + this.id + '?name=' + this.name + '&id=' + this.id;
        axios.put(url, {
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
            this.edit3 = false
          },
          (error) => {
            console.log('登録できませんでした')
            this.edit3 = false
            return error;
          }
        )
      },
  }
};
</script>

<style>
  .line {
    height: 12px;
    border: 0;
    box-shadow: inset 0 12px 12px -12px rgba(0,0,0,0.5);
  }
  #maintitle{
    color: #005500;
    font-weight: bold;
  }
  #subtitle{
    color: #006B3E;
    font-weight: bold;
  }
</style>
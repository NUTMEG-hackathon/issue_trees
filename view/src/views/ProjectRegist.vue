<template>
  <div>
    <v-container align="center">
      <v-card flat>
        <v-card-title class="justify-center"
          ><h1 style="color: #333333">Projectの詳細を登録</h1></v-card-title
        >
      </v-card>
      <v-row>
        <v-col cols="2"></v-col>
        <v-col cols="8">
          <v-text-field
            label="project name"
            background-color="white"
            v-model="projectName"
          ></v-text-field>
          <br />
          <v-form>
            <v-select
              v-model="projectUserIds"
              multiple
              :reduce="(optjions) => options.id"
              key="id"
              label="Projectに参加するメンバー選択"
              :items="users"
              :menu-props="{
                top: true,
                offsetY: true,
              }"
              item-text="name"
              item-value="id"
              outlined
              @change="fetchProjectUsers()"
            />
          </v-form>
          <v-form>
            <v-select
              v-model="clientNum"
              :reduce="(optjions) => options.id"
              key="id"
              label="clientの数"
              :items="[1, 2, 3, 4, 5]"
              :menu-props="{
                top: true,
                offsetY: true,
              }"
              item-text="id"
              item-value="id"
              outlined
            />
          </v-form>
          <v-form v-for="i in clientNum" :key="i">
            <v-card elevation="7" :class="`rounded-xl`">
              <v-row>
                <v-col cols="2" />
                <v-col cols="8">
                  <v-text-field
                    v-model="clients[i]"
                    class="pt-5"
                    key="id"
                    label="client name"
                    outlined
                  ></v-text-field>

                  <v-select
                    v-model="$data['issueNum' + i]"
                    :reduce="(optjions) => options.id"
                    key="id"
                    label="issueの数"
                    :items="[1, 2, 3, 4, 5]"
                    :menu-props="{
                      top: true,
                      offsetY: true,
                    }"
                    item-text="id"
                    item-value="id"
                    outlined
                  />
                  <v-form v-for="j in $data['issueNum' + i]" :key="j">
                    <v-card elevation="7" :class="`rounded-xl`">
                      <v-row>
                        <v-col cols="2" />
                        <v-col cols="8">
                          <v-text-field
                            class="pt-7"
                            v-model="$data['issueName' + i + j]"
                            :reduce="(optjions) => options.id"
                            key="id"
                            label="issue name"
                            :items="issues"
                            :menu-props="{
                              top: true,
                              offsetY: true,
                            }"
                            item-text="name"
                            item-value="id"
                            outlined
                          ></v-text-field>
                          <v-text-field
                            v-model="$data['issueDescription' + i + j]"
                            :reduce="(optjions) => options.id"
                            key="id"
                            label="issue description"
                            :items="issues"
                            :menu-props="{
                              top: true,
                              offsetY: true,
                            }"
                            item-text="name"
                            item-value="id"
                            outlined
                          ></v-text-field>
                          <v-select
                            v-model="$data['issueLevel' + i + j]"
                            :reduce="(optjions) => options.id"
                            key="id"
                            label="issueのlevel"
                            :items="[1, 2, 3, 4, 5]"
                            :menu-props="{
                              top: true,
                              offsetY: true,
                            }"
                            item-text="id"
                            item-value="id"
                            outlined
                          />
                          <v-select
                            v-model="$data['addIssueSkillIds' + i + j]"
                            multiple
                            :reduce="(options) => options.id"
                            key="id"
                            label="skill"
                            :items="skills"
                            :menu-props="{
                              top: true,
                              offsetY: true,
                            }"
                            item-text="name"
                            item-value="id"
                            outlined
                          />
                          <v-select
                            v-model="$data['projectUser' + i + j]"
                            :reduce="(optjions) => options.id"
                            key="id"
                            label="行うuserの選択"
                            :items="projectUsers"
                            :menu-props="{
                              top: true,
                              offsetY: true,
                            }"
                            item-text="name"
                            item-value="id"
                            outlined
                          />
                        </v-col>
                        <v-col cols="2" />
                      </v-row>
                    </v-card>
                    <br />
                    <br />
                  </v-form>
                </v-col>
                <v-col cols="2" />
              </v-row>
            </v-card>
            <br />
            <br />
          </v-form>
          <br />
          <v-btn
            text
            rounded
            large
            color="btn"
            class="pr-4 font-weight-bold"
            @click="register"
            >登録
          </v-btn>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      users: [],
      userName: [],
      userId: [],
      projectUsers: [],
      projectUserIds: [],
      projectName: [],
      projectId: [],
      clientNum: [],
      clients: [],
      clientId: [],
      issueId: [],
      skillName: [],
      issueNum: [],
      issueNumber: [{ id: 1 }, { id: 2 }, { id: 3 }, { id: 4 }, { id: 5 }],

      issueName11: [],
      issueName12: [],
      issueName13: [],
      issueName14: [],
      issueName15: [],

      issueName21: [],
      issueName22: [],
      issueName23: [],
      issueName24: [],
      issueName25: [],

      issueName31: [],
      issueName32: [],
      issueName33: [],
      issueName34: [],
      issueName35: [],

      issueName41: [],
      issueName42: [],
      issueName43: [],
      issueName44: [],
      issueName45: [],

      issueName51: [],
      issueName52: [],
      issueName53: [],
      issueName54: [],
      issueName55: [],

      issueNum1: [],
      issueNum2: [],
      issueNum3: [],
      issueNum4: [],
      issueNum5: [],

      issueDescription11: [],
      issueDescription12: [],
      issueDescription13: [],
      issueDescription14: [],
      issueDescription15: [],

      issueDescription21: [],
      issueDescription22: [],
      issueDescription23: [],
      issueDescription24: [],
      issueDescription25: [],

      issueDescription31: [],
      issueDescription32: [],
      issueDescription33: [],
      issueDescription34: [],
      issueDescription35: [],

      issueDescription41: [],
      issueDescription42: [],
      issueDescription43: [],
      issueDescription44: [],
      issueDescription45: [],

      issueDescription51: [],
      issueDescription52: [],
      issueDescription53: [],
      issueDescription54: [],
      issueDescription55: [],

      issueLevel11: [],
      issueLevel12: [],
      issueLevel13: [],
      issueLevel14: [],
      issueLevel15: [],

      issueLevel21: [],
      issueLevel22: [],
      issueLevel23: [],
      issueLevel24: [],
      issueLevel25: [],

      issueLevel31: [],
      issueLevel32: [],
      issueLevel33: [],
      issueLevel34: [],
      issueLevel35: [],

      issueLevel41: [],
      issueLevel42: [],
      issueLevel43: [],
      issueLevel44: [],
      issueLevel45: [],

      issueLevel51: [],
      issueLevel52: [],
      issueLevel53: [],
      issueLevel54: [],
      issueLevel55: [],

      addIssueSkillIds11: [],
      addIssueSkillIds12: [],
      addIssueSkillIds13: [],
      addIssueSkillIds14: [],
      addIssueSkillIds15: [],

      addIssueSkillIds2: [],
      addIssueSkillIds22: [],
      addIssueSkillIds23: [],
      addIssueSkillIds24: [],
      addIssueSkillIds25: [],

      addIssueSkillIds31: [],
      addIssueSkillIds32: [],
      addIssueSkillIds33: [],
      addIssueSkillIds34: [],
      addIssueSkillIds35: [],

      addIssueSkillIds41: [],
      addIssueSkillIds42: [],
      addIssueSkillIds43: [],
      addIssueSkillIds44: [],
      addIssueSkillIds45: [],

      addIssueSkillIds51: [],
      addIssueSkillIds52: [],
      addIssueSkillIds53: [],
      addIssueSkillIds54: [],
      addIssueSkillIds55: [],

      projectUser11: [],
      projectUser12: [],
      projectUser13: [],
      projectUser14: [],
      projectUser15: [],

      projectUser21: [],
      projectUser22: [],
      projectUser23: [],
      projectUser24: [],
      projectUser25: [],

      projectUser31: [],
      projectUser32: [],
      projectUser33: [],
      projectUser34: [],
      projectUser35: [],

      projectUser41: [],
      projectUser42: [],
      projectUser43: [],
      projectUser44: [],
      projectUser45: [],

      projectUser51: [],
      projectUser52: [],
      projectUser53: [],
      projectUser54: [],
      projectUser55: [],
    };
  },

  methods: {
    register: async function () {
      //projectの登録
      if (this.projectName) {
        var projectParams = {
          name: this.projectName,
        };
        await this.addProject(projectParams);
      }
      console.log(this.projectId);

      const url =
        process.env.VUE_APP_URL +
        "/api/v1/project_user/edit_project_users/" +
        this.projectId;
      var params = {
        user_ids: this.projectUserIds,
      };
      await axios
        .post(url, params, {
          headers: {
            "Content-Type": "application/json",
            "access-token": localStorage.getItem("access-token"),
            client: localStorage.getItem("client"),
            uid: localStorage.getItem("uid"),
          },
        })
        .then((response) => {
          console.log("=====");
          console.log(this.projectId);
          console.log(response);
          console.log("=====");
        });

      for (let i = 1; i < this.clients.length; i++) {
        console.log(this.clients[i]);
        var clientparams = {
          name: this.clients[i],
          project_id: this.projectId,
        };
        await this.addClient(clientparams);

        if (i == 1) {
          for (let j = 0; j < this.issueNum1; j++) {
            if (j == 0) {
              var issueparams11 = {
                name: this.issueName11,
                client_id: this.clientId,
                user_id: this.projectUser11,
                description: this.issueDescription11,
                level: this.issueLevel11,
                skill_ids: this.addIssueSkillIds11,
              };
              await this.addIssue(issueparams11);
            } else if (j == 1) {
              var issueparams12 = {
                name: this.issueName12,
                client_id: this.clientId,
                user_id: this.projectUser12,
                description: this.issueDescription12,
                level: this.issueLevel12,
                skill_ids: this.addIssueSkillIds12,
              };
              await this.addIssue(issueparams12);
            } else if (j == 2) {
              var issueparams13 = {
                name: this.issueName13,
                client_id: this.clientId,
                user_id: this.projectUser13,
                description: this.issueDescription13,
                level: this.issueLevel13,
                skill_ids: this.addIssueSkillIds13,
              };
              await this.addIssue(issueparams13);
            } else if (j == 3) {
              var issueparams14 = {
                name: this.issueName14,
                client_id: this.clientId,
                user_id: this.projectUser14,
                description: this.issueDescription14,
                level: this.issueLevel14,
                skill_ids: this.addIssueSkillIds14,
              };
              await this.addIssue(issueparams14);
            } else if (j == 4) {
              var issueparams15 = {
                name: this.issueName15,
                client_id: this.clientId,
                user_id: this.projectUser15,
                description: this.issueDescription115,
                level: this.issueLevel15,
                skill_ids: this.addIssueSkillIds15,
              };
              await this.addIssue(issueparams15);
            }
          }
        } else if (i == 2) {
          for (let j = 0; j < this.issueNum2; j++) {
            if (j == 0) {
              var issueparams21 = {
                name: this.issueName21,
                client_id: this.clientId,
                user_id: this.projectUser21,
                description: this.issueDescription21,
                level: this.issueLevel21,
                skill_ids: this.addIssueSkillIds21,
              };
              await this.addIssue(issueparams21);
            } else if (j == 1) {
              var issueparams22 = {
                name: this.issueName22,
                client_id: this.clientId,
                user_id: this.projectUser22,
                description: this.issueDescription22,
                level: this.issueLevel22,
                skill_ids: this.addIssueSkillIds22,
              };
              await this.addIssue(issueparams22);
            } else if (j == 2) {
              var issueparams23 = {
                name: this.issueName23,
                client_id: this.clientId,
                user_id: this.projectUser23,
                description: this.issueDescription23,
                level: this.issueLevel23,
                skill_ids: this.addIssueSkillIds23,
              };
              await this.addIssue(issueparams23);
            } else if (j == 3) {
              var issueparams24 = {
                name: this.issueName24,
                client_id: this.clientId,
                user_id: this.projectUser24,
                description: this.issueDescription24,
                level: this.issueLevel24,
                skill_ids: this.addIssueSkillIds24,
              };
              await this.addIssue(issueparams24);
            } else if (j == 4) {
              var issueparams25 = {
                name: this.issueName25,
                client_id: this.clientId,
                user_id: this.projectUser25,
                description: this.issueDescription25,
                level: this.issueLevel25,
                skill_ids: this.addIssueSkillIds25,
              };
              await this.addIssue(issueparams25);
            }
          }
        } else if (i == 3) {
          for (let j = 0; j < this.issueNum3; j++) {
            if (j == 0) {
              var issueparams31 = {
                name: this.issueName31,
                client_id: this.clientId,
                user_id: this.projectUser31,
                description: this.issueDescription31,
                level: this.issueLevel31,
                skill_ids: this.addIssueSkillIds31,
              };
              await this.addIssue(issueparams31);
            } else if (j == 1) {
              var issueparams32 = {
                name: this.issueName32,
                client_id: this.clientId,
                user_id: this.projectUser32,
                description: this.issueDescription32,
                level: this.issueLevel32,
                skill_ids: this.addIssueSkillIds32,
              };
              await this.addIssue(issueparams32);
            } else if (j == 2) {
              var issueparams33 = {
                name: this.issueName33,
                client_id: this.clientId,
                user_id: this.projectUser33,
                description: this.issueDescription33,
                level: this.issueLevel33,
                skill_ids: this.addIssueSkillIds33,
              };
              await this.addIssue(issueparams33);
            } else if (j == 3) {
              var issueparams34 = {
                name: this.issueName34,
                client_id: this.clientId,
                user_id: this.projectUser34,
                description: this.issueDescription34,
                level: this.issueLevel34,
                skill_ids: this.addIssueSkillIds34,
              };
              await this.addIssue(issueparams34);
            } else if (j == 4) {
              var issueparams35 = {
                name: this.issueName35,
                client_id: this.clientId,
                user_id: this.projectUser35,
                description: this.issueDescription35,
                level: this.issueLevel35,
                skill_ids: this.addIssueSkillIds35,
              };
              await this.addIssue(issueparams35);
            }
          }
        } else if (i == 4) {
          for (let j = 0; j < this.issueNum4; j++) {
            if (j == 0) {
              var issueparams41 = {
                name: this.issueName41,
                client_id: this.clientId,
                user_id: this.projectUser41,
                description: this.issueDescription41,
                level: this.issueLevel41,
                skill_ids: this.addIssueSkillIds41,
              };
              await this.addIssue(issueparams41);
            } else if (j == 1) {
              var issueparams42 = {
                name: this.issueName42,
                client_id: this.clientId,
                user_id: this.projectUser42,
                description: this.issueDescription42,
                level: this.issueLevel42,
                skill_ids: this.addIssueSkillIds42,
              };
              await this.addIssue(issueparams42);
            } else if (j == 2) {
              var issueparams43 = {
                name: this.issueName43,
                client_id: this.clientId,
                user_id: this.projectUser43,
                description: this.issueDescription43,
                level: this.issueLevel43,
                skill_ids: this.addIssueSkillIds43,
              };
              await this.addIssue(issueparams43);
            } else if (j == 3) {
              var issueparams44 = {
                name: this.issueName44,
                client_id: this.clientId,
                user_id: this.projectUser44,
                description: this.issueDescription44,
                level: this.issueLevel44,
                skill_ids: this.addIssueSkillIds44,
              };
              await this.addIssue(issueparams44);
            } else if (j == 4) {
              var issueparams45 = {
                name: this.issueName45,
                client_id: this.clientId,
                user_id: this.projectUser45,
                description: this.issueDescription45,
                level: this.issueLevel45,
                skill_ids: this.addIssueSkillIds45,
              };
              await this.addIssue(issueparams45);
            }
          }
        } else if (i == 5) {
          for (let j = 0; j < this.issueNum5; j++) {
            if (j == 0) {
              var issueparams51 = {
                name: this.issueName51,
                client_id: this.clientId,
                user_id: this.projectUser51,
                description: this.issueDescription51,
                level: this.issueLevel51,
                skill_ids: this.addIssueSkillIds51,
              };
              await this.addIssue(issueparams51);
            } else if (j == 1) {
              var issueparams52 = {
                name: this.issueName52,
                client_id: this.clientId,
                user_id: this.projectUser52,
                description: this.issueDescription52,
                level: this.issueLevel52,
                skill_ids: this.addIssueSkillIds52,
              };
              await this.addIssue(issueparams52);
            } else if (j == 2) {
              var issueparams53 = {
                name: this.issueName53,
                client_id: this.clientId,
                user_id: this.projectUser52,
                description: this.issueDescription53,
                level: this.issueLevel53,
                skill_ids: this.addIssueSkillIds53,
              };
              await this.addIssue(issueparams53);
            } else if (j == 3) {
              var issueparams54 = {
                name: this.issueName54,
                client_id: this.clientId,
                user_id: this.projectUser54,
                description: this.issueDescription54,
                level: this.issueLevel54,
                skill_ids: this.addIssueSkillIds54,
              };
              await this.addIssue(issueparams54);
            } else if (j == 4) {
              var issueparams55 = {
                name: this.issueName55,
                client_id: this.clientId,
                user_id: this.projectUser55,
                description: this.issueDescription55,
                level: this.issueLevel55,
                skill_ids: this.addIssueSkillIds55,
              };
              await this.addIssue(issueparams55);
            }
          }
        }
      }
      window.location.href = "/tree";
    },

    addProject: async function (params) {
      const url = process.env.VUE_APP_URL + "/projects";
      await axios
        .post(url, params, {
          headers: {
            "Content-Type": "application/json",
            "access-token": localStorage.getItem("access-token"),
            client: localStorage.getItem("client"),
            uid: localStorage.getItem("uid"),
          },
        })
        .then((response) => {
          console.log("projectIdの取得");
          this.posts = response.data.posts;
          console.log(response);
          this.projectId = response.data.id;
          console.log(this.projectId);
        });
    },

    addClient: async function (clientparams) {
      const url = process.env.VUE_APP_URL + "/clients";
      await axios
        .post(
          url,
          { client: clientparams },
          {
            headers: {
              "Content-Type": "application/json",
              "access-token": localStorage.getItem("access-token"),
              client: localStorage.getItem("client"),
              uid: localStorage.getItem("uid"),
            },
          }
        )
        .then((response) => {
          console.log("clientIdの取得");
          this.posts = response.data.posts;
          console.log(response);
          this.clientId = response.data.id;
          console.log(this.clientId);
        });
    },

    addIssue: async function (issueparams) {
      const url = process.env.VUE_APP_URL + "/issues";
      await axios
        .post(
          url,
          { issue: issueparams },
          {
            headers: {
              "Content-Type": "application/json",
              "access-token": localStorage.getItem("access-token"),
              client: localStorage.getItem("client"),
              uid: localStorage.getItem("uid"),
            },
          }
        )
        .then((response) => {
          this.posts = response.data.posts;
          //console.log(response.data.id);
          this.issueId = response.data.id;
          console.log(this.issueId);
        });
    },
    fetchProjectUsers: async function () {
      console.log(this.projectUserIds);
      var url = process.env.VUE_APP_URL;
      this.projectUsers = [];
      for (let i = 0; i < this.projectUserIds.length; i++) {
        await axios
          .get(url + "/api/v1/user_details/" + this.projectUserIds[i], {
            headers: {
              "Content-Type": "application/json",
              "access-token": localStorage.getItem("access-token"),
              client: localStorage.getItem("client"),
              uid: localStorage.getItem("uid"),
            },
          })
          .then((response) => {
            this.projectUsers.push(response.data);
          });
      }
      console.log(this.projectUsers);
    },
  },
  mounted() {
    const url = process.env.VUE_APP_URL;
    axios
      .get(url + "/api/v1/users/show", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.user = JSON.parse(JSON.stringify(response.data.data));
        console.log(this.user);
        this.userId = this.user.id;
        console.log(this.userId);
      });
    axios
      .get(url + "/api/v1/get_project_user", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.userProjects = response.data;
      });
    axios
      .get(url + "/skills", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.skills = response.data;
        this.skillName = [];
        for (let i = 0; i < this.skills.length; i++) {
          this.skillName.push(this.skills[i].name);
        }
        console.log(this.sskills);
        console.log(this.skillName);
      });
    axios
      .get(url + "/api/v1/users/index", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.users = response.data.data;
        this.userName = [];
        this.projectUserIds = [];
        for (let i = 0; i < this.users.length; i++) {
          this.userName.push(this.users[i].name);
        }
        console.log(this.projectUserIds);
      });
  },
};
</script>,
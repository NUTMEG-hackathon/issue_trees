<template>
  <div id="app" class="container-fluid">
    <div class="panel panel-default">
      <v-dialog v-model="addUserDialog" width="700">
        <v-card>
          <v-card-title class="text-h4 lighten-2">
            <v-row>
              <v-col cols="2" />
              <v-col cols="8" class="my-3 light-green--text">
                Management members
              </v-col>
              <v-col cols="2" class="text-end my-3">
                <v-btn text @click="closeDialog()">
                  <v-icon>mdi-close</v-icon>
                </v-btn>
              </v-col>
            </v-row>
          </v-card-title>
          <v-row>
            <v-col cols="1" />
            <v-col cols="10">
              <v-form>
                <v-select
                  v-model="addProjectUserIds"
                  multiple
                  :reduce="(options) => options.id"
                  key="id"
                  label="select users"
                  :items="notAssignedUsers"
                  :menu-props="{
                    top: true,
                    offsetY: true,
                  }"
                  item-text="name"
                  item-value="id"
                  outlined
                />
              </v-form>
              <v-row>
                <v-col cols="5">
                  <v-text solo class="text-h6"> user_name</v-text>
                </v-col>
                <v-col cols="7">
                  <v-text solo class="text-h6"> skill_name </v-text>
                </v-col>
              </v-row>
              <v-divider />
              <v-divider />
              <br />
              <div
                v-for="(user, i) in usersSkills"
                :key="i"
                item-text="user_name"
              >
                <v-card
                  elevation="0"
                  solo
                  @click="openRemoveProjectUserDialog(user.user_id)"
                >
                  <v-row>
                    <v-col cols="5">
                      {{ user.user_name }}
                    </v-col>
                    <v-col cols="7">
                      <v-text
                        solo
                        v-for="skill in usersSkills[i].skill_names"
                        :key="skill"
                        item-text="user_name"
                      >
                        {{ skill.skill_name }}
                      </v-text>
                    </v-col>
                  </v-row>
                  <br />
                </v-card>
                <v-divider />
                <br />
              </div>
            </v-col>
            <v-col cols="1" />
          </v-row>
          <v-row no-gutters>
            <v-col cols="1" />
            <v-col cols="10">
              <v-card-actions>
                <v-btn class="ma-2" outlined color="red" @click="closeDialog()">
                  cancel
                </v-btn>
                <v-spacer></v-spacer>
                <v-btn class="ma-2" outlined color="blue" @click="addUser()">
                  add
                </v-btn>
              </v-card-actions>
            </v-col>
          </v-row>
        </v-card>
      </v-dialog>
      <v-dialog v-model="removeUserDialog" width="500">
        <v-card>
          <v-card-title class="text-h4 lighten-2">
            <v-row no-gutters>
              <v-col cols="2" />
              <v-col cols="8" class="my-3 light-green--text">
                Remove member
              </v-col>
              <v-col cols="2" />
            </v-row>
          </v-card-title>
          <v-row no-gutters>
            <v-col cols="1" />
            <v-col cols="10" class="my-3 text-h5">
              <v-card-text>
                選択したユーザをこのプロジェクトから<br />
                削除してもよいですか？
              </v-card-text>
              <v-card-actions>
                <v-btn
                  class="ma-2"
                  outlined
                  color="blue"
                  @click="removeUserDialog = false"
                >
                  cancel
                </v-btn>
                <v-spacer></v-spacer>
                <v-btn
                  class="ma-2"
                  outlined
                  color="red"
                  @click="removeProjectUser()"
                >
                  Remove
                </v-btn>
              </v-card-actions>
            </v-col>
            <v-col cols="1" />
          </v-row>
        </v-card>
      </v-dialog>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  props: {
    addUserDialog: Boolean,
    removeUserDialog: Boolean,
    projectId: Number,
    usersSkills: { type: [Array], default: () => [] },
    projectUserIds: { type: [Array], default: () => [] },
  },
  name: "App",
  data() {
    return {
      // project users
      projectUsers: [],
      addProjectUserIds: [],
      userProjectIds: [],
      newUserProjectIds: [],
      // user skills
      userSkills: [],
      // users
      users: [],
      userIds: [],
      notAssignedUserIds: [],
      notAssignedUsers: [],
      // user infomation
      userName: [],
      userId: [],
    };
  },
  mounted() {
    const url = process.env.VUE_APP_URL;
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
      });
  },
  methods: {
    addUser: async function () {
      const url = process.env.VUE_APP_URL;

      this.projectUserIds = this.projectUserIds.concat(this.addProjectUserIds);
      var params = {
        user_ids: this.projectUserIds,
      };
      axios.defaults.headers.common["Content-Type"] = "application/json";
      console.log(params);
      await axios
        .post(
          url + "/api/v1/project_user/edit_project_users/" + this.projectId,
          params,
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
        })
        .catch((error) => {
          console.log(error.response);
        });
      await this.$emit("addUser");
      this.userName = [];
    },
    openRemoveProjectUserDialog: function (userId) {
      const url = process.env.VUE_APP_URL;
      this.userIds = [];
      this.notAssignedUserIds = [];
      for (let i = 0; i < this.users.length; i++) {
        this.userIds.push(this.users[i].id);
      }
      this.notAssignedUserIds = this.userIds;
      for (let i = 0; i < this.projectUserIds.length; i++) {
        this.notAssignedUserIds = this.notAssignedUserIds.filter(
          (n) => n != this.projectUserIds[i]
        );
        console.log(this.notAssignedUserIds);
      }
      for (let i = 0; i < this.notAssignedUserIds.length; i++) {
        axios
          .get(url + "/api/v1/user_details/" + this.notAssignedUserIds[i], {
            headers: {
              "Content-Type": "application/json",
              "access-token": localStorage.getItem("access-token"),
              client: localStorage.getItem("client"),
              uid: localStorage.getItem("uid"),
            },
          })
          .then((response) => {
            this.notAssignedUsers.push(response.data);
          });
      }
      this.userId = userId;
      this.removeUserDialog = true;
      this.$emit("closeRemoveDialog");
    },
    removeProjectUser: async function () {
      const url = process.env.VUE_APP_URL;
      await axios
        .get(url + "/api/v1/get_user_project_ids/" + this.userId, {
          headers: {
            "Content-Type": "application/json",
            "access-token": localStorage.getItem("access-token"),
            client: localStorage.getItem("client"),
            uid: localStorage.getItem("uid"),
          },
        })
        .then((response) => {
          this.userProjectIds = response.data;
        });
      this.newUserProjectIds = await this.userProjectIds.filter(
        (n) => n != this.projectId
      );
      var params = {
        project_ids: this.newUserProjectIds,
      };
      await axios.put(
        url + "/api/v1/project_user/edit_user_projects/" + this.userId,
        {
          project_user_api: params,
        }
      );
      this.addUserDialog = false;
      this.removeUserDialog = false;
    },
    closeDialog: function () {
      this.addUserDialog = false;
      this.removeUserDialog = false;
      this.$emit("closeAddDialog");
    },
  },
};
</script>

<template>
  <div id="app" class="container-fluid">
    <div class="panel panel-default">
      <v-row>
        <v-col cols="1" />
        <v-col cols="3">
          <v-select
            label="Project"
            v-model="userProjectId"
            :items="userProjects"
            item-text="name"
            item-value="project_id"
            @input="selectProject"
          >
          </v-select>
          <v-card elevation="5">
            <v-card-title class="text-h6 justify-center lighten-2">
              Tree options
            </v-card-title>
            <v-row>
              <v-col cols="1" />
              <v-col cols="10">
                <v-text> Nodeの大きさ：{{ radius }}px </v-text>
                <v-form>
                  <v-slider v-model="radius" :max="10" step="1" outlined />
                </v-form>
              </v-col>
              <v-col cols="1" />
            </v-row>
            <v-row>
              <v-col cols="1" />
              <v-col cols="5">
                <v-text> Tree Layout </v-text>
                <v-form>
                  <v-select
                    v-model="layoutType"
                    :items="layoutTypes"
                    item-text="name"
                  />
                </v-form>
              </v-col>
              <v-col cols="5">
                <v-text> Tree Link Layout </v-text>
                <v-select
                  v-model="linkLayout"
                  :items="linkLayouts"
                  item-text="name"
                >
                </v-select>
              </v-col>
              <v-col cols="1" />
            </v-row>
          </v-card>
          <br />
          <v-card elevation="5">
            <v-card-title class="text-h6 justify-center lighten-2">
              members
            </v-card-title>
            <v-row>
              <v-col cols="1" />
              <v-col cols="10">
                <v-row>
                  <v-col cols="5">
                    <v-text solo class="text-subtitle-2"> user_name</v-text>
                  </v-col>
                  <v-col cols="7">
                    <v-text solo class="text-subtitle-2"> skill_name </v-text>
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
                  <v-card elevation="0" solo>
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
                    <v-divider />
                    <br />
                  </v-card>
                </div>
              </v-col>
              <v-col cols="1" />
            </v-row>
          </v-card>
          <br />
          <v-btn
            class="light-green--text"
            @click="openProjectUserDialog()"
            outlined
          >
            Management members
          </v-btn>
          <AddProjectUser
            :addUserDialog="addUserDialog"
            :removeUserDialog="removeUserDialog"
            :projectId="userProjectId"
            :projectUserIds="projectUserIds"
            :usersSkills="usersSkills"
            :userIds="userIds"
            :notAssignedUsers="notAssignedUsers"
            :notAssignedUserIds="notAssignedUserIds"
            @addUser="addUser"
            @removeProjectUser="removeProjectUser"
            @closeAddDialog="closeAddUserDialog"
            @closeRemoveDialog="closeRemoveUserDialog"
          />
        </v-col>
        <v-col cols="8">
          <tree
            ref="tree"
            :identifier="getId"
            :data="tree"
            :radius="radius"
            :layout-type="layoutType"
            :linkLayout="linkLayout"
            contextMenuPlacement="bottom-start"
            class="tree"
            v-bind:style="{ 'font-size': fontSize + 'px' }"
            @clickedText="onClick"
            @expand="onExpand"
            @retract="onRetract"
            @clickedNode="onClickNode"
          >
          </tree>
        </v-col>
      </v-row>
      <AddClient
        :addClientDialog="addClientDialog"
        :projectId="userProjectId"
        @addClient="addClient"
        @closeDialog="closeAddClientDialog"
      />
      <EditClient
        :editClientDialog="editClientDialog"
        :clientName="clientName"
        :projectId="userProjectId"
        :clientId="clientId"
        @editClient="editClient"
        @deleteClient="deleteClient"
        @changeClientDialog="changeClientDialog"
        @closeDialog="closeEditClientDialog"
      />
      <v-dialog persistent v-model="addIssueDialog" width="700">
        <v-card>
          <v-card-title class="text-h4 lighten-2">
            <v-row>
              <v-col cols="3" />
              <v-col cols="6" class="my-3 light-green--text">
                Add issues
              </v-col>
              <v-col cols="1" class="text-end my-3">
                <v-btn text @click="changeClientDialog()">
                  <v-icon>mdi-pencil</v-icon>
                </v-btn>
              </v-col>
              <v-col cols="2" class="text-end my-3">
                <v-btn text @click="addIssueDialog = false">
                  <v-icon>mdi-close</v-icon>
                </v-btn>
              </v-col>
            </v-row>
          </v-card-title>
          <v-row no-gutters>
            <v-col cols="1" />
            <v-col cols="10">
              <v-card-title class="text-left">
                <v-icon class="mr-3">mdi-tag-text-outline</v-icon> issue Name
              </v-card-title>
              <v-text-field v-model="addIssueName" label="issue name" solo>
              </v-text-field>
              <v-card-title class="text-left">
                <v-icon class="mr-3">mdi-message-reply-text-outline</v-icon>
                issue descriptions
              </v-card-title>
              <v-textarea
                v-model="addIssueDescription"
                label="issue descriptions"
                solo
                name="input-7-4"
              ></v-textarea>
              <v-card-title class="text-left"
                ><v-icon class="mr-3">mdi-laptop</v-icon> skills
              </v-card-title>
              <v-form>
                <v-select
                  v-model="addIssueSkillIds"
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
              </v-form>
              <v-card-title class="text-left">
                <v-icon class="mr-3">mdi-chart-box-outline</v-icon> levels
              </v-card-title>
              <v-form>
                <v-select
                  v-model="addIssueLevel"
                  :reduce="(options) => options.id"
                  key="id"
                  label="issue level"
                  :items="levels"
                  :menu-props="{
                    top: true,
                    offsetY: true,
                  }"
                  item-text="name"
                  item-value="id"
                  outlined
                />
              </v-form>
              <v-card-title class="text-left">
                <v-icon class="mr-3">mdi-account-outline</v-icon>
                member
              </v-card-title>
              <v-form>
                <v-select
                  v-model="addIssueUser"
                  :reduce="(options) => options.id"
                  key="id"
                  label="member"
                  :items="projectUsers"
                  :menu-props="{
                    top: true,
                    offsetY: true,
                  }"
                  item-text="name"
                  item-value="user_id"
                  outlined
                />
              </v-form>
              <v-card-actions>
                <v-btn
                  class="ma-2"
                  outlined
                  color="red"
                  @click="addIssueDialog = false"
                >
                  cancel
                </v-btn>
                <v-spacer></v-spacer>
                <v-btn class="ma-2" outlined color="blue" @click="addIssue()">
                  add
                </v-btn>
              </v-card-actions>
            </v-col>
          </v-row>
        </v-card>
      </v-dialog>
      <v-dialog v-model="issueDetailsDialog" width="700">
        <v-card>
          <v-card-title class="text-h4 lighten-2">
            <v-row no-gutters>
              <v-col cols="3" />
              <v-col cols="6" class="my-3 light-green--text"
                >issue details
              </v-col>
              <v-col cols="1" class="text-end my-3">
                <v-btn text @click="changeIssueDialog()">
                  <v-icon>mdi-pencil</v-icon>
                </v-btn>
              </v-col>
              <v-col cols="2" class="text-end my-3">
                <v-btn text @click="issueDetailsDialog = false">
                  <v-icon class="my-3">mdi-close</v-icon>
                </v-btn>
              </v-col>
            </v-row>
          </v-card-title>
          <v-row no-gutters>
            <v-col cols="1" />
            <v-col cols="10">
              <v-card-title class="text-left">
                <v-icon class="mr-3">mdi-tag-text-outline</v-icon>
                issue Name
              </v-card-title>
              <v-text class="px-4" label="issue name" solo>
                {{ issueName }}
              </v-text>
              <v-card-title class="text-left">
                <v-icon class="mr-3">mdi-message-reply-text-outline</v-icon>
                issue descriptions
              </v-card-title>
              <v-text class="px-4" label="issue name" solo>
                {{ issueDescription }}
              </v-text>

              <v-card-title class="text-left">
                <v-icon class="mr-3">mdi-laptop</v-icon> skills
              </v-card-title>
              <v-text
                class="px-4"
                label="member name"
                solo
                v-for="(Skill, i) in issueSkills"
                :key="i"
                item-text="name"
                item-value="id"
                >{{ Skill.name }}
              </v-text>
              <v-card-title class="text-left">
                <v-icon class="mr-3">mdi-chart-box-outline</v-icon> levels
              </v-card-title>
              <v-text class="px-4" label="member name" solo>
                {{ issueLevel }}
              </v-text>
              <v-card-title class="text-left">
                <v-icon class="mr-3">mdi-account-outline</v-icon>
                member
              </v-card-title>
              <v-text class="px-4" label="member name" solo>
                {{ issueUserName }}
              </v-text>
              <br />
              <br />
              <v-btn
                class="ma-2"
                outlined
                large
                color="light-green"
                @click="openDeleteIssueDialog"
              >
                Done
              </v-btn>
            </v-col>
          </v-row>
        </v-card>
      </v-dialog>

      <v-dialog v-model="deleteIssueDialog" width="500">
        <v-card>
          <v-card-title class="text-h4 lighten-2">
            <v-row no-gutters>
              <v-col cols="3" />
              <v-col cols="6" class="my-3 light-green--text">
                Finish issue
              </v-col>
              <v-col cols="3" />
            </v-row>
          </v-card-title>
          <v-row no-gutters>
            <v-col cols="1" />
            <v-col cols="10" class="my-3 text-h5">
              <v-card-text> 完了したissueを削除してもよいですか？ </v-card-text>
              <v-card-actions>
                <v-btn
                  class="ma-2"
                  outlined
                  color="blue"
                  @click="deleteIssueDialog = false"
                >
                  cancel
                </v-btn>
                <v-spacer></v-spacer>
                <v-btn class="ma-2" outlined color="red" @click="deleteIssue()">
                  Delete
                </v-btn>
              </v-card-actions>
            </v-col>
            <v-col cols="1" />
          </v-row>
        </v-card>
      </v-dialog>

      <v-dialog persistent v-model="editIssueDetailsDialog" width="700">
        <v-card>
          <v-card-title class="text-h4 lighten-2">
            <v-row no-gutters>
              <v-col cols="3" />
              <v-col cols="6" class="my-3 light-green--text">
                Edit issue details
              </v-col>
              <v-col cols="1" class="text-end my-3">
                <v-btn text @click="changeIssueDialog()">
                  <v-icon>mdi-arrow-left-top</v-icon>
                </v-btn>
              </v-col>
              <v-col cols="2" class="text-end my-3">
                <v-btn text @click="editIssueDetailsDialog = false">
                  <v-icon class="my-3">mdi-close</v-icon>
                </v-btn>
              </v-col>
            </v-row>
          </v-card-title>
          <v-row no-gutters>
            <v-col cols="1" />
            <v-col cols="10">
              <v-card-title class="text-left">
                <v-icon class="mr-3">mdi-tag-text-outline</v-icon> issue Name
              </v-card-title>
              <v-text-field
                v-model="issueName"
                label="issue name"
                clearable
                outlined
              ></v-text-field>
              <v-card-title class="text-left">
                <v-icon class="mr-3">mdi-message-reply-text-outline</v-icon>
                issue descriptions
              </v-card-title>
              <v-textarea
                v-model="issueDescription"
                label="issue descriptions"
                clearable
                outlined
              ></v-textarea>
              <v-card-title class="text-left">
                <v-icon class="mr-3">mdi-laptop</v-icon> skills
              </v-card-title>
              <v-form>
                <v-select
                  v-model="issueSkillIds"
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
              </v-form>
              <v-card-title class="text-left">
                <v-icon class="mr-3">mdi-chart-box-outline</v-icon> levels
              </v-card-title>
              <v-form>
                <v-select
                  v-model="issueLevel"
                  :reduce="(options) => options.id"
                  key="id"
                  label="issue level"
                  :items="levels"
                  :menu-props="{
                    top: true,
                    offsetY: true,
                  }"
                  item-text="name"
                  item-value="id"
                  outlined
                />
              </v-form>
              <v-card-title class="text-left">
                <v-icon class="mr-3">mdi-account-outline</v-icon> member
              </v-card-title>
              <v-form>
                <v-select
                  v-model="issueUser.id"
                  :reduce="(options) => options.id"
                  key="id"
                  label="member"
                  :items="projectUsers"
                  :menu-props="{
                    top: true,
                    offsetY: true,
                  }"
                  item-text="name"
                  item-value="user_id"
                  outlined
                />
              </v-form>
              <v-btn
                class="ma-2"
                outlined
                large
                color="light-green"
                @click="editIssueDetails"
              >
                Edit
              </v-btn>
            </v-col>
          </v-row>
        </v-card>
      </v-dialog>
    </div>
  </div>
</template>

<script>
import AddProjectUser from "@/components/Tree/AddProjectUser.vue";
import AddClient from "@/components/Tree/AddClient.vue";
import EditClient from "@/components/Tree/EditClient.vue";
import { tree } from "vued3tree";
import axios from "axios";
Object.assign(tree, {
  type: "tree",
  layoutType: "vertical",
  radius: 5,
  linkLayout: "bezier",
  events: [],
});
export default {
  name: "App",
  data() {
    return {
      // tree
      tree: {
        name: "",
        children: [],
      },
      radius: 5,
      layoutType: "vertical",
      layoutTypes: [
        { name: "vertical" },
        { name: "horizontal" },
        { name: "circular" },
      ],
      linkLayout: "bezier",
      linkLayouts: [{ name: "bezier" }, { name: "orthogonal" }],
      // levels
      levels: [
        {
          id: 1,
          name: 1,
        },
        {
          id: 2,
          name: 2,
        },
        {
          id: 3,
          name: 3,
        },
        {
          id: 4,
          name: 4,
        },
        {
          id: 5,
          name: 5,
        },
      ],
      // Dialog
      addUserDialog: false,
      addClientDialog: false,
      editClientDialog: false,
      deleteClientDialog: false,
      addIssueDialog: false,
      deleteIssueDialog: false,
      issueDetailsDialog: false,
      editIssueDetailsDialog: false,
      // events
      isChildNode: false,
      event: [],
      events: [],
      // skill
      skills: [],
      skillName: [],
      skillNum: 1,
      // user
      users: [],
      userIds: [],
      userSkills: [],
      usersSkills: [],
      notAssignedUserIds: [],
      notAssignedUsers: [],
      // project
      projects: [],
      projectUsers: [],
      projectUserIds: [],
      // client
      clients: [],
      clientId: [],
      clientName: [],
      // issue
      issue: [],
      issues: [],
      issueId: [],
      issueName: [],
      issueDescription: [],
      issueLevel: [],
      issueClientId: [],
      issueUserId: [],
      issueUserName: [],
      issueUser: [],
      // user_project
      userProject: [],
      userProjects: [],
      userProjectId: [],
      userProjectName: [],
      // project_client
      projectClients: [],
      projectClientsId: [],
      // client_issue
      clientIssue: [],
      clientIssues: [],
      // add issue
      addIssueName: [],
      addIssueDescription: [],
      addIssueLevel: [],
      addIssueClientId: [],
      addIssueUser: [],
      addIssueSkillIds: [],
      // issue_details
      issueDetails: [],
      issueSkill: [],
      issueSkills: [],
      issueSkillIds: [],
      issueSkillsParams: [],
    };
  },
  components: {
    tree,
    AddProjectUser,
    AddClient,
    EditClient,
  },
  mounted() {
    const url = process.env.VUE_APP_URL;
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
      });
    axios
      .get(url + "/projects", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.projects = response.data;
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
        this.users = JSON.parse(JSON.stringify(response.data.data));
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
        if (this.userProjects) {
          this.userProjectId = this.userProjects[0].id;
          this.selectProject();
        }
      });
  },
  methods: {
    getId(node) {
      return node.id;
    },
    onClick(evt) {
      this.onEvent("clickedText", evt);
      var data = JSON.parse(JSON.stringify(evt.data));
      const url = process.env.VUE_APP_URL;
      this.event = data;
      this.events = [];
      if (!this.isChildNode) {
        this.issueId = data.issue_id;
        this.issueName = data.name;
        this.issueClientId = data.client_id;
        this.issueUserId = data.user_id;
        this.issueDescription = data.description;
        this.issueLevel = data.level;
        this.issueDetailsDialog = true;
        this.editIssueDetailsDialog = false;

        axios
          .get(url + "/api/v1/get_issue_details/" + this.issueId, {
            headers: {
              "Content-Type": "application/json",
              "access-token": localStorage.getItem("access-token"),
              client: localStorage.getItem("client"),
              uid: localStorage.getItem("uid"),
            },
          })
          .then((response) => {
            this.issueDetails = response.data;
            this.issueUserName = this.issueDetails[0].user_name;
          });
        axios
          .get(url + "/issues/" + this.issueId, {
            headers: {
              "Content-Type": "application/json",
              "access-token": localStorage.getItem("access-token"),
              client: localStorage.getItem("client"),
              uid: localStorage.getItem("uid"),
            },
          })
          .then((response) => {
            this.issue = response.data;
          });
        axios
          .get(url + "/api/v1/get_issue_user/" + this.issueId, {
            headers: {
              "Content-Type": "application/json",
              "access-token": localStorage.getItem("access-token"),
              client: localStorage.getItem("client"),
              uid: localStorage.getItem("uid"),
            },
          })
          .then((response) => {
            this.issueUser = response.data;
            this.issueUserId = this.issueUser.id;
            this.issueUserName = this.issueUser.name;
          });
        axios
          .get(url + "/api/v1/get_issue_skill/" + this.issueId, {
            headers: {
              "Content-Type": "application/json",
              "access-token": localStorage.getItem("access-token"),
              client: localStorage.getItem("client"),
              uid: localStorage.getItem("uid"),
            },
          })
          .then((response) => {
            this.issueSkills = response.data;
          });
        axios
          .get(url + "/api/v1/get_issue_skill_ids/" + this.issueId, {
            headers: {
              "Content-Type": "application/json",
              "access-token": localStorage.getItem("access-token"),
              client: localStorage.getItem("client"),
              uid: localStorage.getItem("uid"),
            },
          })
          .then((response) => {
            this.issueSkillIds = response.data;
          });
      } else if (data.client_id) {
        this.clientId = data.client_id;
        this.clientName = data.name;
        this.addIssueDialog = true;
      } else {
        this.addClientDialog = true;
      }
    },
    onClickNode(evt) {
      this.onEvent("clickedNode", evt);
    },
    onExpand(evt) {
      this.onEvent("onExpand", evt);
    },
    onRetract(evt) {
      this.onEvent("onRetract", evt);
    },
    onEvent(eventName, data) {
      this.events.push({ eventName, data: data.data });
      if (this.events[0].data.issue_id) {
        this.isChildNode = false;
      } else {
        this.isChildNode = true;
      }
    },
    fetchProjectUsers: async function () {
      var url = process.env.VUE_APP_URL;
      this.projectUsers = [];
      this.projectUserIds = [];
      await axios
        .get(url + "/api/v1/get_project_users/" + this.userProjectId, {
          headers: {
            "Content-Type": "application/json",
            "access-token": localStorage.getItem("access-token"),
            client: localStorage.getItem("client"),
            uid: localStorage.getItem("uid"),
          },
        })
        .then((response) => {
          this.projectUsers = response.data;
        });
      for (let i = 0; i < this.projectUsers.length; i++) {
        this.projectUserIds.push(this.projectUsers[i].user_id);
      }
    },
    fetchUserSkills: async function (user_id) {
      var url = process.env.VUE_APP_URL;
      await axios
        .get(url + "/api/v1/get_user_skill_details/" + user_id, {
          headers: {
            "Content-Type": "application/json",
            "access-token": localStorage.getItem("access-token"),
            client: localStorage.getItem("client"),
            uid: localStorage.getItem("uid"),
          },
        })
        .then((response) => {
          this.userSkills = response.data[0];
        });
    },
    addUser: function () {
      this.selectProject();
      this.addUserDialog = false;
    },
    removeProjectUser: function () {
      this.selectProject();
      this.addUserDialog = false;
      this.removeUserDialog = false;
    },
    addClient: function () {
      this.selectProject();
      this.addClientDialog = false;
    },
    openProjectUserDialog: function () {
      const url = process.env.VUE_APP_URL;
      this.userIds = [];
      this.notAssignedUsers = [];
      this.notAssignedUserIds = [];
      for (let i = 0; i < this.users.length; i++) {
        this.userIds.push(this.users[i].id);
      }
      this.notAssignedUserIds = this.userIds;
      for (let i = 0; i < this.projectUserIds.length; i++) {
        this.notAssignedUserIds = this.notAssignedUserIds.filter(
          (n) => n != this.projectUserIds[i]
        );
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
      this.addUserDialog = true;
    },
    closeAddClientDialog: function () {
      this.addClientDialog = false;
    },
    closeEditClientDialog: function () {
      this.editClientDialog = false;
    },
    closeAddUserDialog: function () {
      this.addUserDialog = false;
    },
    closeRemoveUserDialog: function () {
      this.selectProject();
      this.addUserDialog = false;
      this.removeUserDialog = false;
    },
    editClient: function () {
      this.selectProject();
      this.editClientDialog = false;
      this.addIssueDialog = false;
    },
    deleteClient: function () {
      this.selectProject();
      this.editClientDialog = false;
      this.addIssueDialog = false;
    },
    addIssue: function () {
      const url = process.env.VUE_APP_URL;
      console.log(this.addIssueUser);
      var params = {
        name: this.addIssueName,
        client_id: this.clientId,
        user_id: this.addIssueUser,
        description: this.addIssueDescription,
        level: this.addIssueLevel,
        skill_ids: this.addIssueSkillIds,
      };
      axios.defaults.headers.common["Content-Type"] = "application/json";
      axios.post(
        url + "/issues/",
        { issue: params },
        {
          headers: {
            "access-token": localStorage.getItem("access-token"),
            client: localStorage.getItem("client"),
            uid: localStorage.getItem("uid"),
          },
        }
      );
      this.addIssueName = [];
      this.addIssueUser = [];
      this.addIssueDescription = [];
      this.addIssueLevel = [];
      this.addIssueSkillIds = [];
      this.selectProject();
      this.addIssueDialog = false;
    },
    getProject: async function (id) {
      await axios
        .get(process.env.VUE_APP_URL + "/api/v1/get_user_project/" + id, {
          headers: {
            "Content-Type": "application/json",
            "access-token": localStorage.getItem("access-token"),
            client: localStorage.getItem("client"),
            uid: localStorage.getItem("uid"),
          },
        })
        .then((response) => {
          this.userProject = response.data;
          this.userProjectName = this.userProject.name;
          this.userProjectId = this.userProject.project_id;
        });
    },
    getClients: async function () {
      await axios
        .get(
          process.env.VUE_APP_URL +
            "/api/v1/get_project_client/" +
            this.userProjectId,
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
          this.projectClients = response.data;
        });
      this.projectClientsId = [];
    },
    getIssues: async function () {
      this.clientIssues = [];
      for (let i = 0; i < this.projectClients.length; i++) {
        await axios
          .get(
            process.env.VUE_APP_URL +
              "/api/v1/get_client_issue/" +
              this.projectClients[i].client_id,
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
            this.clientIssue = response.data;
            this.clientIssues.push(this.clientIssue);
          });
      }
    },
    setTree: async function () {
      this.tree.children = [];
      this.tree.name = this.userProjectName;
      for (let i = 0; i < this.projectClients.length; i++) {
        this.tree.children.push({
          name: this.projectClients[i].name,
          client_id: this.projectClients[i].client_id,
          children: [],
        });
      }
      for (let i = 0; i < this.tree.children.length; i++) {
        for (let j = 0; j < this.clientIssues[i].length; j++) {
          if (
            this.clientIssues[i][j].client_id == this.tree.children[i].client_id
          ) {
            this.tree.children[i].children.push({
              issue_id: this.clientIssues[i][j].id,
              name: this.clientIssues[i][j].name,
              client_id: this.clientIssues[i][j].client_id,
              user_id: this.clientIssues[i][j].user_id,
              description: this.clientIssues[i][j].description,
              level: this.clientIssues[i][j].level,
            });
          }
        }
      }
    },
    selectProject: async function () {
      await this.getProject(this.userProjectId);
      await this.getClients();
      await this.getIssues();
      await this.setTree();
      await this.fetchProjectUsers();
      this.usersSkills = [];
      for (let i = 0; i < this.projectUserIds.length; i++) {
        await this.fetchUserSkills(this.projectUserIds[i]);
        this.usersSkills.push(this.userSkills);
      }
    },
    changeClientDialog: function () {
      if (this.addIssueDialog && !this.editClientDialog) {
        this.addIssueDialog = false;
        this.editClientDialog = true;
      } else if (!this.addIssueDialog && this.editClientDialog) {
        this.addIssueDialog = true;
        this.editClientDialog = false;
      }
    },
    changeIssueDialog: function () {
      if (this.issueDetailsDialog == true) {
        this.issueDetailsDialog = false;
        this.editIssueDetailsDialog = true;
      } else {
        this.issueDetailsDialog = true;
        this.editIssueDetailsDialog = false;
      }
    },
    editIssueDetails: function () {
      const url = process.env.VUE_APP_URL;
      const id = this.issueId;
      var issueParams = {
        name: this.issueName,
        client_id: this.issueClientId,
        user_id: this.issueUser.id,
        description: this.issueDescription,
        level: this.issueLevel,
        skill_ids: this.issueSkillIds,
      };
      axios.defaults.headers.common["Content-Type"] = "application/json";
      axios
        .put(
          url + "/issues/" + id,
          { issue: issueParams },
          {
            headers: {
              "access-token": localStorage.getItem("access-token"),
              client: localStorage.getItem("client"),
              uid: localStorage.getItem("uid"),
            },
          }
        )
        .then(() => {
          this.editIssueDetailsDialog = false;
        });
      this.selectProject();
    },
    openDeleteIssueDialog: function () {
      this.issueDetailsDialog = false;
      this.deleteIssueDialog = true;
    },
    deleteIssue: function () {
      const url = process.env.VUE_APP_URL;
      axios.delete(url + "/issues/" + this.issueId);
      this.deleteIssueDialog = false;
      this.selectProject();
    },
  },
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 5px;
}
.events_title {
  color: #fff;
}
.events {
  color: #9ccc65;
}
.text {
  font-size: 30px;
}
.treeclass .nodetree text {
  font-size: 15px;
  cursor: pointer;
}
.tree {
  height: 500px;
}
.graph-root {
  height: 800px;
  width: 100%;
}
.feedback {
  height: 50px;
  line-height: 50px;
  vertical-align: middle;
}
.log {
  height: 200px;
  overflow-x: auto;
  overflow-y: auto;
  overflow: auto;
  text-align: left;
}
</style>
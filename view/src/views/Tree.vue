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
          <div class="light-green lighten-2 events_title panel-heading">
            Events
          </div>
          <div class="events panel-body log">
            <div v-for="(event, index) in events" :key="index">
              <p>
                <b>Name:</b> {{ event.eventName }} <b>Data:</b
                >{{ event.data.name }}
              </p>
            </div>
          </div>
        </v-col>
        <v-col cols="8">
          <div class="panel panel-default">
            <tree
              ref="tree"
              v-model="currentData"
              :nodeTextDisplay="nodeTextDisplay"
              :identifier="getId"
              :data="tree"
              :node-text="nodeText"
              radius="6"
              layout-type="vertical"
              :duration="duration"
              contextMenuPlacement="bottom-start"
              class="tree"
              @clickedText="onClick"
              @expand="onExpand"
              @retract="onRetract"
              @clickedNode="onClickNode"
            >
            </tree>
          </div>
        </v-col>
      </v-row>
      <v-dialog persistent v-model="addIssueDialog" width="700">
        <v-card>
          <v-card-title class="text-h4 lighten-2">
            <v-row>
              <v-col cols="3" />
              <v-col cols="6" class="my-3 light-green--text">
                Add issues
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
              <v-text-field v-model="IssueName" label="issue name" solo>
              </v-text-field>
              <v-card-title class="text-left">
                <v-icon class="mr-3">mdi-message-reply-text-outline</v-icon>
                issue descriptions
              </v-card-title>
              <v-textarea
                v-model="issueDescription"
                label="issue descriptions"
                solo
                name="input-7-4"
              ></v-textarea>
              <v-card-title class="text-left"
                ><v-icon class="mr-3">mdi-laptop</v-icon> skills
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
                <v-icon class="mr-3">mdi-account-outline</v-icon>
                member
              </v-card-title>
              <v-form>
                <v-select
                  :reduce="(options) => options.id"
                  key="id"
                  label="member"
                  :items="users"
                  :menu-props="{
                    top: true,
                    offsetY: true,
                  }"
                  item-text="name"
                  item-value="id"
                  outlined
                  @change="setUser"
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
                <v-btn text @click="changeDialog()">
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

      <v-dialog v-model="deleteIssueDialog">
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
                  @click="addIssueDialog = false"
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
                <v-btn text @click="changeDialog()">
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
                  v-model="issueUser"
                  :reduce="(options) => options.id"
                  key="id"
                  label="member"
                  :items="users"
                  :menu-props="{
                    top: true,
                    offsetY: true,
                  }"
                  item-text="name"
                  item-value="id"
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
import { tree } from "vued3tree";
import axios from "axios";
import data from "../../data/data";
let currentId = 500;
const removeElement = (arr, element) => {
  const index = arr.indexOf(element);
  if (index === -1) {
    return;
  }
  arr.splice(index, 1);
};
Object.assign(data, {
  type: "tree",
  layoutType: "horizontal",
  duration: 750,
  nodeText: "name",
  currentData: null,
  isLoading: false,
  isUnderGremlinsAttack: false,
  nodeTextDisplay: "all",
  linkLayout: "bezier",
  events: [],
});
export default {
  name: "App",
  data() {
    return {
      tree: {
        name: "",
        children: [],
      },
      Details: "",
      skillNumber: [
        { id: 1 },
        { id: 2 },
        { id: 3 },
        { id: 4 },
        { id: 5 },
        { id: 6 },
        { id: 7 },
        { id: 8 },
        { id: 9 },
        { id: 10 },
      ],
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
      // Node
      newNode: [],
      // Dialog
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
      // project
      projects: [],
      // client
      clients: [],
      // issue
      issue: [],
      issues: [],
      issueId: [],
      issueName: [],
      issueDescription: [],
      issueLevel: [],
      issueClientId: [],
      issueUser: [],
      issueUserId: [],
      issueUserName: [],
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
      });
  },
  methods: {
    async do(action) {
      if (this.currentData) {
        this.isLoading = true;
        await this.$refs["tree"][action](this.currentData);
        this.isLoading = false;
      }
    },
    getId(node) {
      return node.id;
    },
    expandAll() {
      this.do("expandAll");
    },
    collapseAll() {
      this.do("collapseAll");
    },
    showOnly() {
      this.do("showOnly");
    },
    show() {
      this.do("show");
    },
    onClick(evt) {
      this.onEvent("clickedText", evt);
      var data = JSON.parse(JSON.stringify(evt.data));
      this.issueId = data.issue_id;
      this.issueName = data.name;
      this.issueClientId = data.client_id;
      this.issueUserId = data.user_id;
      this.issueDescription = data.description;
      this.issueLevel = data.level;
      if (this.isChildNode) {
        this.addIssueDialog = true;
      } else {
        this.issueDetailsDialog = true;
        this.editIssueDetailsDialog = false;
      }
      this.event = data;
      this.events = [];
      const url = process.env.VUE_APP_URL;
      console.log(data);
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
          this.issueSkillIds =
            this.issueSkills[this.issueSkills.length - 1].issue_skill_ids;
        });
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
      if (this.events[0].data.children === undefined) {
        this.isChildNode = false;
      } else {
        this.isChildNode = true;
      }
    },
    addFor(data) {
      const newData = {
        id: currentId++,
        children: [],
        name: data.name,
      };
      this.newNode.push(newData);
    },
    remove(data, node) {
      const parent = node.parent.data;
      removeElement(parent.children, data);
    },
    addIssue: function () {
      const url = process.env.VUE_APP_URL;
      this.issueUser = [];
      this.issueSkills = [];
      var params = {
        name: this.IssueName,
        client_id: this.issueClientId,
        user_id: this.issueUser,
        description: this.issueDescription,
        level: this.issueLevel,
        skill_ids: this.issueSkillIds,
      };
      axios.defaults.headers.common["Content-Type"] = "application/json";
      axios
        .post(
          url + "/issues/",
          { issue: params },
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
      this.addFor(this.event);
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
              // user_name: this.clientIssues[i][j].user_name,
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
    },
    changeDialog: function () {
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
        user_id: this.issueUser,
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
        .then((response) => {
          console.log(response.data);
          this.editIssueDetailsDialog = false;
        })
        .catch((error) => {
          console.log(error.response);
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
    setUser: function (event) {
      this.issueUser = event;
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
.tree {
  font-size: 10px;
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
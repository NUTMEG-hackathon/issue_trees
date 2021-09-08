<template>
  <div id="app" class="container-fluid">
    <div class="panel panel-default">
      <v-row>
        <v-col cols="1" />
        <v-col cols="3">
          <v-select
            label="Project"
            v-model="user_project_id"
            :items="user_projects"
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
      <v-dialog persistent v-model="addIssueDialog" width="500">
        <v-card>
          <v-card-title class="text-h4 lighten-2">
            <v-row>
              <v-col cols="3" />
              <v-col cols="6" class="my-3 light-green--text">
                Add issues
              </v-col>
              <v-col cols="3" class="text-end my-3">
                <v-btn text @click="addIssueDialog = false">
                  <v-icon>mdi-close</v-icon>
                </v-btn>
              </v-col>
            </v-row>
          </v-card-title>
          <v-row no-gutters>
            <v-col cols="1" />
            <v-col cols="10">
              <v-card-title class="text-left"
                ><v-icon class="mr-3">mdi-tag-text-outline</v-icon> issue Name </v-card-title
              ><v-text-field
                class="px-4"
                label="issue name"
                solo
              ></v-text-field>
              <v-card-title class="text-left"
                ><v-icon class="mr-3">mdi-message-reply-text-outline</v-icon>
                issue descriptions
              </v-card-title>
              <v-textarea
                class="px-4"
                v-model="Details"
                label="issue descriptions"
                solo
                name="input-7-4"
              ></v-textarea>
              <v-card-title class="text-left"
                ><v-icon class="mr-3">mdi-laptop</v-icon> skills
              </v-card-title>
              <v-card-text>
                <v-form>
                  <v-select
                    multiple
                    :reduce="(options) => options.id"
                    key="id"
                    label="skill"
                    placeholder="Filter Skills ..."
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
              </v-card-text>
              <v-card-title class="text-left"
                ><v-icon class="mr-3">mdi-account-group</v-icon> member
              </v-card-title>
              <v-card-text>
                <v-form>
                  <v-select
                    :reduce="(options) => options.id"
                    key="id"
                    label="member"
                    placeholder="Filter member ..."
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
              </v-card-text>
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
                <v-btn class="ma-2" outlined color="blue" @click="addIssue">
                  add
                </v-btn>
              </v-card-actions>
            </v-col>
          </v-row>
        </v-card>
      </v-dialog>
      <v-dialog persistent v-model="issueDetails" width="500">
        <v-card>
          <v-card-title class="text-h4 lighten-2">
            <v-row no-gutters>
              <v-col cols="3" />
              <v-col cols="6" class="my-3 light-green--text"
                >issue details
              </v-col>
              <v-col cols="3" class="text-end my-3">
                <v-btn text @click="issueDetails = false">
                  <v-icon class="my-3">mdi-close</v-icon>
                </v-btn>
              </v-col>
            </v-row>
          </v-card-title>
          <v-row no-gutters>
            <v-col cols="1" />
            <v-col cols="10">
              <v-card-title class="text-left"
                ><v-icon class="mr-3">mdi-tag-text-outline</v-icon> issue Name </v-card-title
              ><v-text class="px-4" label="issue name" solo>{{
                currentNodeName
              }}</v-text>
              <v-card-title class="text-left"
                ><v-icon class="mr-3">mdi-message-reply-text-outline</v-icon>
                issue descriptions
              </v-card-title>
              <v-text class="px-4" label="issue name" solo>{{
                currentNodeDescriptions
              }}</v-text>

              <v-card-title class="text-left"
                ><v-icon class="mr-3">mdi-laptop</v-icon> skills
              </v-card-title>
              <v-card-title class="text-left"
                ><v-icon class="mr-3">mdi-account-group</v-icon> member
              </v-card-title>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="primary" text @click="issueDetails = false">
                  done
                </v-btn>
              </v-card-actions>
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
      newNode: [],
      currentNodeName: [],
      currentNodeDescriptions: [],
      skillName: [],
      status: [],
      email: [],
      addIssueDialog: false,
      issueDetails: false,
      isChildNode: false,
      event: [],
      events: [],
      skills: [],
      users: [],
      projects: [],
      clients: [],
      issues: [],
      user_projects: [],
      user_project_id: [],
      user_project_name: [],
      project_name: [],
      project_clients: [],
      project_client_id: [],
      project_clients_id: [],
      project_client_name: [],
      client_issue: [],
      client_issues: [],
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
        this.user_projects = response.data;
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
      this.currentNodeName = data.name;
      this.currentNodeDescriptions = data.description;
      console.log(data);
      if (this.isChildNode) {
        this.addIssueDialog = true;
      } else {
        this.issueDetails = true;
      }
      this.event = data;
      this.events = [];
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
      this.addFor(this.event);
      console.log(this.newNode);
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
          this.user_project = response.data;
          this.user_project_name = this.user_project.name;
          this.user_project_id = this.user_project.project_id;
        });
    },
    getClients: async function () {
      await axios
        .get(
          process.env.VUE_APP_URL +
            "/api/v1/get_project_client/" +
            this.user_project_id,
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
          this.project_clients = response.data;
        });
      this.project_clients_id = [];
    },
    getIssues: async function () {
      this.client_issues = [];
      for (let i = 0; i < this.project_clients.length; i++) {
        await axios
          .get(
            process.env.VUE_APP_URL +
              "/api/v1/get_client_issue/" +
              this.project_clients[i].client_id,
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
            this.client_issue = response.data;
            this.client_issues.push(this.client_issue);
          });
      }
    },
    setTree: async function () {
      this.tree.children = [];
      this.tree.name = this.user_project_name;
      for (let i = 0; i < this.project_clients.length; i++) {
        this.tree.children.push({
          name: this.project_clients[i].name,
          client_id: this.project_clients[i].client_id,
          children: [],
        });
      }
      for (let i = 0; i < this.tree.children.length; i++) {
        for (let j = 0; j < this.client_issues[i].length; j++) {
          if (
            this.client_issues[i][j].client_id ==
            this.tree.children[i].client_id
          ) {
            this.tree.children[i].children.push({
              name: this.client_issues[i][j].name,
              client_id: this.client_issues[i][j].client_id,
              user_id: this.client_issues[i][j].user_id,
              description: this.client_issues[i][j].description,
              level: this.client_issues[i][j].level,
            });
          }
        }
      }
    },
    selectProject: async function () {
      await this.getProject(this.user_project_id);
      await this.getClients();
      await this.getIssues();
      await this.setTree();
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
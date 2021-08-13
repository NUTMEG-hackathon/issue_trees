<template>
  <div id="app" class="container-fluid">
    <div class="panel panel-default">
      <v-row>
        <v-col cols="1" />
        <v-col cols="3">
          <v-select
            label="Project"
            v-model="project_name"
            :items="user_projects"
            item-text="name"
            item-value="name"
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
          <v-card-title class="text-h4 justify-center light-green lighten-2">
            <v-row>
              <v-col cols="3" />
              <v-col cols="6"> add issues </v-col>
              <v-col cols="3" class="text-end">
                <v-btn text @click="addIssueDialog = false">
                  <v-icon>mdi-close</v-icon>
                </v-btn>
              </v-col>
            </v-row>
          </v-card-title>
          <v-row>
            <v-col cols="1" />
            <v-col cols="10">
              <v-card-title
                class="text-h5 justify-center text-decoration-underline"
              >
                issue Name </v-card-title
              ><v-text-field
                label="issue name"
                placeholder="Placeholder"
                solo
              ></v-text-field>
              <v-card-title
                class="text-h5 justify-center text-decoration-underline"
              >
                issue descriptions
              </v-card-title>
              <v-textarea
                v-model="Details"
                solo
                name="input-7-4"
                label="Solo textarea"
              ></v-textarea>
              <v-card-title
                class="text-h5 justify-center text-decoration-underline"
              >
                skills
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
              <v-card-title
                class="text-h5 justify-center text-decoration-underline"
              >
                member
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
                <v-btn color="error" text @click="addIssueDialog = false">
                  cancel
                </v-btn>
                <v-spacer></v-spacer>
                <v-btn color="primary" text @click="addIssue"> add </v-btn>
              </v-card-actions>
            </v-col>
            <v-col cols="1" />
          </v-row>
        </v-card>
      </v-dialog>
      <v-dialog persistent v-model="issueDetails" width="500">
        <v-card>
          <v-card-title class="text-h4 light-green justify-center lighten-2">
            <v-row>
              <v-col cols="3" />
              <v-col cols="6">issue details </v-col>
              <v-col cols="3" class="text-end">
                <v-btn text @click="issueDetails = false">
                  <v-icon>mdi-close</v-icon>
                </v-btn>
              </v-col>
            </v-row>
          </v-card-title>
          <v-card-title
            class="text-h5 justify-center text-decoration-underline"
          >
            issue Name </v-card-title
          ><v-text class="text">{{ currentNodeName }}</v-text>
          <v-card-title
            class="text-h5 justify-center text-decoration-underline"
          >
            issue descriptions
          </v-card-title>
          <v-textarea
            solo
            name="input-7-4"
            label="please write detail here"
            value="email"
          ></v-textarea>
          <v-card-title
            class="text-h5 justify-center text-decoration-underline"
          >
            skills
          </v-card-title>
          <v-card-title
            class="text-h5 justify-center text-decoration-underline"
          >
            member
          </v-card-title>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="primary" text @click="issueDetails = false">
              done
            </v-btn>
          </v-card-actions>
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
        name: "efficientree",
        children: [
          {
            name: "frontend",
            children: [{ name: "issue1" }, { name: "issue2" }],
          },
          {
            name: "backend",
            children: [
              { name: "issue3" },
              { name: "issue4" },
              { name: "issue5" },
            ],
          },
        ],
      },
      Details: "write issue descriptions",
      newNode: [],
      currentNodeName: [],
      currentNodeDetails: [],
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
      project_name: [],
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
        // console.log("-------");
        // console.log(this.user_projects);
        // console.log("-------");
      });

    // const url = "api/v1/projects/" + this.$route.params.id;
    // this.$axios
    //   .get(url, {
    //     headers: {
    //       "Content-Type": "application/json",
    //     },
    //   })
    //   .then((response) => {
    //     this.projects = response.data;
    //   });
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
    selectProject: function () {
      this.tree.name = this.project_name;
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
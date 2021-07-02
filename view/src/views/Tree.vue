<template>
  <div id="app" class="container-fluid">
    <div class="col-md-3">
      <div class="panel panel-default">
        <div class="panel-heading">Props</div>

        <div class="panel-body">
          <div class="form-horizontal">
            <div class="form-group">
              <label for="type" class="control-label col-sm-3">type</label>
              <div class="col-sm-9">
                <select id="type" class="form-control" v-model="type">
                  <option>tree</option>
                  <option>cluster</option>
                </select>
              </div>
            </div>

            <div class="form-group">
              <label for="layout-type" class="control-label col-sm-3"
                >layoutType</label
              >
              <div class="col-sm-9">
                <select
                  id="layout-type"
                  class="form-control"
                  v-model="layoutType"
                >
                  <option>horizontal</option>
                  <option>vertical</option>
                  <option>circular</option>
                </select>
              </div>
            </div>

            <div class="form-group">
              <label for="layout-type" class="control-label col-sm-3"
                >nodeTextDisplay</label
              >
              <div class="col-sm-9">
                <select
                  id="layout-type"
                  class="form-control"
                  v-model="nodeTextDisplay"
                >
                  <option>all</option>
                  <option>leaves</option>
                  <option>extremities</option>
                </select>
              </div>
            </div>

            <div class="form-group">
              <label for="layout-type" class="control-label col-sm-3"
                >linkLayout</label
              >
              <div class="col-sm-9">
                <select
                  id="layout-type"
                  class="form-control"
                  v-model="linkLayout"
                >
                  <option>bezier</option>
                  <option>orthogonal</option>
                </select>
              </div>
            </div>

            <div class="form-group">
              <label for="margin-x" class="control-label col-sm-3"
                >marginx</label
              >
              <div class="col-sm-7">
                <input
                  id="margin-x"
                  class="form-control"
                  type="range"
                  min="0"
                  max="200"
                  v-model.number="Marginx"
                />
              </div>
              <div class="col-sm-2">
                <p>{{ Marginx }}px</p>
              </div>
            </div>

            <div class="form-group">
              <label for="margin-y" class="control-label col-sm-3"
                >marginy</label
              >
              <div class="col-sm-7">
                <input
                  id="margin-y"
                  class="form-control"
                  type="range"
                  min="0"
                  max="200"
                  v-model.number="Marginy"
                />
              </div>
              <div class="col-sm-2">
                <p>{{ Marginy }}px</p>
              </div>
            </div>

            <div class="form-group">
              <label for="margin-y" class="control-label col-sm-3"
                >radius</label
              >
              <div class="col-sm-7">
                <input
                  id="radius"
                  class="form-control"
                  type="range"
                  min="1"
                  max="10"
                  v-model.number="radius"
                />
              </div>
              <div class="col-sm-2">
                <p>{{ radius }}px</p>
              </div>
            </div>

            <div class="form-group">
              <label for="velocity" class="control-label col-sm-3"
                >Duration</label
              >
              <div class="col-sm-7">
                <input
                  id="velocity"
                  class="form-control"
                  type="range"
                  min="0"
                  max="3000"
                  v-model.number="duration"
                />
              </div>
              <div class="col-sm-2">
                <p>{{ duration }}ms</p>
              </div>
            </div>

            <div class="form-group">
              <label for="leaf-text-margin" class="control-label col-sm-3"
                >leafTextMargin</label
              >
              <div class="col-sm-7">
                <input
                  id="leaf-text-margin"
                  class="form-control"
                  type="range"
                  min="0"
                  max="100"
                  v-model.number="leafTextMargin"
                />
              </div>
              <div class="col-sm-2">
                <p>{{ leafTextMargin }}px</p>
              </div>
            </div>

            <div class="form-group">
              <label for="node-text-margin" class="control-label col-sm-3"
                >nodeTextMargin</label
              >
              <div class="col-sm-7">
                <input
                  id="node-text-margin"
                  class="form-control"
                  type="range"
                  min="0"
                  max="100"
                  v-model.number="nodeTextMargin"
                />
              </div>
              <div class="col-sm-2">
                <p>{{ nodeTextMargin }}px</p>
              </div>
            </div>

            <div class="form-group">
              <label for="minZoom" class="control-label col-sm-3"
                >minZoom</label
              >
              <div class="col-sm-7">
                <input
                  id="minZoom"
                  class="form-control"
                  type="range"
                  min="0.01"
                  max="1"
                  step="0.05"
                  v-model.number="minZoom"
                />
              </div>
              <div class="col-sm-2">
                <p>{{ minZoom }}</p>
              </div>
            </div>

            <div class="form-group">
              <label for="maxZoom" class="control-label col-sm-3"
                >maxZoom</label
              >
              <div class="col-sm-7">
                <input
                  id="maxZoom"
                  class="form-control"
                  type="range"
                  min="1"
                  max="100"
                  v-model.number="maxZoom"
                />
              </div>
              <div class="col-sm-2">
                <p>{{ maxZoom }}</p>
              </div>
            </div>

            <div class="form-group">
              <label for="zoomable" class="">Zoomable</label>
              <input
                id="zoomable"
                class="form-check-input"
                type="checkbox"
                v-model="zoomable"
              />
            </div>

            <div class="form-group feedback">
              <i
                v-show="isLoading"
                class="fa fa-spinner fa-spin fa-2x fa-fw"
              ></i>
              <span v-if="currentData"
                >Current Node: {{ currentData.data.text }}</span
              >
              <span v-else>No Node selected.</span>
            </div>

            <button
              type="button"
              :disabled="!currentData"
              class="btn btn-primary"
              @click="expandAll"
              data-toggle="tooltip"
              data-placement="top"
              title="Expand All from current"
            >
              <i class="fa fa-expand" aria-hidden="true"></i>
            </button>

            <button
              type="button"
              :disabled="!currentData"
              class="btn btn-secondary"
              @click="collapseAll"
              data-toggle="tooltip"
              data-placement="top"
              title="Collapse All from current"
            >
              <i class="fa fa-compress" aria-hidden="true"></i>
            </button>

            <button
              type="button"
              :disabled="!currentData"
              class="btn btn-success"
              @click="showOnly"
              data-toggle="tooltip"
              data-placement="top"
              title="Show Only from current"
            >
              <i class="fa fa-search-plus" aria-hidden="true"></i>
            </button>

            <button
              type="button"
              :disabled="!currentData"
              class="btn btn-warning"
              @click="show"
              data-toggle="tooltip"
              data-placement="top"
              title="Show current"
            >
              <i class="fa fa-binoculars" aria-hidden="true"></i>
            </button>

            <button
              v-if="zoomable"
              type="button"
              class="btn btn-warning"
              @click="resetZoom"
              data-toggle="tooltip"
              data-placement="top"
              title="Reset Zoom"
            >
              <i class="fa fa-arrows-alt" aria-hidden="true"></i>
            </button>

            <button
              type="button"
              class="btn btn-danger"
              @click="gremlins"
              data-toggle="tooltip"
              data-placement="top"
              :title="
                isUnderGremlinsAttack ? 'stop attack' : 'unleash gremlins'
              "
            >
              <i
                class="fa"
                :disabled="isUnderGremlinsAttack"
                :class="
                  isUnderGremlinsAttack
                    ? 'fa-exclamation-triangle'
                    : 'fa-optin-monster'
                "
                aria-hidden="true"
              ></i>
            </button>
          </div>
        </div>
      </div>

      <div class="panel panel-default">
        <div class="panel-heading">Events</div>

        <div class="panel-body log">
          <div v-for="(event, index) in events" :key="index">
            <p>
              <b>Name:</b> {{ event.eventName }} <b>Data:</b
              >{{ event.data.text }}
            </p>
          </div>
        </div>
      </div>
    </div>

    <div class="col-md-9 panel panel-default">
      <tree
        v-model="currentData"
        :nodeTextDisplay="nodeTextDisplay"
        :identifier="getId"
        :nodeTextMargin="nodeTextMargin"
        :zoomable="zoomable"
        :data="Graph.tree"
        :leafTextMargin="leafTextMargin"
        :node-text="nodeText"
        :margin-x="Marginx"
        :margin-y="Marginy"
        :radius="radius"
        :type="type"
        :layout-type="layoutType"
        :linkLayout="linkLayout"
        :duration="duration"
        :minZoom="minZoom"
        :maxZoom="maxZoom"
        contextMenuPlacement="bottom-start"
        class="tree"
        @clickedText="onClick"
        @expand="onExpand"
        @retract="onRetract"
        @clickedNode="onClickNode"
      >
        <template #behavior="{ on, actions }">
          <popUpOnHoverText v-bind="{ on, actions }" />
        </template>
      </tree>

      <div class="text-center">
        <v-dialog v-model="addIssue" width="500">
          <template v-slot:activator="{ on, attrs }">
            <v-btn color="red lighten-2" dark v-bind="attrs" v-on="on">
              Click Me
            </v-btn>
          </template>

          <v-card>
            <v-card-title class="text-h3 grey lighten-2">
              add issue
            </v-card-title>
            <v-card-title
              class="text-h5 justify-center text-decoration-underline"
            >
              issue name
            </v-card-title>
            <v-card-title
              class="text-h5 justify-center text-decoration-underline"
            >
              issue details
            </v-card-title>
            <v-card-text> write issue details </v-card-text>
            <v-card-title
              class="text-h5 justify-center text-decoration-underline"
            >
              skills
            </v-card-title>
            <v-row>
              <v-col cols="1"></v-col>
              <v-col cols="10" align="center">
                <v-card-text>
                  <v-form>
                    <v-select
                      multiple
                      v-model="selected"
                      :options="options"
                      :reduce="(options) => options.id"
                      key="id"
                      label="skill"
                      @input="onInput"
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
              </v-col>
              <v-col cols="1"></v-col>
            </v-row>
            <v-card-title
              class="text-h5 justify-center text-decoration-underline"
            >
              member
            </v-card-title>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="primary" text @click="addIssue = false">
                I accept
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { tree, popUpOnHoverText } from "vued3tree";
import data from "../../data/data";
import { getGremlin } from "./gremlinConfiguration";
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
  Marginx: 30,
  Marginy: 30,
  radius: 6,
  leafTextMargin: 6,
  nodeTextMargin: 6,
  nodeText: "name",
  currentData: null,
  zoomable: true,
  isLoading: false,
  isUnderGremlinsAttack: false,
  nodeTextDisplay: "all",
  linkLayout: "bezier",
  minZoom: 0.8,
  maxZoom: 9,
  events: [],
});
export default {
  name: "app",
  data() {
    return {
      users: [],
      Graph: {
        tree: {
          name: "project",
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
      },
      addIssue: false,
      events: [],
      skills: [
        { id: 1, name: "vue" },
        { id: 2, name: "rails" },
        { id: 3, name: "python" },
        { id: 4, name: "fortran" },
        { id: 5, name: "C" },
        { id: 6, name: "C#" },
        { id: 7, name: "C++" },
      ],
    };
  },

  onTextClick() {
    this.$element("apiMenu").show({ x: 280, y: 120 });
  },
  components: {
    tree,
    popUpOnHoverText,
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
      this.addIssue = true;
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
    },
    addFor(data) {
      const newData = {
        id: currentId++,
        children: [],
        text: Math.random().toString(36).substring(7),
      };
      data.children.push(newData);
    },
    remove(data, node) {
      const parent = node.parent.data;
      removeElement(parent.children, data);
    },
    resetZoom() {
      if (!this.$refs["tree"]) {
        return;
      }
      this.isLoading = true;
      this.$refs["tree"].resetZoom().then(() => {
        this.isLoading = false;
      });
    },
    gremlins() {
      if (this.isUnderGremlinsAttack) {
        this.horde.stop();
        return;
      }
      const updateType = (type) => {
        switch (type) {
          case "vertical":
            return "circular";
          case "circular":
            return "horizontal";
          case "horizontal":
            return "vertical";
        }
      };
      const updateNodeTextDisplay = (display) => {
        switch (display) {
          case "all":
            return "leaves";
          case "leaves":
            return "extremities";
          case "extremities":
            return "all";
        }
      };
      this.duration = 20;
      const changeLayout = () => {
        this.type = this.type === "tree" ? "cluster" : "tree";
      };
      const changeNode = () => {
        this.linkLayout =
          this.linkLayout === "bezier" ? "orthogonal" : "bezier";
      };
      const changeType = () => {
        this.layoutType = updateType(this.layoutType);
      };
      const changeNodeTextDisplay = () => {
        this.nodeTextDisplay = updateNodeTextDisplay(this.nodeTextDisplay);
      };
      const resetZoom = this.resetZoom.bind(this);
      const [treeDiv] = this.$el.getElementsByClassName("tree");
      const [gremlinsButton] = this.$el.getElementsByClassName("btn-danger");
      var horde = getGremlin(gremlinsButton, treeDiv, {
        changeType,
        changeLayout,
        changeNode,
        changeNodeTextDisplay,
        resetZoom,
      });
      horde.after(() => {
        this.isUnderGremlinsAttack = false;
      });
      horde.unleash();
      this.horde = horde;
      this.isUnderGremlinsAttack = true;
    },
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
  margin-top: 20px;
}
.tree {
  height: 800px;
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
.container {
  flex-direction: column;
  align-items: flex-start;
  justify-content: center;
}
.title-text {
  margin: 20px;
}
</style>
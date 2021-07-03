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
        ref="tree"
        v-model="currentData"
        :nodeTextDisplay="nodeTextDisplay"
        :identifier="getId"
        :nodeTextMargin="nodeTextMargin"
        :zoomable="zoomable"
        :data="tree"
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
      </tree>

      <div class="text-center">
        <v-dialog persistent v-model="addIssue" width="500">
          <v-card>
            <v-card-title class="text-h4 light-green justify-center lighten-2">
              <v-row>
                <v-col cols="3" />
                <v-col cols="6"> add issues </v-col>
                <v-col cols="3" class="text-end">
                  <v-btn text @click="addIssue = false">
                    <v-icon>mdi-close</v-icon>
                  </v-btn>
                </v-col>
              </v-row>
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
            <v-textarea
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
                  :items="members"
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
              <v-btn color="error" text @click="addIssue = false">
                cancel
              </v-btn>
              <v-spacer></v-spacer>
              <v-btn color="primary" text @click="addIssue = false">
                add
              </v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </div>
      <div class="text-center">
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
              issue name
            </v-card-title>
            <v-card-title
              class="text-h5 justify-center text-decoration-underline"
            >
              issue detail
            </v-card-title>
            <v-textarea
              solo
              name="input-7-4"
              label="please write detail here"
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
  </div>
</template>

<script>
import { tree } from "vued3tree";
import data from "../../data/data";
import { getGremlin } from "./gremlinConfiguration";
Object.assign(data, {
  type: "tree",
  layoutType: "horizontal",
  duration: 750,
  Marginx: 30,
  Marginy: 30,
  radius: 10,
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
  name: "App",
  data() {
    return {
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
      addIssue: false,
      issueDetails: false,
      isChildNode: false,
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
      members: [
        { id: 1, name: "dodo" },
        { id: 2, name: "fujisaki" },
        { id: 3, name: "yasuda" },
        { id: 4, name: "kugue" },
        { id: 5, name: "mashimo" },
        { id: 6, name: "mizukami" },
        { id: 7, name: "oba" },
      ],
    };
  },
  // onTextClick() {
  //   this.$element("apiMenu").show({ x: 280, y: 120 });
  // },
  components: {
    tree,
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
      if (this.isChildNode) {
        this.addIssue = true;
      } else {
        this.issueDetails = true;
      }
      // this.events = [];
    },
    onClickNode(evt) {
      this.onEvent("clickedNode", evt);
      console.log("aaa");
    },
    onExpand(evt) {
      this.onEvent("onExpand", evt);
      console.log("---expand---");
    },
    onRetract(evt) {
      this.onEvent("onRetract", evt);
      console.log("---retract---");
    },
    onEvent(eventName, data) {
      this.events.push({ eventName, data: data.data });
      if (this.events[0].data.children === undefined) {
        this.isChildNode = false;
      } else {
        this.isChildNode = true;
      }
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
</style>
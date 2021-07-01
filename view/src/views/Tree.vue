<template>
  <div id="app">
    <!-- <img width="25%" src="./assets/logo.png" /> -->
    <div>
      <tree
        :data="tree"
        node-text="name"
        type="cluster"
        layoutType="vertical"
        strokeWidth="5"
        linkLayout="orthogonal"
        radius="10"
        Duration="0"
        style="max-width: 90%; max-height: 500px"
        @clickedText="onClick"
        @expand="onExpand"
        @retract="onRetract"
        @clickedNode="onClickNode"
      ></tree>
    </div>
  </div>
</template>

<script>
import { tree } from "vued3tree";

export default {
  name: "App",
  components: {
    tree,
  },
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
              {
                name: "issue3",
                children: [{ name: "issue4" }, { name: "issue5" }],
              },
              { name: "issue6" },
            ],
          },
        ],
      },
      event: [],
      events: [],
      nodeName: [],
      children: [],
      childrenNodeName: [],
    };
  },
  methods: {
    getId(node) {
      return node.id;
    },
    onClick(evt) {
      this.onEvent("clickedText", evt);
      console.log("click text");
      console.log(this.events);
      this.events = [];
    },
    onClickNode(evt) {
      this.onEvent("clickedNode", evt);
      console.log("click node");

      if (this.events[0].data.children) {
        console.log("children name");
        for (let step = 0; step < this.events[0].data.children.length; step++) {
          console.log(this.events[0].data.children[step].name);
          this.childrenNodeName.push(this.events[0].data.children[step].name);
        }
      }

      // console.log(this.events[0].data);
      this.children.push(this.events[0].data.children);
      this.nodeName.push(this.events[0].data.name);

      console.log("node name");
      console.log(this.nodeName);
      console.log("children");
      console.log(this.children);
      console.log(this.childrenNodeName);
      this.events = [];
      this.nodeName = [];
      this.children = [];
      this.childrenNodeName = [];
    },
    onExpand(evt) {
      this.onEvent("onExpand", evt);
      console.log("enpand");
      console.log(this.events);
      this.events = [];
    },
    onRetract(evt) {
      this.onEvent("onRetract", evt);
      console.log("retract");
      console.log(this.events);
      this.events = [];
    },
    onEvent(eventName, data) {
      this.events.push({ eventName, data: data.data });
      console.log(this.events);
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
  margin-top: 60px;
}
.treeclass .nodetree text {
  font: 15px sans-serif !important;
  border: 2px solid red !important;
  color: red;
  background: red;
  cursor: pointer;
}
</style>

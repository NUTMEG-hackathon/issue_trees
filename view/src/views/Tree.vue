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
        radius="6"
        nodeTextMargin=""
        Duration="0"
        style="max-width: 90%; max-height: 500px"
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
    };
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

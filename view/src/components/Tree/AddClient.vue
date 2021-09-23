<template>
  <v-dialog persistent v-model="addClientDialog" width="700">
    <v-card>
      <v-card-title class="text-h4 lighten-2">
        <v-row>
          <v-col cols="3" />
          <v-col cols="6" class="my-3 light-green--text"> Add Client </v-col>
          <v-col cols="3" class="text-end my-3">
            <v-tooltip top>
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  class="mx-2"
                  fab
                  text
                  v-bind="attrs"
                  v-on="on"
                  @click="closeDialog()"
                >
                  <v-icon>mdi-close</v-icon>
                </v-btn>
              </template>
              <span>ダイアログを閉じる</span>
            </v-tooltip>
          </v-col>
        </v-row>
      </v-card-title>
      <v-row no-gutters>
        <v-col cols="1" />
        <v-col cols="10">
          <v-card-title class="text-left">
            <v-icon class="mr-3">mdi-tag-text-outline</v-icon> Client Name
          </v-card-title>
          <v-text-field v-model="clientName" label="client name" solo>
          </v-text-field>
          <v-card-actions>
            <v-tooltip top>
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  class="ma-2"
                  text
                  outlined
                  color="red"
                  v-bind="attrs"
                  v-on="on"
                  @click="closeDialog()"
                >
                  cancel
                </v-btn>
              </template>
              <span>追加せずにダイアログを閉じる</span>
            </v-tooltip>
            <v-spacer></v-spacer>
            <v-tooltip top>
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  class="ma-2"
                  text
                  outlined
                  color="blue"
                  v-bind="attrs"
                  v-on="on"
                  @click="addClient()"
                >
                  add
                </v-btn>
              </template>
              <span>このClientを追加する</span>
            </v-tooltip>
          </v-card-actions>
        </v-col>
      </v-row>
    </v-card>
  </v-dialog>
</template>

<script>
import axios from "axios";
export default {
  props: {
    addClientDialog: Boolean,
    projectId: Number,
  },
  name: "App",
  data() {
    return {
      // client infomation
      clientName: [],
    };
  },
  methods: {
    getId(node) {
      return node.id;
    },
    addClient: async function () {
      const url = process.env.VUE_APP_URL;
      var params = {
        name: this.clientName,
        project_id: this.projectId,
      };
      axios.defaults.headers.common["Content-Type"] = "application/json";
      await axios
        .post(
          url + "/clients/",
          { client: params },
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
      await this.$emit("addClient");
      this.clientName = [];
    },
    closeDialog: function () {
      this.addClientDialog = false;
      this.$emit("closeDialog");
    },
  },
};
</script>

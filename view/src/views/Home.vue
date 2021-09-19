<template>
  <v-container>
    <v-card>
      <h1>{{users}}</h1>
    </v-card>
  </v-container>
</template>

<script>
import axios from 'axios'
export default {
  components:{
  },
  data() {
    return {
      users: [],
    };
  },
  mounted() {
    const url = process.env.VUE_APP_URL + "/api/v1/users/index";
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
        console.log(this.users)
      });
  },
};
</script>
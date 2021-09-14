<template>
  <v-container>
    <v-dialog v-model="edit2" max-width="600" persistent>
      <v-card>
        <v-card-title class="text-h4 justify-center light-green lighten-2">
          MySkillの編集
        </v-card-title>
        
        <v-container class="justify-content-center">

          <v-row>
            <v-col cols="2"></v-col>
            <v-col cols="8" align="center">
              <v-select  
                key="id"
                label="name"
                placeholder="Filter Skills ..."
                :items="this.s_list"
                :menu-props="{
                  top: true,
                  offsetY: true,
                }"
                item-text="name"
                item-value="id"
                v-model="skills"
                outlined
              />
            </v-col>
            <v-col cols="2"></v-col>
          </v-row>

          <v-row>
            <v-col cols="2"></v-col>
            <v-col cols="8">
              <v-text-field
                label="status"
                v-model="status"
                text
                outlined
                clearable
              />
            </v-col>
            <v-col cols="2"></v-col>
          </v-row>

          <v-row>
            <v-col cols="2"></v-col>
            <v-col cols="8">
              <v-text-field
                label="level"
                v-model="level"
                text
                outlined
                clearable
              />
            </v-col>
            <v-col cols="2"></v-col>
          </v-row>

        </v-container>
        <v-card-actions>
          <v-layout align-center justify-center>
            <v-spacer />
            <v-btn class="error" flat="flat" @click="edit2 = false">取り消し</v-btn>
            <v-spacer />
            <v-btn class="primary" flat="flat" @click="submit">登録</v-btn>
            <v-spacer />
          </v-layout>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
import axios from 'axios'
 export default {
  props:{
    id:Number,
    name: String,
    status: String,
    level: Number,
  },
  data() {
    return {
      edit2: false,
      s_list: [],
      skills: [],
    };
  },
    methods: {
      submit: async function() {
      const url = process.env.VUE_APP_URL + '/api/v1/userskill/edit_user_skill';

      let params ={
        'id' : this.id,
        'name' : this.name,
        'status' : this.status,
        'level' : this.level
      }
      console.log(params)
      axios.put(url, params, {
          headers: {
            'Content-Type': 'application/json',
            'access-token': localStorage.getItem('access-token'),
            'client': localStorage.getItem('client'),
            'uid': localStorage.getItem('uid')
          }
        }
      ).then(
        (response) => {
          console.log(response)
          this.edit2 = false
        },
        (error) => {
          console.log('登録できませんでした')
          console.log(error)
          this.edit2 = false
          return error;
        }
      )
    },
  },
  mounted() {
    const s_url = process.env.VUE_APP_URL + "/skills";
    axios
      .get(s_url, {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.s_list = response.data;
      });
  },
};
</script>
<template>
  <v-container>
    <v-dialog v-model="edit4" max-width="600" persistent>
      <v-card>
        <v-card-title class="text-h4 justify-center light-green lighten-2">
          MyIssueの編集
        </v-card-title>
        <v-container class="justify-content-center">

          <v-row>
            <v-col cols="2"></v-col>
            <v-col cols="8">
              <v-text-field
                label="name"
                v-model="name"
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
                label="description"
                v-model="description"
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
            <v-btn class="error" flat="flat" @click="edit4 = false">取り消し</v-btn>
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
    id: Number,
    name: String,
    description: String,
    level: Number,
  },
  data() {
    return {
      edit4: false,
      issues: [],
    };
  },
    methods: {
      submit: function() {
      const url = process.env.VUE_APP_URL + '/api/v1/userissue/edituserissue';

      let params ={
          'id': this.id,
          'name' : this.name,
          'description' : this.description,
          'level' : this.level
      }

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
          this.edit4 = false
        },
        (error) => {
          console.log('登録できませんでした')
          console.log(params.name)
          this.edit4 = false
          return error;
        }
      )
    },
  },
};
</script>
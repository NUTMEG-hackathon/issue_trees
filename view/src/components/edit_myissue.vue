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
                label="discription"
                v-model="discription"
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
    name: String,
    discription: String,
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
      const url = process.env.VUE_APP_URL + '/api/v1/users/show' + '/' + this.userId + '?' + 'name=' + this.name + '&email=' + this.email;
      axios.put(url, {
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
          this.edit1 = false
        },
        (error) => {
          console.log('登録できませんでした')
          this.edit1 = false
          return error;
        }
      )
    },
  },
};
</script>
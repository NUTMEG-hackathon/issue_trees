<template>
  <v-container>
    <v-dialog v-model="edit1" max-width="600" persistent>
      <v-card>
        <v-card-title class="text-h4 justify-center light-green lighten-2">
          個人情報の編集
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
                label="email"
                v-model="email"
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
            <v-btn class="error" flat="flat" @click="edit1 = false">取り消し</v-btn>
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
    userId: Number,
    name: String,
    email: String,
  },
  data() {
    return {
      edit1: false,
      user_name:[],
      
    };
  },
    methods: {

      edit:async function(){
        
        const url = process.env.VUE_APP_URL + '/api/v1/current_user/edit_user_info' ;

        var params =  {
            'name' : this.name,
            'email' : this.email
        }

        await axios.put(url, params, {
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
            console.log('put')
            this.edit1 = false
            this.reload()
          },
          (error) => {
            console.log('登録できませんでした')
            this.edit1 = false
            return error;
          }
        )
      },
      reload:async function(){
        const get_url = process.env.VUE_APP_URL + '/api/v1/current_user/get_user_detail'
        await axios.get(get_url, {
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
            console.log('get')
            // this.name = response.data.name;
            this.reload()
          },
          (error) => {
            console.log('編集できませんでした')
            this.edit1 = false
            return error;
          }
        )
      },
      submit:async function() {
        // if ( !this.$refs.form.validate() ) return;
        // await this.edit()
        // await this.reload()
        const url = process.env.VUE_APP_URL + '/api/v1/current_user/edit_user_info' ;

        var params =  {
            'name' : this.name,
            'email' : this.email
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
            localStorage.setItem('uid',  this.email)
            console.log(response)
            console.log('put')
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
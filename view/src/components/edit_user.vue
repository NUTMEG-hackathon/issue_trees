<template>
  <v-container>
    <v-dialog v-model="edit1" max-width="700">
      <v-card>
        <v-card-title class="text-h4 lighten-2">
          <v-row no-gutters>
            <v-col cols="3" />
            <v-col cols="6" class="my-3 light-green--text">
              Edit User Info
            </v-col>
            <v-col cols="3" class="text-end my-3"></v-col>
          </v-row>
        </v-card-title>

          <v-row no-gutters>
            <v-col cols="1" />
            <v-col cols="10">
              <v-text-field
                label="name"
                v-model="name"
                text
                outlined
                clearable
              />
            </v-col>
            <v-col cols="1" />
          </v-row>

          <v-row no-gutters>
            <v-col cols="1"></v-col>
            <v-col cols="10">
              <v-text-field
                label="email"
                v-model="email"
                text
                outlined
                clearable
              />
            </v-col>
            <v-col cols="1"></v-col>
          </v-row>

        <v-card-actions>
            <v-spacer />
            <v-tooltip left>
              <template v-slot:activator="{ on, attrs }">
                <v-btn v-bind="attrs" v-on="on" color="red" class="ma-2" outlined @click="edit1 = false">cancel</v-btn>
              </template>
              <div>編集を取り消しする</div>
            </v-tooltip>
            <v-spacer />
            <v-tooltip right>
              <template v-slot:activator="{ on, attrs }">
                <v-btn v-bind="attrs" v-on="on" color="blue" class="ma-2" outlined @click="submit">edit</v-btn>
              </template>
              <div>編集を決定する</div>
            </v-tooltip>
            <v-spacer />
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

      // edit:async function(){
        
      //   const url = process.env.VUE_APP_URL + '/api/v1/current_user/edit_user_info' ;

      //   var params =  {
      //       'name' : this.name,
      //       'email' : this.email
      //   }

      //   await axios.put(url, params, {
      //       headers: {
      //         'Content-Type': 'application/json',
      //         'access-token': localStorage.getItem('access-token'),
      //         'client': localStorage.getItem('client'),
      //         'uid': localStorage.getItem('uid')
      //       }
      //     }
      //   ).then(
      //     (response) => {
      //       console.log(response)
      //       console.log('put')
      //       this.edit1 = false
      //     },
      //     (error) => {
      //       console.log('登録できませんでした')
      //       this.edit1 = false
      //       return error;
      //     }
      //   )
      // },
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
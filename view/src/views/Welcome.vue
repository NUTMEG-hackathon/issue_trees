<template>
  <v-container>

    <v-row>
      <v-col cols="3"></v-col>
      <v-col cols="6">
        <v-card
          @click="SignUp=true"
        >
        <v-img
         src="../assets/Tree1.png"
        >
          <p class="font">SignUp</p>
        </v-img>
        </v-card>
      </v-col>
      <v-col cols="3"></v-col>
    </v-row>

    <br><br>

    <v-row>
      <v-col cols="3"></v-col>
      <v-col cols="6">
        <v-card
          @click="SignIn=true"
        >
          <v-img
          src="../assets/Tree2.png"
          >
            <p class="font">SignIn</p>
          </v-img>
        </v-card>
      </v-col>
      <v-col cols="3"></v-col>
    </v-row>

  <v-dialog
    v-model="SignUp"
    max-width="600">
    <v-card>
      <v-layout align-center justify-center>
        <v-card-title>SignUp</v-card-title>
      </v-layout>
      <v-row>
        <v-col cols="1"></v-col>
        <v-col cols="10">
          <v-text-field
            label="name"
            v-model="name"
            text
            outlined
            clearable
          ></v-text-field>
          <v-text-field
            label="email"
            v-model="email"
            text
            outlined
            clearable
          ></v-text-field>
        </v-col>
        <v-col cols="1"></v-col>
      </v-row>
      <v-card-aptions>
        <v-layout align-center justify-center>
          <v-spacer />
          <v-btn class="dialog_font" color="#91BA58" flat="flat" @click="dialog = true">追加</v-btn>
          <v-spacer />
          <v-btn class="dialog_font" color="#74905D" flat="flat" @click="SignUp = false">削除</v-btn>
          <v-spacer />
        </v-layout>
      </v-card-aptions>
    </v-card>
  </v-dialog>


    <v-dialog
      v-model="SignIn"
      max-width="600">
      <v-card>
        <v-layout align-center justify-center>
          <v-card-title>SignIn</v-card-title>
        </v-layout>
        <v-row>
          <v-col cols="1"></v-col>
          <v-col cols="10">
            <v-text-field
              label="name"
              v-model="name"
              text
              outlined
              clearable
            ></v-text-field>
            <v-text-field
              label="email"
              v-model="email"
              text
              outlined
              clearable
            ></v-text-field>
          </v-col>
          <v-col cols="1"></v-col>
        </v-row>
        <v-card-aptions>
          <v-layout align-center justify-center>
            <v-spacer />
            <v-btn class="dialog_font" color="#91BA58" flat @click="dialog = true">追加</v-btn>
            <v-spacer />
            <v-btn class="dialog_font" color="#74905D" flat @click="SignIn = false">削除</v-btn>
            <v-spacer />
          </v-layout>
        </v-card-aptions>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
export default {
  data () {
    return {
      SignUp: false,
      SignIn: false
    }
  }
}
</script>

<style>
  .font{
    color: white;
    font-size: 500%;
  }
  .dialog_font{
    color: white!important;
  }
</style>

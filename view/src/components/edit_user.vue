<template>
  <v-container>
    <v-card>
      <v-dialog v-model="edit" max-width="600" persistent>
        <v-card>
          <v-card-title>個人情報の編集</v-card-title>
          <v-container class="justify-content-center">
            <v-text-field
              label="name"
              v-model="name"
              text
              outlined
              clearable
            />
            <v-text-field
              label="email"
              v-model="email"
              text
              outlined
              clearable
            />
          </v-container>
          <v-card-actions>
            <v-layout align-center justify-center>
              <v-spacer />
              <v-btn color="#91BA58" flat="flat" @click="dialog = true"
                >登録</v-btn
              >
              <v-spacer />
              <v-btn color="#74905D" flat="flat" @click="edit = false"
                >取り消し</v-btn
              >
              <v-spacer />
            </v-layout>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-card>
  </v-container>
</template>
<script>
 export default {
   props:{
     name: String,
     email: String,
   },
  data() {
    return {
      edit: false,
    };
  },
};
</script>
<template>
<div>
    <v-navigation-drawer fixed permanent clipped app color="#B4CF9B">
      <br>
      <v-row>
        <v-col cols="1"></v-col>
        <v-col cols="10">
          <v-card
            @click="dialog=true"
          >
            <v-card-title>プロジェクト追加</v-card-title>
          </v-card>
        </v-col>
        <v-col cols="1"></v-col>
      </v-row>
      <br>
      <v-row>
        <v-col cols="1"></v-col>
        <v-col cols="10">
          <v-card>
            <v-card-title>詳細</v-card-title>
          </v-card>
        </v-col>
        <v-col cols="1"></v-col>
      </v-row>
      <br>
      <v-row>
        <v-col cols="1"></v-col>
        <v-col cols="10">
          <v-card>
            <v-card-title>Member</v-card-title>
          </v-card>
        </v-col>
        <v-col cols="1"></v-col>
      </v-row>
    </v-navigation-drawer>

  <v-dialog
    v-model="dialog"
    max-width="600">
    <v-card>
      <v-card-title>project追加</v-card-title>
      <v-card-text>追加の手続きを行います</v-card-text>
        <v-container class="justify-content-center">
          <v-row>
            <v-col cols="1"></v-col>
            <v-col cols="10" align="center">
              <v-card-text>
                <v-form ref="form">
                  <v-text-field
                    label="project_name"
                    v-model="name"
                    text
                    outlined
                    clearable
                  ></v-text-field>
                  <v-text-field
                  label="Member"
                  ref="cooking"
                  v-model="cooking"
                  :items="this.cooking_list"
                  item-text="name"
                  item-value="id"
                  outlined
                  ></v-text-field>
                </v-form>
              </v-card-text>
            </v-col>
            <v-col cols="1"></v-col>
          </v-row>
        </v-container>
      <v-card-actions>
        <v-layout align-center justify-center>
          <v-spacer />
          <v-btn color="#91BA58" flat="flat" @click="dialog = true">決定</v-btn>
          <v-spacer />
          <v-btn color="#74905D" flat="flat" @click="project = false">取り消し</v-btn>
          <v-spacer />
        </v-layout>
      </v-card-actions>
    </v-card>
  </v-dialog>

</div>
</template>

<script>
export default {
  data () {
    return {
      dialog: false
    }
  }
}
</script>

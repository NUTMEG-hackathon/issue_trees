<template>
  <v-container>
    <v-row justify="space-around">
      <v-card width="400">
        <v-img
          height="300px"
          src="../assets/Tree3.png"
        >
          <v-app-bar flat color="rgba(0, 0, 0, 0)">
            <v-toolbar-title class="text-h5 white--text font-weight-bold">
              Efficientree
            </v-toolbar-title>
            <v-spacer></v-spacer>
          </v-app-bar>
        </v-img>
        <v-card-text>

          <v-timeline align-top dense>
            <v-timeline-item
              v-for="message in messages"
              :key="message.time"
              :color="message.color"
              small
            >
              <div>
                <div class="font-weight-normal">
                  <strong>{{ message.from }}</strong> @{{ message.time }}
                </div>
                <div>{{ message.message }}</div>
              </div>
            </v-timeline-item>
          </v-timeline>
        </v-card-text>
      </v-card>
    </v-row>
  </v-container>
</template>

<script>
  export default {
    data: () => ({
      messages: [
        {
          message: `When you will start samething,`,
          color: 'deep-purple lighten-1',
        },
        {
          message: 'All you need is to make a plan.',
          color: 'green',
        },
        {
          message: 'Get the best with this app!',
          color: 'deep-purple lighten-1',
        },
      ],
    }),
  }
</script>

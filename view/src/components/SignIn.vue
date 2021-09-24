 <template>
  <v-container>
    <v-dialog v-model="openi" max-width="700">
      <v-card>
        <v-card-title
          class="text-h4 lighten-2 justify-center my-3 light-green--text"
        >
          Sign in
        </v-card-title>
        <v-row no-gutters>
          <v-col cols="1"></v-col>
          <v-col cols="10">
            <v-card-text>
              <v-form ref="form">
                <v-text-field
                  label="メールアドレス"
                  ref="email"
                  v-model="email"
                  :rules="[rules.requied, rules.email]"
                  required
                ></v-text-field>
                <v-text-field
                  label="パスワード"
                  v-model="password"
                  ref="password"
                  :append-icon="show_pass ? 'mdi-eye-off' : 'mdi-eye'"
                  :rules="[rules.required, rules.min]"
                  :type="show_pass ? 'password' : 'text'"
                  hint="8文字以上"
                  counter
                  @click:append="show_pass = !show_pass"
                  required
                ></v-text-field>
              </v-form>
            </v-card-text>
            <v-card-actions>
              <v-spacer />
              <v-tooltip left>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    v-bind="attrs"
                    v-on="on"
                    class="ma-2"
                    color="red"
                    outlined
                    @click="openi = false"
                    >close</v-btn
                  >
                </template>
                <div>閉じる</div>
              </v-tooltip>
              <v-spacer />
              <v-tooltip right>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    v-bind="attrs"
                    v-on="on"
                    class="ma-2"
                    color="blue"
                    outlined
                    @click="submit"
                    >Sign in</v-btn
                  >
                </template>
                <div>サインインする</div>
              </v-tooltip>
              <v-spacer />
            </v-card-actions>
          </v-col>
          <v-col cols="1"></v-col>
        </v-row>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
import axios from "axios";
export default {
  name: "SignIn",
  data() {
    return {
      openi: false,
      show_pass: true,
      formHasErrors: false,
      rules: {
        requied: (value) => !!value || "入力してください",
        min: (v) => v.length >= 8 || "８文字未満です",
        email: (v) => {
          const pattern =
            /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
          return pattern.test(v) || "適切なメールアドレスではありません。";
        },
      },
      message: "",
      warnStyle: {
        color: "#F44336",
      },
    };
  },
  computed: {
    form() {
      return {
        email: null,
        password: null,
      };
    },
    getMessage() {
      return this.message;
    },
  },
  methods: {
    open: function () {
      this.show = true;
    },
    cancel: function () {
      Object.keys(this.form).forEach((f) => {
        this.$refs[f].reset();
      });
      this.show = false;
    },
    submit: function () {
      this.formHasErrors = false;

      Object.keys(this.form).forEach((f) => {
        if (!this.form[f]) this.formHasErrors = true;
        this.$refs[f].validate(true);
      });
      if (!this.formHasErrors) return "Can`t Sing In";

      const url = process.env.VUE_APP_URL + "/api/auth/sign_in";
      var params = new URLSearchParams();
      params.append("email", this.email);
      params.append("password", this.password);
      axios.defaults.headers.common["Content-Type"] = "application/json";
      axios.post(url, params).then(
        (response) => {
          localStorage.setItem(
            "access-token",
            response.headers["access-token"]
          );
          localStorage.setItem("client", response.headers["client"]);
          localStorage.setItem("uid", response.headers["uid"]);
          localStorage.setItem("token-type", response.headers["token-type"]);
          this.$router.push("information");
        },
        (error) => {
          this.message = "ログインに失敗しました。<br>Failed to SignIn";
          return error;
        }
      );
    },
  },
};
</script>


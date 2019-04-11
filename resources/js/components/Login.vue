<template>
  <v-layout align-center justify-center>
    <v-flex xs12 sm8 md6 lg5 xl4>
      <v-card>
        <v-toolbar dark color="blue darken-3">
          <v-toolbar-title>Login</v-toolbar-title>
        </v-toolbar>
        <v-card-text>
          <v-text-field v-model="email" autofocus color="accent" label="Email" required></v-text-field>
          <v-text-field v-model="password" type="password" color="accent" label="Password" required></v-text-field>
          <v-flex class="red--text" v-if="error">{{error}}</v-flex>
        </v-card-text>
        <v-card-actions class="px-3 pb-3">
          <v-flex text-xs-right>
            <v-btn @click="ingresar" color="primary">Ingresar</v-btn>
          </v-flex>
        </v-card-actions>
      </v-card>
    </v-flex>
  </v-layout>
</template>
<script>
import axios from "axios";
export default {
  data() {
    return {
      email: "",
      password: "",
      error: null
    };
  },
  methods: {
    ingresar() {
      this.error = null;
      let self = this;
      axios
        .post("api/employee/login", {
          email: this.email,
          password: this.password
        })
        .then(respuesta => {
          return respuesta.data;
        })
        .then(data => {
          if (data > 0) {
            this.$store.dispatch("guardarUser", self.email);
            this.$router.push({ name: "/" });
          }
        })
        .catch(err => {
          console.log(err);
        });
    }
  }
};
</script>


<template>
  <v-app id="app">
    <v-navigation-drawer
      fixed
      :clipped="$vuetify.breakpoint.mdAndUp"
      app
      v-model="drawer"
      v-if="isLogin"
    >
      <v-list dense>
        <template>
          <v-list-tile :to="{name:'employee'}">
            <v-list-tile-action>
              <v-icon>people</v-icon>
            </v-list-tile-action>
            <v-list-tile-title>
              Employee
            </v-list-tile-title>
          </v-list-tile>
        </template>
        <template>
          <v-list-tile :to="{name:'ticket'}">
            <v-list-tile-action>
              <v-icon>table_chart</v-icon>
            </v-list-tile-action>
            <v-list-tile-title>
              Ticket
            </v-list-tile-title>
          </v-list-tile>
        </template>
        <template>
          <v-list-tile :to="{name:'report'}">
            <v-list-tile-action>
              <v-icon>table_chart</v-icon>
            </v-list-tile-action>
            <v-list-tile-title>
              Report
            </v-list-tile-title>
          </v-list-tile>
        </template>
      </v-list>
    </v-navigation-drawer>
    <v-toolbar
      color="blue darken-3"
      dark
      app
      :clipped-left="$vuetify.breakpoint.mdAndUp"
      fixed
    >
      <v-toolbar-title style="width: 300px" class="ml-0 pl-3">
        <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
        <span class="hidden-sm-and-down">Ticket System</span>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn @click="salir" v-if="isLogin" icon> <v-icon>logout</v-icon> Exit</v-btn>
      <!-- <v-btn @click="salir" icon>
        <v-icon>logout</v-icon> Salir
      </v-btn> -->
      <!-- <v-btn :to="{name: 'login'}" v-else>
        <v-icon>apps</v-icon> Login
      </v-btn> -->
    </v-toolbar>
    <v-content>
      <v-container fluid fill-height>
        <v-slide-y-transition mode="out-in">
          <router-view/>
        </v-slide-y-transition>
      </v-container>
    </v-content>
    <v-footer dark height="auto">
      <v-layout justify-center>
        <v-flex text-xs-center>
          <v-card flat tile color="primary" class="white--text">
            <v-card-text class="white--text pt-0">
              IncanatoIT &copy;2018
            </v-card-text>
          </v-card>
        </v-flex>
      </v-layout>
    </v-footer>

  </v-app>
</template>
<script>

export default {
  name: 'App',
  data () {
    return {
      clipped: false,
      drawer: true,
      fixed: false,
      items: [{
        icon: 'bubble_chart',
        title: 'Inspire'
      }],
      miniVariant: false,
      right: true,
      rightDrawer: false,
      title: 'Vuetify.js'
    }
  },
  computed: {
    isLogin(){
      return this.$store.state.usuario;
    },
  },
  created(){
    this.$store.dispatch("autoLogin");
  },
  methods:{
    salir(){
      this.$store.dispatch("salir");
    }
  }
}
</script>

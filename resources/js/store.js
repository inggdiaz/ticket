import Vue from 'vue'
import Vuex from 'vuex'
import router from './router'

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    token: null,
    usuario: null
  },
  mutations: {
    setUsuario(state, usuario) {
      state.usuario = usuario
    }
  },
  actions: {
    guardarUser({ commit }, user) {
      commit("setUsuario", user);
      localStorage.setItem("user", user);
    },
    autoLogin({ commit }) {
      let user = localStorage.getItem("user");
      if (user) {
        commit("setUsuario", user)
        router.push({ name: 'home' });
      } else {
        router.push({ name: 'login' });
      }
    },
    salir({ commit }) {
      commit("setUsuario", null)
      localStorage.removeItem("user");
      router.push({ name: 'login' });
    }
  }
})

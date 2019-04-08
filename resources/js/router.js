import Vue from 'vue'
import Router from 'vue-router'
import Login from './components/Login.vue'
import Employee from './components/Employee.vue'
// import store from './store'

Vue.use(Router)

var router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'employee',
      component: Employee,
    },
    {
      path: '/login',
      name: 'login',
      component: Login,
      meta : {
        libre: true
      }
    }
  ]
})

export default router

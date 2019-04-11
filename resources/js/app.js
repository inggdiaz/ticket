/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */
require('./bootstrap');
window.Vue = require('vue');
import Vuetify from 'vuetify';
import App from './App.vue';
import router from './router';
import DatetimePicker from 'vuetify-datetime-picker';
import 'vuetify/dist/vuetify.min.css'; // Ensure you are using css-loader
import VeeValidate from 'vee-validate';
import store from './store'
Vue.use(Vuetify);
Vue.use(VeeValidate);
Vue.use(DatetimePicker);
/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */
new Vue({
    router,
    store,
    render: h => h(App)
}).$mount('#app')

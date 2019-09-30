import Vue from 'vue';
import VueCookies from 'vue-cookies';
import router from '../src/router';
import store from '../src/store/index';
import app from '../src/app';

Vue.use(VueCookies);

document.addEventListener('DOMContentLoaded', () => {
  if (document.getElementById('home') !== null) {
    const el = document.getElementById('home');

    return new Vue({
      el,
      router,
      store,
      render: h => h(app),
    });
  }

  return '';
});

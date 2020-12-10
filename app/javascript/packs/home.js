import Vue from 'vue';
import router from '../src/router';
import store from '../src/store/index';
import app from '../src/app';
import Notification from '../src/utils/notification';

import '../styles/application.css';

Vue.use(Notification);

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

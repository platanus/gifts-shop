import Vue from 'vue';
import router from '../src/router';
import store from '../src/store/index';
import app from '../src/app';

import '../styles/application.css';

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

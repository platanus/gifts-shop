import 'circular-std';
import Vue from 'vue';
<<<<<<< HEAD

import router from '../src/router';
import store from '../src/store/index';
import app from '../src/app';

document.addEventListener('DOMContentLoaded', () => {
  if (document.getElementById('app') !== null) {
    const el = document.getElementById('app');

    return new Vue({
      el,
      router,
      store,
      render: h => h(app),
    });
  }

  return '';
=======
import NewProductForm from '../components/new-product-form.vue';
import ToggleDisplay from '../components/toggle-display.vue';

document.addEventListener('turbolinks:load', () => {
  if (document.getElementById('app')) {
    return new Vue({
      el: '#app',
      components: {
        NewProductForm,
        ToggleDisplay,
      },
    });
  }

  return null;
>>>>>>> df52741... chore (vue-setup) set up environment and utils for running vue
});

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

document.addEventListener('turbolinks:load', () => {
  if (document.getElementById('app')) {
    return new Vue({
      el: '#app',
      components: {
        NewProductForm,
      },
    });
  }

  return null;
>>>>>>> df52741... chore (vue-setup) set up environment and utils for running vue
});

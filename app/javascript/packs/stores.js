import 'circular-std';
import Vue from 'vue';

import NewProductForm from '../components/new-product-form.vue';
import ToggleDisplay from '../components/toggle-display.vue';

document.addEventListener('DOMContentLoaded', () => {
  if (document.getElementById('stores-app')) {
    return new Vue({
      el: '#stores-app',
      components: {
        NewProductForm,
        ToggleDisplay,
      },
    });
  }

  return null;
});

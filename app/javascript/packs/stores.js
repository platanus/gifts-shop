import Vue from 'vue';

import NewProductForm from '../stores/components/new-product-form.vue';
import ToggleButton from '../stores/components/toggle-button.vue';

document.addEventListener('DOMContentLoaded', () => {
  if (document.getElementById('stores-app')) {
    return new Vue({
      el: '#stores-app',
      components: {
        NewProductForm,
        ToggleButton,
      },
    });
  }

  return null;
});

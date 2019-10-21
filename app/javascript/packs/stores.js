import Vue from 'vue';

import NewProductForm from '../stores/components/new-product-form.vue';
import ToggleDisplay from '../stores/components/toggle-display.vue';
import TogglePromoted from '../stores/components/toggle-promoted.vue';

document.addEventListener('DOMContentLoaded', () => {
  if (document.getElementById('stores-app')) {
    return new Vue({
      el: '#stores-app',
      components: {
        NewProductForm,
        ToggleDisplay,
        TogglePromoted,
      },
    });
  }

  return null;
});

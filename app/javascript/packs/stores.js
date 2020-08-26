import Vue from 'vue';

import NewProductForm from '../stores/components/new-product-form.vue';
import EasyProductForm from '../stores/components/easy-product-form.vue';
import ToggleButton from '../stores/components/toggle-button.vue';
import BalanceWarning from '../stores/components/balance-warning.vue';
import store from '../stores/store/index';

document.addEventListener('DOMContentLoaded', () => {
  if (document.getElementById('stores-app')) {
    return new Vue({
      el: '#stores-app',
      components: {
        EasyProductForm,
        ToggleButton,
        BalanceWarning,
      },
      store,
    });
  }

  return null;
});

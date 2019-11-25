import Vue from 'vue';
import Vuex from 'vuex';

import storeApi from '../api/store';

Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    lowBalance: false,
  },
  mutations: {
    updateBalanceState: (state, payload) => {
      state.lowBalance = payload;
    },
  },
  actions: {
    updateBalance: (context, payload) => {
      storeApi.getStore(payload).then((response) => {
        context.commit('updateBalanceState', response.store.lowBalance);
      });
    },
  },
});

export default store;

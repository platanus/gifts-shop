import Vue from 'vue';
import Vuex from 'vuex';
import VuexPersistence from 'vuex-persist';

import productsApi from '../api/products';
import storesApi from '../api/stores';

Vue.use(Vuex);

const vuexLocal = new VuexPersistence({
  storage: window.localStorage,
  reducer: (state) => ({
    nextPage: state.nextPage,
  }),
});

// eslint-disable-next-line new-cap
const store = new Vuex.Store({
  state: {
    products: [],
    store: null,
    likes: 0,
    loading: true,
    minPrice: 5000,
    maxPrice: 30000,
    nextPage: 1,
    ideasSearched: 0,
    emailModalIsOpen: false,
    sharedProduct: null,
    userEmail: '',
    selectedInterval: 0,
  },
  mutations: {
    setUserEmail: (state, payload) => {
      state.userEmail = payload;
    },
    setStore: (state, payload) => {
      state.store = payload;
    },
    setNextPage: (state, payload) => {
      state.nextPage = payload;
    },
    toggleEmailModal: (state) => {
      state.emailModalIsOpen = !state.emailModalIsOpen;
    },
    setSharedProduct: (state, payload) => {
      state.sharedProduct = payload;
    },
    setLoading: (state, payload) => {
      state.loading = payload;
    },
    addIdeasSearched: (state) => {
      state.ideasSearched += 1;
    },
    setSelectedInterval: (state, payload) => {
      state.selectedInterval = payload;
    },
  },
  actions: {
    getProducts: context => {
      storesApi.index(context.state.nextPage).then((response) => {
        context.commit('setNextPage', response.meta.nextPage);
        context.commit('setStore', response.stores[0]);
      });
    },
    markClicked: (context, payload) => {
      productsApi.markClicked(payload);
    },
  },
  plugins: [vuexLocal.plugin],
});

export default store;

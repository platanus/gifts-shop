import Vue from 'vue';
import Vuex from 'vuex';

import productsApi from '../api/products';

Vue.use(Vuex);

// eslint-disable-next-line new-cap
const store = new Vuex.Store({
  state: {
    products: {},
    productRows: {},
  },
  mutations: {
    setProducts: (state, payload) => {
      state.products = payload;
    },
  },
  actions: {
    getProducts: context => {
      productsApi.products().then((response) => {
        const products = response.products.reduce((acc, product) => {
          acc[product.id] = { ...product };

          return acc;
        }, {});
        context.commit('setProducts', products);
      });
    },
    markDisplayed: (context, payload) => {
      productsApi.markDisplayed(payload);
    },
    markLiked: (context, payload) => {
      productsApi.markLiked(payload);
    },
  },
  getters: {
    productsArray: state => (
      Object.keys(state.products).map(
        key => ({ id: key, ...state.products[key] })
      )
    ),
  },
});

export default store;

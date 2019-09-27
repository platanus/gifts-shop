import Vue from 'vue';
import Vuex from 'vuex';

import productsApi from '../api/products';

Vue.use(Vuex);
const INITIAL_NUMBER_OF_PRODUCTS = 15;
const NUMBER_OF_PRODUCTS = 15;
// eslint-disable-next-line new-cap
const store = new Vuex.Store({
  state: {
    products: {},
    loading: false,
  },
  mutations: {
    setProducts: (state, payload) => {
      state.products = payload;
    },
    addProducts: (state, payload) => {
      state.products = { ...state.products, ...payload };
    },
  },
  actions: {
    getProducts: context => {
      productsApi.products(INITIAL_NUMBER_OF_PRODUCTS).then((response) => {
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
    moreProducts: context => {
      productsApi.products(NUMBER_OF_PRODUCTS).then((response) => {
        const products = response.products.reduce((acc, product) => {
          acc[product.id] = { ...product };

          return acc;
        }, {});
        context.commit('addProducts', products);
      });
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

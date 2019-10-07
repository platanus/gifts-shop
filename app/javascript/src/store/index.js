import Vue from 'vue';
import Vuex from 'vuex';

import productsApi from '../api/products';
import receiverApi from '../api/receiver';

Vue.use(Vuex);
const INITIAL_NUMBER_OF_PRODUCTS = 15;
const NUMBER_OF_PRODUCTS = 15;
// eslint-disable-next-line new-cap
const store = new Vuex.Store({
  state: {
    products: [],
    loading: false,
    minPrice: 1000,
    maxPrice: 50000,
    receiverName: '',
  },
  mutations: {
    setProducts: (state, payload) => {
      state.products = Object.values(payload);
    },
    addProducts: (state, payload) => {
      state.products = [...state.products, ...Object.values(payload)];
    },
    setMinPrice: (state, payload) => {
      state.minPrice = payload;
    },
    setMaxPrice: (state, payload) => {
      state.maxPrice = payload;
    },
    setReceiverName: (state, payload) => {
      state.receiverName = payload;
    },
  },
  actions: {
    getReceiverName: (context, payload) => {
      receiverApi.getReceiver(payload).then((response) => {
        const receiverName = response.name;
        context.commit('setReceiverName', receiverName);
      });
    },
    getProducts: context => {
      const params = [
        INITIAL_NUMBER_OF_PRODUCTS,
        context.state.minPrice,
        context.state.maxPrice,
      ];
      productsApi.products(...params).then((response) => {
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
    moreProducts: context => new Promise((resolve, reject) => {
      const params = [
        NUMBER_OF_PRODUCTS,
        context.state.minPrice,
        context.state.maxPrice,
      ];
      productsApi.products(...params).then((response) => {
        const products = response.products.reduce((acc, product) => {
          acc[product.id] = { ...product };

          return acc;
        }, {});
        context.commit('addProducts', products);
        resolve();
      }, error => {
        reject(error);
      });
    }),
    applyPriceFilter: (context, payload) => {
      context.commit('setMinPrice', payload[0]);
      context.commit('setMaxPrice', payload[1]);
      context.dispatch('resetProducts');
    },
    resetProducts: context => {
      context.commit('setProducts', []);
      context.dispatch('getProducts');
    },
  },
});

export default store;

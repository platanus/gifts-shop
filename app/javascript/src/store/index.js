import Vue from 'vue';
import Vuex from 'vuex';

import productsApi from '../api/products';
import receiverApi from '../api/receiver';

Vue.use(Vuex);

// eslint-disable-next-line new-cap
const store = new Vuex.Store({
  state: {
    products: [],
    loading: false,
    minPrice: 1000,
    maxPrice: 50000,
    receiverName: '',
    numberOfProducts: 8,
    promoted: 4,
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
    setPromoted: (state, payload) => {
      state.promoted = payload;
    },
    setNumberOfProducts: (state, payload) => {
      state.numberOfProducts = payload;
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
        context.state.numberOfProducts,
        context.state.minPrice,
        context.state.maxPrice,
        context.state.promoted,
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
    markClicked: (context, payload) => {
      productsApi.markClicked(payload);
    },
    moreProducts: context => new Promise((resolve, reject) => {
      const params = [
        context.state.numberOfProducts,
        context.state.minPrice,
        context.state.maxPrice,
        context.state.promoted,
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

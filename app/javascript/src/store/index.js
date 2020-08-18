import Vue from 'vue';
import Vuex from 'vuex';

import productsApi from '../api/products';
import receiverApi from '../api/receiver';
import numberOfProducts from '../utils/numberOfProducts';

Vue.use(Vuex);

const LIMIT_PRICE_OFFSET_PERCENTAGE = 0.4;

// eslint-disable-next-line new-cap
const store = new Vuex.Store({
  state: {
    products: [],
    likes: 0,
    loading: false,
    minPrice: 5000,
    maxPrice: 30000,
    receiverName: '',
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
  },
  actions: {
    getReceiverName: (context) => {
      receiverApi.getReceiver().then(({ receiver, likes }) => {
        context.commit('setReceiverName', receiver.name);
        const limit = parseInt(receiver.giftLimit, 10);
        if (limit) {
          const limitOffset = limit * LIMIT_PRICE_OFFSET_PERCENTAGE;
          context.commit('setMinPrice', limit - limitOffset);
          context.commit('setMaxPrice', limit + limitOffset);
          context.dispatch('applyPriceFilter');
        }
      });
    },
    getProducts: context => {
      const params = [
        numberOfProducts(),
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
    markClicked: (context, payload) => {
      productsApi.markClicked(payload);
    },
    deleteSessionReceiver: () => {
      receiverApi.deleteSession()
        .then(() => window.location.reload())
        .catch(() => {});
    },
    moreProducts: context => new Promise((resolve, reject) => {

      const params = [
        numberOfProducts(),
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
    applyPriceFilter: context => {
      context.dispatch('resetProducts');
    },
    resetProducts: context => {
      context.commit('setProducts', []);
      context.dispatch('getProducts');
    },
  },
});

export default store;

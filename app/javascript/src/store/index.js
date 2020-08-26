import Vue from 'vue';
import Vuex from 'vuex';

import productsApi from '../api/products';
import numberOfProducts from '../utils/numberOfProducts';

Vue.use(Vuex);

const LIMIT_PRICE_OFFSET_PERCENTAGE = 0.4;

// eslint-disable-next-line new-cap
const store = new Vuex.Store({
  state: {
    products: [],
    category: null,
    likes: 0,
    loading: false,
    minPrice: 5000,
    maxPrice: 30000,
    promoted: 4,
    nextPage: 1,
  },
  mutations: {
    setProducts: (state, payload) => {
      state.products = Object.values(payload);
    },
    setCategory: (state, payload) => {
      state.category = payload;
    },
    setPromoted: (state, payload) => {
      state.promoted = payload;
    },
    setNextPage: (state, payload) => {
      console.log(payload)
      state.nextPage = payload;
    },
  },
  actions: {
    getProducts: context => {
      productsApi.category(context.state.nextPage).then((response) => {
        const products = response.categories[0].products.reduce((acc, product) => {
          acc[product.id] = { ...product };

          return acc;
        }, {});
        context.commit('setNextPage', response.meta.nextPage);
        context.commit('setProducts', products);
        context.commit('setCategory', response.categories[0])
      });
    },
    markClicked: (context, payload) => {
      productsApi.markClicked(payload);
    },
  },
});

export default store;

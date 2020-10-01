import Vue from 'vue';
import Vuex from 'vuex';
import VuexPersistence from 'vuex-persist';

import productsApi from '../api/products';

Vue.use(Vuex);

const vuexLocal = new VuexPersistence({
  storage: window.localStorage,
  reducer: (state) => ({ favoriteProducts: state.favoriteProducts }),
});

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
    favoriteProducts: {},
  },
  mutations: {
    setCategory: (state, payload) => {
      state.category = payload;
    },
    setPromoted: (state, payload) => {
      state.promoted = payload;
    },
    setNextPage: (state, payload) => {
      state.nextPage = payload;
    },
    addFavoriteProduct: (state, payload) => {
      Vue.set(state.favoriteProducts, payload.id, payload);
    },
    removeFavoriteProduct: (state, payload) => {
      const { ...favoriteProductsCopy } = state.favoriteProducts;
      delete favoriteProductsCopy[payload];
      Vue.set(state, 'favoriteProducts', favoriteProductsCopy);
    },
  },
  actions: {
    getProducts: context => {
      productsApi.category(context.state.nextPage).then((response) => {
        context.commit('setNextPage', response.meta.nextPage);
        context.commit('setCategory', response.categories[0]);
      });
    },
    markClicked: (context, payload) => {
      productsApi.markClicked(payload);
    },
  },
  plugins: [vuexLocal.plugin],
});

export default store;

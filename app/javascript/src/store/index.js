import Vue from 'vue';
import Vuex from 'vuex';
import VuexPersistence from 'vuex-persist';

import productsApi from '../api/products';

Vue.use(Vuex);

const vuexLocal = new VuexPersistence({
  storage: window.localStorage,
  reducer: (state) => ({ favoriteCategories: state.favoriteCategories }),
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
    favoriteCategories: {},
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
    addFavoriteCategory: (state, payload) => {
      Vue.set(state.favoriteCategories, payload.id, payload);
    },
    removeFavoriteCategory: (state, payload) => {
      const { ...favoriteCategoriesCopy } = state.favoriteCategories;
      delete favoriteCategoriesCopy[payload];
      Vue.set(state, 'favoriteCategories', favoriteCategoriesCopy);
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

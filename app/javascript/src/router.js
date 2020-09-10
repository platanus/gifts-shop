import Vue from 'vue';
import VueRouter from 'vue-router';

import HomeView from './views/home';
import FavoritesView from './views/favorites';

Vue.use(VueRouter);

const routes = [
  {
    path: '/',
    component: HomeView,
  },
  {
    path: '/favorites',
    component: FavoritesView,
  },
];

const router = new VueRouter({
  routes,
});

export default router;

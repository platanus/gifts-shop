import Vue from 'vue';
import VueRouter from 'vue-router';

import HomeView from './views/home';

Vue.use(VueRouter);

const routes = [
  {
    path: '/',
    component: HomeView,
  },
];

const router = new VueRouter({
  routes,
});

export default router;

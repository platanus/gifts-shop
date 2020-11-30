<template>
  <div
    class="sticky top-0 z-20 grid items-center w-full h-16 grid-cols-3 mx-auto bg-white shadow-md"
  >
    <div class="flex items-center h-full ml-3 cursor-pointer text-primary">
      <img
        class="block"
        src="../assets/store.svg"
        @click="goToStore"
      >
      <div
        class="my-auto ml-1 text-sm"
        @click="goToStore"
      >
        <span class="hidden sm:inline">Vende tus productos</span>
        <span class="sm:hidden">Vender</span>
      </div>
    </div>
    <div class="h-full mt-2">
      <router-link to="/">
        <img
          class="h-12 mx-auto"
          src="../assets/buenas-ideas.svg"
        >
      </router-link>
    </div>
    <div class="mr-3 text-right">
      <router-link to="/favorites">
        <button
          class="h-8 px-3 my-auto text-sm transition-all duration-200 border border-solid rounded-sm text-primary border-primary hover:bg-primary hover:text-white"
        >
          <span class="hidden sm:inline">Ver mis favoritos</span>
          <span class="sm:hidden">Favoritos</span>
        </button>
      </router-link>
    </div>
  </div>
</template>
<script>
import { mapMutations, mapState } from 'vuex';

const MOBILE_WIDTH = 650;
const TABLET_WIDTH = 1000;

export default {
  name: 'HomeHeader',
  data() {
    const desktop = window.innerWidth > TABLET_WIDTH;

    return {
      mobile: window.innerWidth <= MOBILE_WIDTH,
      desktop,
    };
  },
  computed: {
    ...mapState([
      'animateFavorites',
    ]),
  },
  methods: {
    ...mapMutations([
      'setAnimateFavorites',
    ]),
    goToStore() {
      window.location = '/stores/catalog/new';
    },
    onResize() {
      this.mobile = window.innerWidth <= MOBILE_WIDTH;
      this.desktop = window.innerWidth > TABLET_WIDTH;
    },
  },
  mounted() {
    window.addEventListener('resize', this.onResize);
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.onResize);
  },
};
</script>

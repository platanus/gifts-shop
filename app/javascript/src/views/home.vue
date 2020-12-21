<template>
  <div class="block w-full min-h-screen text-base bg-background">
    <home-header />
    <div
      v-if="category"
      v-show="!loading"
    >
      <div class="py-4 sm:bg-secondary bg-white m-auto category-header">
        <p class="flex justify-center text-2xl text-gray-800 sm:mb-4 sm:text-3xl sm:text-white">
          <span class="hidden sm:flex">Encontramos:&nbsp; </span>
          <span class="font-bold">{{ category.name }}</span>
        </p>
        <p class="hidden sm:flex justify-center px-4 text-lg font-light leading-5 text-center text-white">
          {{ category.description }}
        </p>
      </div>
      <category
        :category="category"
        v-if="category"
        @loaded-category="loadedCategory"
      />
    </div>
    <div class="loader-spinner">
      <clip-loader
        :loading="loading"
        v-show="loading"
      />
    </div>
  </div>
</template>

<script>
import ClipLoader from 'vue-spinner/src/ClipLoader.vue';
import { mapState, mapMutations } from 'vuex';
import category from '../components/category';
import HomeHeader from '../components/home-header';

export default {
  name: 'HomeView',
  components: {
    category,
    ClipLoader,
    HomeHeader,
  },
  computed: {
    ...mapState([
      'products',
      'category',
      'likes',
      'loading',
    ]),
  },
  mounted() {
    this.$store.dispatch('getProducts').then(() => {
      this.setLoading(false);
    });
  },
  methods: {
    ...mapMutations([
      'setLoading',
    ]),
    loadedCategory() {
      this.setLoading(false);
    },
  },
};
</script>

<style lang="scss">
  @import '../../styles/variables';

  .loader-spinner {
    display: flex;
    justify-content: center;
    height: 42px;
    margin-top: 25px;
  }

  .category-header {
    width: calc(min(100%, 900px));
  }

</style>

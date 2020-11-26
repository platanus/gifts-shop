<template>
  <div class="block w-full min-h-screen text-base bg-background">
    <home-header />
    <div
      v-if="category"
      v-show="!loading"
    >
      <div class="py-4 bg-secondary">
        <p class="flex justify-center text-white">
          Encontramos:&nbsp; <span class="font-bold">{{ category.name }}</span>
        </p>
        <p class="flex justify-center px-4 text-sm leading-5 text-center text-white">
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
    this.$store.commit('setNextPage', 0);
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

</style>

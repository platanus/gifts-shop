<template>
  <div class="block w-full min-h-screen text-base bg-background">
    <home-header />
    <div v-if="category">
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
      />
      <div class="flex flex-col w-48 pt-10 mx-auto text-gray-700 align-items-center">
        <p class="pb-3 text-center">
          No te convence?🤔
        </p>
        <button
          class="px-1 py-2 text-sm font-bold text-white rounded-sm bg-primary"
          @click="$store.dispatch('getProducts')"
        >
          SIGAMOS BUSCANDO
        </button>
      </div>
    </div>
    <div class="loader-spinner">
      <clip-loader
        :loading="this.$store.loading"
      />
    </div>
  </div>
</template>

<script>
import ClipLoader from 'vue-spinner/src/ClipLoader.vue';
import { mapState } from 'vuex';
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
    ]),
  },
  mounted() {
    this.$store.commit('setNextPage', 0);
    this.$store.dispatch('getProducts').then(() => {
      this.$store.loading = false;
    });
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

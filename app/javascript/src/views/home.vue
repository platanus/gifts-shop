<template>
  <div class="block w-full min-h-screen text-base bg-background">
    <navbar />
    <modal
      :show-modal="emailModalIsOpen"
    />
    <div
      v-if="category"
      v-show="!loading"
    >
      <div class="py-4 m-auto bg-white sm:bg-secondary category-header">
        <p class="flex justify-center text-2xl text-gray-800 sm:mb-4 sm:text-3xl sm:text-white">
          <span class="hidden sm:flex">Encontramos:&nbsp; </span>
          <span class="font-bold">{{ category.name }}</span>
        </p>
        <p class="justify-center hidden px-4 text-lg font-light leading-5 text-center text-white sm:flex">
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
import modal from '../components/modal-share-email.vue';
import category from '../components/category';
import navbar from '../components/navbar';

export default {
  name: 'HomeView',
  components: {
    category,
    ClipLoader,
    navbar,
    modal,
  },
  computed: {
    ...mapState([
      'products',
      'category',
      'likes',
      'loading',
      'emailModalIsOpen',
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

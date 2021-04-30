<template>
  <div class="block w-full min-h-screen text-base bg-background">
    <home-header />
    <modal
      :show-modal="emailModalIsOpen"
      @accept="productShareByEmail(sharedProduct)"
      @close="closeModal"
    >
      <template #title>
        Ingresa tu correo para compartir este regalo!
      </template>
      <template #body>
        <input
          v-model="email"
          placeholder="example@platan.us"
          type="email"
          class="px-2 py-2 h-10 leading-normal block w-full text-gray-800 bg-white font-sans rounded-lg text-left border border-black focus:border-blue-500"
        >
      </template>
      <template #accept-button-text>
        ENVIAR
      </template>
    </modal>
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
import modal from '../components/modal-share-email.vue';
import category from '../components/category';
import HomeHeader from '../components/home-header';
import productsApi from '../api/products';

export default {
  name: 'HomeView',
  data() {
    return {
      email: '',
    };
  },
  components: {
    category,
    ClipLoader,
    HomeHeader,
    modal,
  },
  computed: {
    ...mapState([
      'products',
      'category',
      'likes',
      'loading',
      'emailModalIsOpen',
      'sharedProduct',
      'userEmail',
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
      'toggleEmailModal',
      'setUserEmail',
    ]),
    loadedCategory() {
      this.setLoading(false);
    },
    closeModal() {
      this.toggleEmailModal();
    },
    productShareByEmail(product) {
      this.setUserEmail(this.email);
      productsApi.shareByEmail(product.id, this.userEmail, this.productLink(product));
      this.toggleEmailModal();
    },
    productLink(product) {
      return `${product.link}?ref=bazar.sorteoamigosecreto.com`;
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

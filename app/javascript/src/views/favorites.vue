<template>
  <div class="w-full min-h-screen text-base bg-background">
    <home-header />
    <modal
      :show-modal="modalIsOpen"
      @accept="removeProduct"
      @close="closeModal"
    >
      <template #body>
        ¿De verdad quieres borrar este producto de tus favoritos?
      </template>
      <template #accept-button-text>
        ¡Sí!
      </template>
      <template #cancel-button-text>
        Mejor no
      </template>
    </modal>
    <div class="flex flex-col w-full mx-auto my-4 rounded sm:my-10 sm:shadow-md sm:bg-white bg-background favorite-products ">
      <div v-if="Object.keys(favoriteProducts).length === 0">
        No tienes ningún producto favorito 😢
      </div>
      <div
        v-for="(product, index) in favoriteProducts"
        :key="index"
        class="w-auto px-3 my-3 bg-white rounded shadow-sm sm:px-6 sm:bg-none sm:shadow-none"
      >
        <div
          class="flex flex-col justify-between w-full sm:flex-row"
        >
          <div class="flex items-center">
            <img
              class="flex-none transition-opacity duration-200 opacity-50 cursor-pointer hover:text-black hover:opacity-100"
              src="../assets/cross.svg"
              @click="openModal(product.id)"
            >
            <div class="justify-center flex-none w-32 h-32 mx-5 my-4 sm:mx-6 sm:w-40 sm:h-40">
              <img
                class="self-center object-contain h-full min-w-full"
                :src="product.imageUrl"
              >
            </div>
            <div>
              <p class="text-sm sm:text-lg">
                {{ product.name }}
              </p>
              <div class="text-gray-700">
                ${{ product.price }}
              </div>
            </div>
          </div>
          <div class="flex flex-row justify-center mb-4 sm:mb-0 sm:flex-col">
            <button
              class="px-5 py-1 mx-2 my-1 text-sm font-bold text-white rounded-sm bg-primary"
              @click="clickAction(product)"
            >
              Ver producto
            </button>
            <button
              v-if="currentCategoryIndex !== index"
              @click="openCategory(index)"
              class="px-5 py-1 mx-2 my-1 text-sm font-bold transition-all duration-200 border border-solid rounded-sm text-primary border-primary"
            >
              Ver categoría
            </button>
            <button
              v-else
              @click="currentCategoryIndex = -1"
              class="px-5 py-1 mx-2 my-1 text-sm font-bold transition-all duration-200 border border-solid rounded-sm text-primary border-primary"
            >
              Ocultar
            </button>
          </div>
        </div>
        <div class="favorite-product__preview">
          <div
            v-if="currentCategoryIndex === index"
            class="favorite-product__preview-card--expanded"
          >
            <category
              :category="currentCategory"
              :hide-favorite-button="true"
            />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions, mapState } from 'vuex';
import category from '../components/category';
import HomeHeader from '../components/home-header';
import modal from '../components/modal';
import categoriesApi from '../api/category.js';

export default {
  name: 'Favorites',
  data() {
    return {
      currentCategoryIndex: -1,
      currentCategory: null,
      modalProduct: -1,
      modalIsOpen: false,
    };
  },
  components: {
    category,
    HomeHeader,
    modal,
  },
  computed: {
    ...mapState([
      'favoriteProducts',
    ]),
  },
  filters: {
    toUpper(value) {
      return value.charAt(0).toUpperCase() + value.slice(1);
    },
  },
  methods: {
    ...mapActions([
      'markClicked',
    ]),
    clickAction(product) {
      this.markClicked(product.id);
      window.open(product.link, '_blank');
    },
    openCategory(index) {
      this.getCategory(this.favoriteProducts[index], index);
    },
    closeModal() {
      this.modalIsOpen = false;
    },
    openModal(productIndex) {
      this.modalProduct = productIndex;
      this.modalIsOpen = true;
    },
    removeProduct() {
      this.modalIsOpen = false;
      this.$store.commit('removeFavoriteProduct', this.modalProduct);
    },
    async getCategory({ categoryId }, index) {
      this.currentCategory = await categoriesApi.getCategory(categoryId);
      this.currentCategoryIndex = index;
    },
  },
};
</script>

<style lang="scss" scoped>
  @import '../../styles/variables';

  .favorite-products {
    width: calc(min(90%, 700px));
  }

  .favorite-product {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    width: 100%;

    &__preview {
      overflow: hidden;
    }

    &__preview-card {
      display: flex;
      justify-content: center;
      margin-top: -200%;
      transition: all 1s;

      &--expanded {
        margin-top: 0;
      }
    }
  }
</style>

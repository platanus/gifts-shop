<template>
  <div
    class="flex flex-col w-auto mx-auto bg-white border border-gray-100 border-solid rounded-md shadow-md sm:w-full sm:flex-row product"
  >
    <div
      class="relative w-full h-56 product__image sm:h-auto"
    >
      <div
        v-if="!hideFavoriteButton"
        class="absolute top-0 right-0 z-10 flex justify-center p-1 mt-5 mr-5 bg-white rounded-full shadow hover:cursor-pointer"
        @click="setLikeStatus"
      >
        <img
          v-if="isLiked"
          class="cursor-pointer"
          src="../assets/like-color-badge.svg"
        >
        <img
          v-else
          class="cursor-pointer"
          src="../assets/like-badge.svg"
        >
      </div>
      <img
        class="object-cover w-full h-full"
        :src="product.imageUrl"
        @load="loaded = true;"
        v-show="loaded"
      >
    </div>
    <div
      class="relative flex flex-col w-7/12 mt-3 ml-3 mr-8 product__info"
    >
      <span class="text-xl font-bold">{{ product.name }}</span>
      <span
        class="text-xs text-red-700"
        :class="{ 'invisible' : !highlight }"
      >
        🛍️ Top choice
      </span>

      <p class="mt-5 text-justify text-md">
        {{ product.description }}
      </p>
      <div class="absolute bottom-0 mb-5">
        <p class="pb-2 text-xs font-bold uppercase">
          Escoge tu opción
        </p>
        <div
          class="inline"
          v-for="(categoryProduct, index) in category.products"
          :key="index"
        >
          <button
            class="w-8 h-8 mx-1 text-gray-600 border border-gray-400 border-solid rounded-full shadow"
            :class="{'border-primary' : categoryProduct === product }"
            @click="$emit('change-slide', index)"
          >
            <span
              class="inline text-xs font-bold text-center"
              :class="{'text-black' : categoryProduct === product }"
            >
              {{ "$".repeat(index + 1) }}
            </span>
          </button>
        </div>
      </div>
      <button
        class="absolute bottom-0 right-0 px-5 py-2 mb-5 text-sm font-bold text-white rounded-sm bg-primary"
        @click="clickAction"
      >
        <span class="inline text-center">VER PRODUCTO</span>
      </button>
    </div>
  </div>
</template>

<script>
import { mapActions, mapState } from 'vuex';
import convertToClp from '../utils/convert-to-clp';

export default {
  data() {
    return {
      loaded: false,
    };
  },
  methods: {
    ...mapActions([
      'markClicked',
    ]),
    clickAction() {
      this.markClicked(this.product.id);
      window.open(this.product.link, '_blank');
    },
    setLikeStatus() {
      if (this.isLiked) {
        this.$store.commit('removeFavoriteProduct', this.product.id);
      } else {
        this.$store.commit('addFavoriteProduct', this.product);
      }
    },
  },
  props: {
    product: {
      type: Object,
      default: null,
    },
    highlight: {
      type: Boolean,
      default: false,
    },
    hideFavoriteButton: {
      type: Boolean,
      default: false,
    },
    category: {
      type: Object,
      default: null,
    },
  },
  computed: {
    ...mapState([
      'favoriteProducts',
    ]),
    isLiked() {
      return this.product.id in this.favoriteProducts;
    },
  },
  filters: {
    Price(value) {
      const price = convertToClp(value);

      return `$${price}`;
    },
  },
};
</script>
<style lang="scss">
  @media (min-width: 640px) { // sm-breakpoint
    .product {
      height: 20rem;

      &__image {
        width: 45%;
      }

      &__info {
        width: 55%;
      }
    }
  }
</style>

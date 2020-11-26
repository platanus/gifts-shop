<template>
  <div
    class="flex flex-col w-auto mx-auto bg-white border border-gray-100 border-solid rounded-md shadow-md sm:w-full sm:flex-row product"
  >
    <div
      class="relative w-full h-56 product__image sm:h-auto"
    >
      <img
        class="object-cover w-full h-full cursor-pointer"
        :src="product.imageUrl"
        @load="$emit('loaded-image')"
        @click="clickAction"
      >
      <div class="sm:hidden">
        <div class="absolute top-0 block w-full h-full opacity-50 bg-gradient-to-b from-transparent via-transparent to-black" />
        <p
          class="absolute bottom-0 block mx-3 mb-2 text-xl font-bold text-white cursor-pointer"
          @click="clickAction"
        >
          {{ product.name }}
        </p>
      </div>
    </div>
    <div
      class="relative flex flex-col w-full px-3 mt-1 sm:mt-3 sm:pr-8 sm:h-auto product__info"
    >
      <div class="h-32">
        <span
          class="hidden text-xl font-bold cursor-pointer sm:block gtm"
          @click="clickAction"
        >
          {{ product.name }}
        </span>
        <span
          class="text-xs text-red-700"
          :class="{ 'hidden' : !highlight }"
        >
          🛍️ Regalo Popular!
        </span>

        <p class="my-2 text-sm text-justify sm:mt-3 sm:mr-0 sm:text-base">
          {{ product.description }}
        </p>
        <button
          class="px-2 py-1 text-sm text-red-700 border border-red-700 border-solid rounded-sm"
          @click="setLikeStatus"
        >
          <img
            class="inline fill-current"
            :src="isLiked ? '../assets/save_filled.svg' : '../assets/save.svg'"
            height="18"
            width="18"
          >
          <span>{{ isLiked ? "Guardado!" : "Guardar" }}</span>
        </button>
      </div>
      <div class="mb-5 text-center sm:text-left sm:absolute sm:bottom-0">
        <p class="pb-2 text-sm font-bold tracking-wider uppercase">
          Escoge tu opción:
        </p>
        <div
          class="inline"
          v-for="(categoryProduct, index) in category.products"
          :key="index"
        >
          <button
            class="w-12 h-12 mx-1 text-gray-600 border border-gray-400 border-solid rounded-full shadow sm:mr-2 sm:ml-0 gtm"
            :class="{'border-primary' : categoryProduct === product }"
            @click="$emit('change-slide', index)"
          >
            <span
              class="inline text-base font-bold text-center outline-none"
              :class="{'text-black' : categoryProduct === product }"
            >
              {{ categoryProduct.price | toSigns }}
            </span>
          </button>
        </div>
      </div>
      <button
        class="px-5 py-2 mb-6 text-sm font-bold text-white rounded-sm sm:absolute sm:bottom-0 sm:mr-8 sm:right-0 bg-primary place-self-center gtm"
        @click="clickAction"
      >
        <span class="inline text-center">VER PRODUCTO</span>
      </button>
    </div>
  </div>
</template>

<script>
import { mapActions, mapState, mapMutations } from 'vuex';
import convertToClp from '../utils/convert-to-clp';
import priceToSigns from '../utils/price-to-signs';

export default {
  methods: {
    ...mapActions([
      'markClicked',
    ]),
    ...mapMutations([
      'setLoading',
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
    getAnotherCategory() {
      this.setLoading(true);
      this.$store.dispatch('getProducts');
      window.scrollTo({
        top: 0,
        behavior: 'smooth',
      });
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
    toSigns(value) {
      return priceToSigns(value);
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

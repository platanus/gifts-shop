<template>
  <div
    class="flex flex-col w-auto mx-auto bg-white border border-gray-100 border-solid rounded-md shadow-md sm:w-full sm:flex-row product"
  >
    <div
      class="relative w-full h-56 product__image sm:h-auto"
    >
      <div
        class="absolute left-0 mt-4"
        :class="{ 'hidden' : !highlight }"
      >
        <div class="w-auto px-3 pt-1 pb-2 text-white bg-red-700 rounded-r">
          <span class="hidden text-xs font-bold sm:inline">🔥 Top Choice</span>
          <span class="inline text-xs font-bold sm:hidden">🔥 TOP</span>
        </div>
      </div>
      <img
        class="object-cover w-full h-full cursor-pointer gtm"
        :src="product.imageUrl"
        @load="$emit('loaded-image')"
        @click="clickAction"
      >
      <div class="sm:hidden">
        <div class="absolute top-0 block w-full h-full opacity-50 bg-gradient-to-b from-transparent via-transparent to-black" />
        <p
          class="absolute bottom-0 block mx-3 mb-2 text-xl font-bold text-white cursor-pointer gtm"
          @click="clickAction"
        >
          {{ product.name }}
        </p>
      </div>
    </div>
    <div
      class="relative flex flex-col w-full h-full px-3 mt-1 sm:mt-3 sm:h-auto product__info"
    >
      <div class="w-full text-center sm:text-left product__description">
        <span
          class="hidden text-xl font-bold cursor-pointer sm:block gtm"
          @click="clickAction"
        >
          {{ product.name }}
        </span>
        <p class="my-2 text-sm text-justify sm:mt-3 sm:mr-0 sm:text-base">
          {{ product.description }}
        </p>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex';
import convertToClp from '../utils/convert-to-clp';

export default {
  methods: {
    ...mapActions([
      'markClicked',
    ]),
    clickAction() {
      this.markClicked(this.product.id);
      window.open(this.product.referenceUrl, '_blank');
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
    store: {
      type: Object,
      default: null,
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
      height: 24rem;

      &__image {
        width: 45%;
      }

      &__info {
        width: 55%;
      }

      &__description {
        height: 13rem;
      }
    }
  }
</style>

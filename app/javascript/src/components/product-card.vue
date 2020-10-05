<template>
  <div
    class="flex flex-row w-full bg-white border border-gray-100 border-solid rounded-md shadow-md product"
  >
    <div
      class="product__image"
    >
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
      <button
        class="absolute bottom-0 right-0 px-5 py-2 mb-5 text-sm font-bold text-white rounded-sm bg-primary"
        @click="goToProduct"
      >
        <span class="inline text-center">VER PRODUCTO</span>
      </button>
    </div>
  </div>
</template>

<script>
import convertToClp from '../utils/convert-to-clp';

export default {
  data() {
    return {
      loaded: false,
    };
  },
  methods: {
    goToProduct() {
      window.open(this.product.link, '_blank');
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
  .product {
    height: 20rem;

    &__image {
      width: 45%;
    }

    &__info {
      width: 55%;
    }
  }
</style>

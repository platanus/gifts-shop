<template>
  <div
    class="flex flex-col w-full mx-1 bg-white border border-gray-100 border-solid rounded-sm shadow-md"
    :class="{ 'border-primary' : highlight, 'mt-4' : !highlight }"
  >
    <div
      class="w-full text-xs text-left text-white bg-primary"
      v-if="highlight"
    >
      <span class="ml-2">Regalo popular</span>
    </div>
    <transition
      name="fade"
    >
      <img
        class="object-cover h-20 m-2"
        :src="product.imageUrl"
        @load="loaded = true;"
        v-show="loaded"
      >
    </transition>
    <span class="m-auto text-xl"> {{ product.price | Price }} </span>

    <button
      class="px-2 py-1 mx-auto my-3 text-xs text-center text-white rounded-sm cursor-pointer bg-primary"
      @click="goToProduct"
    >
      <span class="inline text-center">Ver producto</span>
    </button>
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

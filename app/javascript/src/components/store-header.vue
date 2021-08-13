<template>
  <div
    class="pt-5 bg-white md:pb-7"
  >
    <div
      class="flex flex-col lg:mx-24 xl:mx-48 md:flex-row md:justify-between"
    >
      <div class="w-full">
        <p
          class="mx-4 text-sm font-roboto text-gf-gray-dark"
        >
          Estás buscando en la tienda:
        </p>
        <div class="flex items-center justify-between mx-3 text-2xl md:text-3xl font-semibold border rounded-md text-gf-gray-dark px-2.5 py-1 md:max-w-md">
          <div>
            <h2>{{ store.name }}</h2>
            <div class="flex space-x-2">
              <a
                v-if="store.instagram"
                :href="store.instagram"
                target="_blank"
              >
                <img
                  class="w-4 h-4"
                  :src="require('assets/images/instagram.svg')"
                  alt="instagram"
                >
              </a>
              <a
                v-if="store.facebook"
                :href="store.facebook"
                target="_blank"
              >
                <img
                  class="w-4 h-4"
                  :src="require('assets/images/facebook.svg')"
                  alt="facebook"
                >
              </a>
              <a
                v-if="store.twitter"
                :href="store.twitter"
                target="_blank"
              >
                <img
                  class="w-4 h-4"
                  :src="require('assets/images/twitter.svg')"
                  alt="twitter"
                >
              </a>
            </div>
          </div>
          <button
            @click="getProducts"
            class="h-full"
          >
            <img
              :src="require('assets/images/shuffle.svg')"
              alt="shuffle-icon"
            >
          </button>
        </div>
        <button
          class="mx-4 text-sm text-gf-purple"
          @click="getProducts"
        >
          Buscar en otra tienda
        </button>
      </div>
      <div class="md:space-x-5 flex justify-between px-3.5 py-1 mt-5 md:mt-6 border-t md:border-t-0">
        <div
          v-for="(product, index) in products"
          :key="index"
          class="flex-col items-center justify-center w-24 text-sm rounded-lg cursor-pointer md:rounded-2xl md:w-20 md:h-14 md:border md:pt-1"
          :class="selectedIndex == index ?
            'bg-gf-emerald text-white font-semibold md:border-gf-emerald' : 'text-gf-gray font-normal'"
          @click="$emit('change-slide', index)"
        >
          <p class="text-center">
            {{ index | toSigns }}
          </p>
          <p class="text-center">
            {{ product.price }}
          </p>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import { mapActions } from 'vuex';

export default {
  props: {
    store: {
      type: Object,
      required: true,
    },
    selectedIndex: {
      type: Number,
      required: true,
    },
    products: {
      type: Array,
      required: true,
    },
  },
  methods: {
    ...mapActions([
      'getProducts',
    ]),
  },
  filters: {
    toSigns(value) {
      return '$'.repeat(value + 1);
    },
  },
};
</script>

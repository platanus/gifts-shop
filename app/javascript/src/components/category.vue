<template>
  <div
    class="flex flex-col m-auto category"
  >
    <div>
      <vueSlickCarousel
        ref="slider"
        class="w-full sm:mt-8"
        :arrows="false"
        :center-mode="true"
        :center-padding="'0'"
        :fade="true"
        :initial-slide="1"
        :slides-to-show="1"
        :swipe-to-slide="true"
        @beforeChange="changeProduct"
      >
        <div
          v-for="(product, index) in category.products"
          :key="index"
          class="flex"
        >
          <product-card
            :product="product"
            v-bind="{ highlight : index === mostClickedIndex }"
            :category="category"
            @change-slide="changeSlide"
            @loaded-image="loadedImage"
          />
        </div>
      </vueSlickCarousel>
    </div>
    <p
      class="mt-5 text-xs tracking-wider text-center text-gray-600 uppercase sm:mt-2"
    >
      Rango de precios:
    </p>
    <div
      class="w-full p-2 mx-auto mt-5 text-center bg-white shadow sm:mt-2 sm:rounded-full sm:w-2/3"
    >
      <p
        class="range"
      >
        <span class="inline-block">
          <span class="inline-block w-6 h-6 border border-gray-500 border-solid rounded-full range__circle">$</span>
          : 5000 - 10000
        </span>
        <span class="inline-block">
          <span class="inline-block w-6 h-6 ml-5 border border-gray-500 border-solid rounded-full range__circle">$$</span>
          : 10000 - 15000
        </span>
        <span class="inline-block">
          <span class="inline-block w-6 h-6 ml-5 border border-gray-500 border-solid rounded-full range__circle">$$$</span>
          : 15000 - 20000
        </span>
      </p>
    </div>
  </div>
</template>

<script>
import VueSlickCarousel from 'vue-slick-carousel';
import 'vue-slick-carousel/dist/vue-slick-carousel.css';

import convertToClp from '../utils/convert-to-clp';

import productCard from './product-card';

export default {
  components: {
    productCard,
    VueSlickCarousel,
  },
  data() {
    return {
      selectedProductIndex: 1,
      products: [],
      mostClickedIndex: 0,
      loadedImages: 0,
    };
  },
  methods: {
    changeProduct(oldSlideIndex, newSlideIndex) {
      this.selectedProductIndex = newSlideIndex;
    },
    changeSlide(index) {
      this.$refs.slider.goTo(index);
    },
    updateMostClickedIndex() {
      const products = this.category.products;

      const mostClickedProduct = products.reduce((p, c) => (p.clicks > c.clicks ? p : c));
      this.mostClickedIndex = products.indexOf(mostClickedProduct);
    },
    loadedImage() {
      this.loadedImages++;
      if (this.loadedImages === this.category.products.length) {
        this.loadedImages = 0;
        this.$emit('loaded-category');
      }
    },
  },
  props: {
    category: {
      type: Object,
      default: null,
    },
    hideFavoriteButton: {
      type: Boolean,
      default: false,
    },
  },
  computed: {
    selectedProduct() {
      return this.category.products[this.selectedProductIndex];
    },
  },
  filters: {
    Price(value) {
      const price = convertToClp(value);

      return `$${price}`;
    },
    toUpper(value) {
      return value.toUpperCase();
    },
  },
  watch: {
    category: {
      deep: true,
      inmediate: true,
      handler: 'updateMostClickedIndex',
    },
  },
};
</script>

<style lang="scss">
  @import '../../styles/variables';

  @keyframes pump {
    50% {
      transform: scale(1);
    }

    55% {
      transform: scale(1.2);
    }

    60% {
      transform: scale(1);
    }

    65% {
      transform: scale(1.2);
    }

    70% {
      transform: scale(1);
    }
  }

  .category {
    width: calc(min(100%, 900px));
  }

  .slick-active {
    z-index: 1;
  }

  .range {
    font-size: .65rem;
    line-height: 1rem;

    &__circle {
      padding-top: .19rem;
    }
  }

</style>

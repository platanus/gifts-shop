<template>
  <div
    class="flex flex-col"
  >
    <store-header
      :store-name="store.name"
      class="md:shadow-gf-header"
      @change-slide="changeSlide"
      :selected-index="selectedProductIndex"
      :products="store.products"
    />
    <div>
      <vueSlickCarousel
        ref="slider"
        class="w-full sm:mt-8"
        :arrows="false"
        :center-mode="true"
        center-padding="0"
        :fade="true"
        :initial-slide="1"
        :slides-to-show="1"
        :swipe-to-slide="true"
        @beforeChange="changeProduct"
      >
        <div
          v-for="(product, index) in store.products"
          :key="index"
          class="flex"
        >
          <product-card
            :product="product"
            v-bind="{ highlight : index === mostClickedIndex }"
            :store="store"
            @change-slide="changeSlide"
            @loaded-image="loadedImage"
          />
        </div>
      </vueSlickCarousel>
    </div>
  </div>
</template>

<script>
import VueSlickCarousel from 'vue-slick-carousel';
import 'vue-slick-carousel/dist/vue-slick-carousel.css';

import convertToClp from '../utils/convert-to-clp';

import productCard from './product-card';
import storeHeader from './store-header';

export default {
  components: {
    productCard,
    VueSlickCarousel,
    storeHeader,
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
      const products = this.store.products;

      const mostClickedProduct = products.reduce((p, c) => (p.clicks > c.clicks ? p : c));
      this.mostClickedIndex = products.indexOf(mostClickedProduct);
    },
    loadedImage() {
      this.loadedImages++;
      if (this.loadedImages === this.store.products.length) {
        this.loadedImages = 0;
        this.$emit('loaded-store');
      }
    },
  },
  props: {
    store: {
      type: Object,
      default: null,
    },
  },
  computed: {
    selectedProduct() {
      return this.store.products[this.selectedProductIndex];
    },
    priceIntervals() {
      // eslint-disable-next-line no-undef
      return process.env.PRICE_INTERVAL_LIMITS.split(',');
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
    store: {
      deep: true,
      inmediate: true,
      handler: 'updateMostClickedIndex',
    },
  },
};
</script>

<style lang="scss">
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

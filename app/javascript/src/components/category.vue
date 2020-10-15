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
        :center-padding="0"
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
            v-bind="{ highlight : index === 1 }"
            :category="category"
            @change-slide="changeSlide"
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

export default {
  components: {
    productCard,
    VueSlickCarousel,
  },
  data() {
    return {
      selectedProductIndex: 1,
      products: [],
    };
  },
  methods: {
    changeProduct(oldSlideIndex, newSlideIndex) {
      this.selectedProductIndex = newSlideIndex;
    },
    changeSlide(index) {
      this.$refs.slider.goTo(index);
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
</style>

<template>
  <div
    class="flex flex-col m-auto category"
  >
    <div
      class="relative"
    >
      <div
        v-if="!hideFavoriteButton"
        class="product-card__icon-container"
        @click="setLikeStatus"
      >
        <img
          v-if="isLiked"
          class="product-card__icon product-card__icon--active"
          src="../assets/like-color-badge.svg"
        >
        <img
          v-else
          class="product-card__icon"
          src="../assets/like-badge.svg"
        >
      </div>
      <img
        class="flex object-cover w-full h-56"
        :src="selectedProduct.imageUrl"
      >
      <div
        class="absolute top-0 block w-full h-full selected-product__gradient"
      >
        <p
          class="absolute bottom-0 px-3 py-2 text-xl font-bold text-white"
        >
          {{ selectedProduct.name }}
        </p>
      </div>
    </div>
    <div>
      <vueSlickCarousel
        class="mt-3"
        :arrows="false"
        :center-mode="true"
        :center-padding="0"
        :focus-on-select="true"
        :initial-slide="1"
        :slides-to-show="3"
        :swipe-to-slide="true"
        @beforeChange="changeProduct"
      >
        <div
          v-for="(product, index) in category.products"
          :key="index"
          class="flex category__product"
          :class="{'category__product--selected': index === selectedProductIndex }"
        >
          <product-card
            :product="product"
            v-bind="{ highlight : index === 1 }"
          />
        </div>
      </vueSlickCarousel>
    </div>
  </div>
</template>

<script>
import { mapActions, mapState } from 'vuex';

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
    ...mapActions([
      'markClicked',
    ]),
    clickAction() {
      this.markClicked(this.selectedProduct.id);
      window.open(this.selectedProduct.link, '_blank');
    },
    changeProduct(oldSlideIndex, newSlideIndex) {
      this.selectedProductIndex = newSlideIndex;
    },
    setLikeStatus() {
      if (this.isLiked) {
        this.$store.commit('removeFavoriteCategory', this.category.id);
      } else {
        this.$store.commit('addFavoriteCategory', this.category);
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
    ...mapState([
      'favoriteCategories',
    ]),
    isLiked() {
      return this.category.id in this.favoriteCategories;
    },
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
    width: calc(min(100%, 700px));

    &__product {
      flex-basis: calc(33%);

      &:hover {
        cursor: pointer;
        filter: brightness(90%);
      }

      &--selected {
        border-color: $primary-color;
        filter: brightness(90%);
      }
    }

    &__product-selector {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      max-width: 300px;
      margin: auto;
    }
  }

  .product-card {
    display: flex;
    flex-direction: column;
    height: 100%;
    position: relative;
    margin: auto;
    font-size: 1.2em;
    color: $product-name-font-color;
    border: 1px solid rgba(148, 148, 148, .16);
    box-shadow: 0 2px 6px rgba(148, 148, 148, .24);
    border-radius: 6px;
    background-color: #fff;

    &__icon {
      width: 80%;
      height: 80%;
      margin: .17em;
      cursor: pointer;

      &--active {
        animation: pump 6s;
        animation-iteration-count: infinite;
      }
    }

    &__icon-container {
      position: absolute;
      top: 8px;
      right: 8px;
      height: 1.5em;
      width: 1.5em;
      border-radius: 50%;
      padding: .1em;
      background-color: #fff;
      box-shadow: 0 4px 6px 0 rgba(43, 43, 43, .13);
      z-index: 10;
      display: flex;
      justify-content: center;

      &:hover {
        cursor: pointer;
      }
    }
  }

  .selected-product {
    &__gradient {
      background: linear-gradient(to bottom, rgba(0, 0, 0, 0) 0%, rgba(0, 0, 0, 0) 61%, rgba(0, 0, 0, .45) 100%);
    }
  }

  .slick {
    &-slide {
      opacity: .65;
      transform: scale(.9);
      transition: transform .2s ease-in-out, opacity .2s ease-in-out;
    }

    &-current {
      opacity: 1;
      transform: scale(1);
    }
  }
</style>

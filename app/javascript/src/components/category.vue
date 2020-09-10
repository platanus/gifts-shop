<template>
  <div
    class="category"
  >
    <div
      class="category__main-product"
    >
      <div class="product-card">
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
        <product-image
          :product="selectedProduct"
          @click.native="clickAction"
        />
        <div class="choose-option-text">
          Elige tu opción
        </div>
        <div
          class="category__product-selector"
        >
          <div
            v-for="(product, index) in category.products"
            :key="index"
            class="category__product"
            :class="{'category__product--selected': index === selectedProductIndex }"
            @click="changeProduct(index)"
          >
            <product-image :product="product" />
          </div>
        </div>
        <div class="product-card__information">
          <div class="product-card__bottom-row-container">
            <span class="product-card__price"> {{ selectedProduct.price | Price }} </span>
          </div>
          <div
            class="product-card__title"
            @click="clickAction"
          >
            {{ selectedProduct.name }}
          </div>
          <div class="product-card__store-name">
            <div class="product-card__store-name-text">
              {{ selectedProduct.storeName | toUpper }}
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions, mapState } from 'vuex';
import convertToClp from '../utils/convert-to-clp';

import productImage from './product-image';

export default {
  components: {
    productImage,
  },
  data() {
    return {
      selectedProductIndex: 0,
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
    changeProduct(index) {
      this.selectedProductIndex = index;
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
    display: flex;
    flex-direction: column;
    width: calc(min(90%, 700px));
    margin: auto;

    &__product {
      display: flex;
      flex-basis: calc(33% - 1em);
      border-color: #000;
      border-style: dashed;
      border-width: 1px;
      margin: 0 .25em;

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

  .choose-option-text {
    margin: 1em auto .5em;
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
      z-index: 20;
      display: flex;
      justify-content: center;

      &:hover {
        cursor: pointer;
      }
    }

    &__information {
      padding: 8px 12px;
    }

    &__title {
      font-size: .8em;
      margin: 8px auto;
      overflow: hidden;
      text-overflow: ellipsis;
      display: -webkit-box; //stylelint-disable value-no-vendor-prefix
      line-height: 1.2em;
      max-height: 2.5em;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical; //stylelint-disable property-no-vendor-prefix
      cursor: pointer;
    }

    &__store-name {
      height: 24px;
    }

    &__store-name-text {
      opacity: .48;
      letter-spacing: .05em;
      font-size: .7em;
      font-weight: 600;
      padding-top: 4px;
      position: absolute;
      bottom: .4em;
      padding-bottom: 6px;
    }

    &__price {
      flex: 1;
      height: fit-content;
      font-size: 1em;
      letter-spacing: .05em;
      font-weight: 600;
    }

    &:hover {
      .category-product {
        &__title {
          text-decoration: underline;
        }
      }
    }
  }
</style>

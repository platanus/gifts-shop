<template>
  <div
    class="category"
  >
    <div
      class="category__main-product"
    >
      <div class="product-card">
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
            <product-image :product="product"/>
          </div>
        </div>
        <div class="home-product__information">
          <div class="home-product__bottom-row-container">
            <span class="home-product__price"> {{ selectedProduct.price | Price }} </span>
          </div>
          <div
            class="home-product__title"
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
import { mapActions } from 'vuex';
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
    }
  },
  methods: {
    ...mapActions([
      'markClicked',
    ]),
    clickAction() {
      this.markClicked(this.selectedProduct.id);
      window.open(this.selectedProduct.link, '_blank');
    },
    changeProduct: function(index) {
      this.selectedProductIndex = index;
    }
  },
  props: {
    category: {
      type: Object,
      default: null,
    },
  },
  computed: {
    selectedProduct() {
      return this.category.products[this.selectedProductIndex];
    }
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
}
</script>

<style lang="scss">
  @import '../../styles/variables';

  .category {
    display: flex;
    flex-direction: column;
    width: calc(min(90%, 700px));
    margin: auto;

    &__product {
      display: flex;
      flex-basis: calc(33% - 1em);
      border-color: black;
      border-style: dashed;
      border-width: 1px;
      margin: 0 0.25em;

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
    margin: 1em auto 0.5em auto;
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

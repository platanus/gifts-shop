<template>
  <div class="home-product-container">
    <div class="home-product">
      <div class="home-product__image-wrapper">
        <img
          class="home-product__image"
          :src="product.imageUrl"
        >
      </div>
      <div class="home-product__title">
        {{ product.name }}
      </div>
      <div class="home-product__store-name">
        {{ product.storeName | toUpper }}
      </div>
      <div class="home-product__bottom-row-container">
        <span class="home-product__price"> {{ product.price | Price }} </span>
        <img
          class="home-product__icon"
          src="../assets/heart-outlined.svg"
        >
      </div>
    </div>
  </div>
</template>

<script>
import convertToClp from '../utils/convert-to-clp';

export default {
  props: {
    product: {
      type: Object,
      default: null,
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

  .home-product-container {
    display: flex;
    justify-content: center;
    flex: 0 0 20%;
  }

  .home-product {
    display: flex;
    flex-direction: column;
    width: 200px;
    font-size: 1.2em;
    padding: 40px 0;
    color: $product-name-font-color;

    &__image-wrapper {
      display: flex;
      justify-content: center;
      height: 200px;
    }

    &__bottom-row-container {
      display: flex;
      align-items: center;
      padding: .8em 0;
    }

    &__image {
      max-width: 100%;
      max-height: 100%;
      border-radius: 10px;
      object-fit: contain;
    }

    &__icon {
      width: 1.7em;
    }

    &__title {
      overflow-wrap: break-word;
      padding: .9em 0;
      height: 2.5em;
    }

    &__store-name {
      opacity: .48;
      letter-spacing: .05em;
      font-size: .9em;
      font-weight: 600;
    }

    &__price {
      flex: 1;
      height: 20px;
      font-size: 1.3em;
      letter-spacing: .05em;
      font-weight: 600;
    }
  }
</style>

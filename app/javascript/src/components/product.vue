<template>
  <div
    class="home-product-container"
  >
    <div class="home-product">
      <div
        class="home-product__image-wrapper"
        @click="openNewTab"
      >
        <img
          class="home-product__image"
          :src="product.imageUrl"
        >
      </div>
      <div class="home-product__bottom-row-container">
        <span class="home-product__price"> {{ product.price | Price }} </span>
        <div
          @click="setLikeStatus"
        >
          <img
            v-if="liked"
            class="home-product__icon"
            src="../assets/heart-filled.svg"
          >
          <img
            v-else
            class="home-product__icon"
            src="../assets/heart-outlined.svg"
          >
        </div>
      </div>
      <div
        class="home-product__title"
        @click="openNewTab"
      >
        {{ product.name }}
      </div>
      <div class="home-product__store-name">
        {{ product.storeName | toUpper }}
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex';
import convertToClp from '../utils/convert-to-clp';

export default {
  data() {
    return {
      liked: false,
    };
  },
  props: {
    product: {
      type: Object,
      default: null,
    },
  },
  methods: {
    ...mapActions([
      'markLiked',
      'markDisplayed',
    ]),
    setLikeStatus() {
      if (this.liked) {
        this.liked = false;
      } else {
        this.liked = true;
        this.markLiked(this.product.id);
      }
    },
    openNewTab() {
      window.open(this.product.link, '_blank');
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
  mounted() {
    this.markDisplayed(this.product.id);
  },
};
</script>

<style lang="scss">
  @import '../../styles/variables';

  .home-product {
    display: flex;
    flex-direction: column;
    height: 100%;
    position: relative;
    margin: auto;
    font-size: 1.2em;
    color: $product-name-font-color;
    width: $m-size-image;

    @media (min-width: $p-break) {
        width: $p-size-image;
    }

    @media (min-width: $t-break) {
      width: $t-size-image;
    }

    @media (min-width: $d-break) {
      width: $d-size-image;
    }

    @media (min-width: $r-break) {
      width: $r-size-image;
    }

    &__image-wrapper {
      display: flex;
      justify-content: center;
      width: $m-size-image;
      height: $m-size-image;
      cursor: pointer;

      @media (min-width: $p-break) {
        height: $p-size-image;
        width: $p-size-image;
      }

      @media (min-width: $t-break) {
        height: $t-size-image;
        width: $t-size-image;
      }

      @media (min-width: $d-break) {
        height: $d-size-image;
        width: $d-size-image;
      }

      @media (min-width: $r-break) {
        height: $r-size-image;
        width: $r-size-image;
      }
    }

    &__bottom-row-container {
      display: flex;
      align-items: center;
      padding: .5em 0 0 0;
    }

    &__image {
      max-width: 100%;
      max-height: 100%;
      object-fit: contain;
    }

    &__icon {
      width: 1.3em;
      cursor: pointer;
    }

    &__title {
      padding: 0 0 1em 0;
      height: fit-content;
      cursor: pointer;
    }

    &__store-name {
      opacity: .48;
      letter-spacing: .05em;
      font-size: .7em;
      font-weight: 600;
      position: absolute;
      bottom: 0;
    }

    &__price {
      flex: 1;
      height: fit-content;
      font-size: 1em;
      letter-spacing: .05em;
      font-weight: 600;
    }
  }
</style>

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
      <div
        class="home-product__title"
        @click="openNewTab"
      >
        {{ product.name }}
      </div>
      <div class="home-product__store-name">
        {{ product.storeName | toUpper }}
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
    margin: auto;
    font-size: 1.2em;
    color: $product-name-font-color;

    &__image-wrapper {
      display: flex;
      justify-content: center;
      width: 100%;
      height: 100vw;
      cursor: pointer;

      @media (min-width: $break-tablet) {
        height: 40vw;
      }

      @media (min-width: $break-desktop) {
        height: 30vw;
      }
    }

    &__bottom-row-container {
      display: flex;
      align-items: center;
      padding: .5em 0;
    }

    &__image {
      max-width: 100%;
      max-height: 100%;
      object-fit: contain;
    }

    &__icon {
      width: 1.7em;
      cursor: pointer;
    }

    &__title {
      overflow-wrap: break-word;
      padding: .5em 0;
      cursor: pointer;
    }

    &__store-name {
      opacity: .48;
      letter-spacing: .05em;
      font-size: .7em;
      font-weight: 600;
    }

    &__price {
      flex: 1;
      height: 20px;
      font-size: 1em;
      letter-spacing: .05em;
      font-weight: 600;
    }
  }
</style>

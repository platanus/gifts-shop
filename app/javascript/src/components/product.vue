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
        <div 
          @click="setLikeStatus" 
        >
          <img
            v-if="liked"
            class="home-product__icon"
            :src="heartFilled"
          >
          <img
            v-else
            class="home-product__icon"
            :src="heartOutlined"
          >
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import convertToClp from '../utils/convert-to-clp';

export default {
  data() {
    return {
      liked: false,
      heartFilled: "/packs/media/src/assets/heart-filled-bf0c782fd35f9d63ac1a07f730aad400.svg",
      heartOutlined: "/packs/media/src/assets/heart-outlined-6a8e3c8eb2ebab409cd726c91cf14777.svg",
    };
  },
  props: {
    product: {
      type: Object,
      default: null,
    },
  },
  methods: {
    setLikeStatus() {
      if (this.liked) {
        this.liked = false;
        console.log("primer if");
      } else {
        this.liked = true;
        console.log("segundo")
      }
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
    this.$store.dispatch('markDisplayed', this.product.id);
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
      cursor: pointer;
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

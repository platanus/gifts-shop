<template>
  <div
    class="home-product-container"
  >
    <div class="home-product">
      <div
        class="home-product__icon-container"
        @click="setLikeStatus"
      >
        <img
          v-if="liked"
          class="home-product__icon"
          src="../assets/like-color-badge.svg"
        >
        <img
          v-else
          class="home-product__icon"
          src="../assets/like-badge.svg"
        >
      </div>
      <div
        class="home-product__image-wrapper"
        @click="clickAction"
      >
        <div
          class="image-container"
          :style="{ 'background': product.averageColor }"
        >
          <img
            class="home-product__image"
            :src="product.imageUrl"
          >
        </div>
      </div>
      <div class="home-product__information">
        <div class="home-product__bottom-row-container">
          <span class="home-product__price"> {{ product.price | Price }} </span>
        </div>
        <div
          class="home-product__title"
          @click="clickAction"
        >
          {{ product.name }}
        </div>
        <div class="store-info-container">
          <div
            class="star-container"
            v-if="product.promoted"
          >
            <img
              src="../assets/pro-store.svg"
              class="star-image"
            >
          </div>
          <div class="name-container">
            <div class="home-product__store-name">
              {{ product.storeName | toUpper }}
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
      'unmarkLiked',
      'markDisplayed',
      'markClicked',
    ]),
    setLikeStatus() {
      if (this.liked) {
        this.liked = false;
        this.unmarkLiked(this.product.id);
      } else {
        this.liked = true;
        this.markLiked(this.product.id);
      }
    },
    clickAction() {
      this.markClicked(this.product.id);
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
    border: 1px solid rgba(148, 148, 148, .16);
    border-radius: 4px;
    background-color: #fff;

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

    &__information {
      padding: 8px 12px;
      height: 100%;
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

      &:hover {
        cursor: pointer;
      }
    }

    &__image-wrapper {
      display: flex;
      justify-content: center;
      width: $m-size-image;
      height: $m-size-image;
      border-radius: 4px 4px 0 0;
      cursor: pointer;

      .image-container {
        border-radius: 4px 4px 0 0;
        width: 100%;
        height: 100%;
      }

      @media (min-width: $p-break) {
        height: $p-size-image;
        width: $p-size-image;

        .image-container {
          height: $p-size-image;
          width: $p-size-image;
        }
      }

      @media (min-width: $t-break) {
        height: $t-size-image;
        width: $t-size-image;

        .image-container {
          height: $t-size-image;
          width: $t-size-image;
        }
      }

      @media (min-width: $d-break) {
        height: $d-size-image;
        width: $d-size-image;

        .image-container {
          height: $d-size-image;
          width: $d-size-image;
        }
      }

      @media (min-width: $r-break) {
        height: $r-size-image;
        width: $r-size-image;

        .image-container {
          height: $r-size-image;
          width: $r-size-image;
        }
      }
    }

    &__bottom-row-container {
      display: flex;
      align-items: center;
    }

    &__image {
      width: 100%;
      height: 100%;
      border-radius: 4px 4px 0 0;
      object-fit: cover;
    }

    &__icon {
      height: 1.2em;
      width: .9em;
      margin: .1em .3em;
      cursor: pointer;
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
      .home-product {
        &__title {
          text-decoration: underline;
        }

        &__image {
          opacity: .9;
        }
      }
    }
  }

  .store-info-container {
    display: flex;
  }

  .star-container {
    height: 24px;
    width: 24px;
    opacity: .7;
  }

  .name-container {
    height: 24px;
  }

  .star-image {
    position: absolute;
    bottom: .4em;
  }
</style>

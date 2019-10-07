<template>
  <div class="home-container">
    <div
      class="home-header"
      :class="{ 'home-header--shadow': !onTop }"
    >
      <div class="home-header__content">
        <homeTitle
          :likes="likes"
          :on-top="onTop"
        />
        <div class="home-header__options">
          <price-filter
            v-if="visiblePriceFilter"
          />
          <div class="home-header__button-options">
            <img
              class="home-header__icon home-header__icon--option"
              src="../assets/close-badge.svg"
              @click="clearCookies"
            >
            <img
              class="home-header__icon home-header__icon--option home-header__icon--just-mobile"
              src="../assets/filter.svg"
              @click="showPriceFilter"
            >
            <img
              class="home-header__icon home-header__icon--option"
              src="../assets/gift-badge.svg"
            >
          </div>
        </div>
      </div>
    </div>
    <div class="home-products-container">
      <product
        v-for="(product, index) in products"
        :key="index"
        :product="product"
        :on-like="likeProduct"
      />
    </div>
    <div class="loader-spinner">
      <clip-loader
        :loading="this.$store.loading"
      />
    </div>
  </div>
</template>

<script>
import ClipLoader from 'vue-spinner/src/ClipLoader.vue';
import { mapState } from 'vuex';
import product from '../components/product';
import HomeTitle from '../components/home-title';
import PriceFilter from '../components/price-filter';

const SCROLL_OFFSET = 30;
const MOBILE_WIDTH = 650;

export default {
  name: 'HomeView',
  data() {
    return {
      minPrice: 1000,
      maxPrice: 50000,
      likes: 0,
      onTop: true,
      visiblePriceFilter: window.innerWidth > MOBILE_WIDTH,
    };
  },
  components: {
    product,
    ClipLoader,
    HomeTitle,
    PriceFilter,
  },
  computed: {
    ...mapState([
      'products',
    ]),
  },
  methods: {
    scroll() {
      window.onscroll = () => {
        const bottomOfWindow = document.documentElement.scrollTop + window.innerHeight >=
          document.getElementById('home').offsetHeight - SCROLL_OFFSET;
        this.onTop = document.documentElement.scrollTop < SCROLL_OFFSET;
        if (bottomOfWindow && !this.$store.loading) {
          this.$store.loading = true;
          this.$store.dispatch('moreProducts').then(() => {
            this.$store.loading = false;
          }, () => {});
        }
      };
    },
    setOnResize() {
      window.onresize = () => {
        this.visiblePriceFilter = window.innerWidth > MOBILE_WIDTH;
      };
    },
    likeProduct(liked) {
      this.likes += liked ? 1 : -1;
    },
    showPriceFilter() {
      this.visiblePriceFilter = !this.visiblePriceFilter;
    },
    clearCookies() {
      this.$cookies.keys().forEach(
        cookie => this.$cookies.remove(cookie)
      );
      window.location.reload();
    },
  },
  created() {
    this.$store.dispatch('getReceiverName', this.$cookies.get('receiver_id'));
  },
  mounted() {
    this.$store.dispatch('getProducts');
    this.scroll();
    this.setOnResize();
  },
};
</script>

<style lang="scss">
  @import '../../styles/variables';

  .home-container {
    display: block;
    font-size: $m-font-size;
    width: 100%;
  }

  .home-header {
    position: sticky;
    top: 0;
    background-color: #fff;
    transition: background-color 400ms linear;
    padding: 2vh 0;
    z-index: 100;
    align-items: center;

    &--shadow {
      box-shadow: 0 0 4px;
      background-color: #16a69e;
    }

    &__content {
      margin: 0 auto;
      width: $m-width-grid;
      align-items: center;
    }

    &__title {
      padding: .15em 1em 0 .15em;
      display: flex;
      color: $title-font-color;
    }

    &__user-name {
      border-bottom: 2px solid currentColor;
      color: $user-name-font-color;
    }

    &__options {
      display: flex;
      align-items: center;
    }

    &__icon {
      align-self: flex-end;
      flex: 1;
      width: .45em;
      height: .45em;

      &--just-mobile {
        display: block;

        @media (min-width: $p-break) {
          display: none;
        }
      }

      &--option {
        width: 1em;
        height: 1em;
        filter: drop-shadow(2px 2px 2px $icon-shadow-color);

        &:hover {
          cursor: pointer;
        }
      }
    }

    &__button-options {
      position: absolute;
      top: 0;
      right: .5em;
      flex-direction: column;
      display: flex;

      .home-header__icon {
        width: 1.8em;
        height: 1.8em;
        margin-top: .5em;
        background-color: #fff;
        border-radius: 50%;
      }
    }
  }

  .home-products-container {
    justify-content: flex-start;
    width: $m-width-grid;
    margin: 3vh auto;
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax($m-size-image, 1fr));
    grid-column-gap: $m-grid-column-gap;
    grid-row-gap: 40px;
  }

  .loader-spinner {
    display: flex;
    justify-content: center;
    height: 42px;
    margin-top: 25px;
  }

  @media (min-width: $p-break) {
    .home-container {
      font-size: $p-font-size;

      .home-header__content {
        width: $p-width-grid;
        display: flex;
        justify-content: space-between;
      }

      .home-products-container {
        grid-template-columns: repeat(auto-fill, minmax($p-size-image, 1fr));
        grid-column-gap: $p-grid-column-gap;
        width: $p-width-grid;
        padding: 0;
      }
    }
  }

  @media (min-width: $t-break) {
    .home-container {
      font-size: $t-font-size;

      .home-header__content {
        width: $t-width-grid;
      }

      .home-products-container {
        grid-template-columns: repeat(auto-fill, minmax($t-size-image, 1fr));
        grid-column-gap: $t-grid-column-gap;
        width: $t-width-grid;
      }
    }
  }

  @media (min-width: $d-break) {
    .home-container {
      font-size: $d-font-size;

      .home-header__content {
        width: $d-width-grid;
      }

      .home-products-container {
        grid-template-columns: repeat(auto-fill, minmax($d-size-image, 1fr));
        grid-column-gap: $d-grid-column-gap;
        width: $d-width-grid;
      }
    }
  }

  @media (min-width: $r-break) {
    .home-container {
      font-size: $r-font-size;

      .home-header__content {
        width: $r-width-grid;
      }

      .home-products-container {
        grid-template-columns: repeat(auto-fill, minmax($r-size-image, 1fr));
        grid-column-gap: $r-grid-column-gap;
        width: $r-width-grid;
      }
    }
  }

</style>

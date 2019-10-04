<template>
  <div class="home-container">
    <div
      class="home-header"
      v-bind:class="{ 'home-header--shadow': !onTop }"
    >
      <homeTitle
        :likes="likes"
        :on-top="onTop"
      />
      <div class="home-header__options">
        <div class="home-header__price-filter">
          <input
            class="home-header__price-input"
            v-model="minPrice"
            placeholder="precio mínimo"
          >
          <span>
            -
          </span>
          <input
            class="home-header__price-input"
            v-model="maxPrice"
            placeholder="precio máximo"
          >
          <button
            @click="submitPriceFilter"
          >
            Filtrar
          </button>
        </div>
        <div class="home-header__options">
          <img
            class="home-header__icon"
            src="../assets/gift-badge.svg"
          >
          <img
            class="home-header__icon home-header__icon--clear"
            src="../assets/close-badge.svg"
            @click="clearCookies"
          >
        </div>
      </div>
    </div>
    <div class="home-products-container">
      <product
        v-for="(product, index) in products"
        :key="index"
        :product="product"
        :onLike="likeProduct"
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

const SCROLL_OFFSET = 30;

export default {
  name: 'HomeView',
  data() {
    return {
      minPrice: 1000,
      maxPrice: 50000,
      likes: 0,
      onTop: true,
    };
  },
  components: {
    product,
    ClipLoader,
    HomeTitle,
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
    likeProduct(liked) {
      this.likes += liked ? 1 : -1;
    },
    clearCookies() {
      this.$cookies.keys().forEach(
        cookie => this.$cookies.remove(cookie)
      );
      window.location.reload();
    },
    submitPriceFilter() {
      this.$store.dispatch('applyPriceFilter', [this.minPrice, this.maxPrice]);
    },
  },
  created() {
    this.$store.dispatch('getReceiverName', this.$cookies.get('receiver_id'));
  },
  mounted() {
    this.$store.dispatch('getProducts');
    this.scroll();
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
    display: flex;
    position: sticky;
    top: 0;
    background-color: #fff;
    transition: background-color 400ms linear;
    z-index: 100;
    width: 100%;
    padding: 3vh calc((100% - $m-width-grid) / 2);
    align-items: center;
    font-size: 1em;

    &--shadow {
      box-shadow: 0 0 4px;
      background-color: #16A69E;
    }

    &__content {
      margin: 0 auto;
      width: $m-width-grid;
      align-items: center;
      font-size: 2.5em;
    }

    &__title {
      padding: .15em 0;
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

    &__price-filter {
      display: flex;
      align-items: flex-end;
      justify-content: space-evenly;
      font-size: .5em;
    }

    &__price-input {
      border-radius: .5em;
      padding: 0 5px;
      width: 30%;
    }

    &__icon {
      max-width: 1em;

      &--clear {
        max-width: 1em;
        filter: drop-shadow( 2px 2px 2px $icon-shadow-color);
        position: absolute;
        top: 1em;
        right: 1em;

        &:hover {
          cursor: pointer;
        }
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
    grid-row-gap: 20px;
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
        display: flex;
        justify-content: space-between;
      }

      .home-products-container {
        grid-template-columns: repeat(auto-fill, minmax($t-size-image, 1fr));
        grid-column-gap: $t-grid-column-gap;
        width: $t-width-grid;
        padding: 0;
      }
    }
  }

  @media (min-width: $d-break) {
    .home-container {
      font-size: $d-font-size;

      .home-header__content {
        width: $d-width-grid;
        display: flex;
        justify-content: space-between;
      }

      .home-products-container {
        grid-template-columns: repeat(auto-fill, minmax($d-size-image, 1fr));
        grid-column-gap: $d-grid-column-gap;
        width: $d-width-grid;
        padding: 0;
      }
    }
  }

  @media (min-width: $r-break) {
    .home-container {
      font-size: $r-font-size;

      .home-header__content {
        width: $r-width-grid;
        display: flex;
        justify-content: space-between;
      }

      .home-products-container {
        grid-template-columns: repeat(auto-fill, minmax($r-size-image, 1fr));
        grid-column-gap: $r-grid-column-gap;
        width: $r-width-grid;
        padding: 0;
      }
    }
  }

</style>

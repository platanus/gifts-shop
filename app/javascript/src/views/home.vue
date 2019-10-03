<template>
  <div class="home-container">
    <div class="home-title-container">
      <div class="home-title-container__title">
        Mira lo que tenemos para
        <span class="home-title-container__user-name">
          Diego
        </span>
        <img
          class="home-title-container__icon home-title-container__icon--clear"
          src="../assets/close-badge.svg"
          @click="clearCookies"
        >
      </div>
      <div class="home-title-container__options">
        <img
          class="home-title-container__icon"
          src="../assets/heart-outlined.svg"
        >
      </div>
    </div>
    <div class="home-products-container">
      <product
        v-for="product in products"
        :key="product.id"
        :product="product"
      />
      <div class="loader-spinner">
        <pulse-loader
          :loading="this.$store.loading"
        />
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';
import PulseLoader from 'vue-spinner/src/PulseLoader.vue';
import product from '../components/product';

const SCROLL_OFFSET = 30;

export default {
  name: 'HomeView',
  components: {
    product,
    PulseLoader,
  },
  computed: {
    ...mapGetters({
      products: 'productsList',
    }),
  },
  methods: {
    scroll() {
      window.onscroll = () => {
        const bottomOfWindow = document.documentElement.scrollTop + window.innerHeight >=
          document.getElementById('home').offsetHeight - SCROLL_OFFSET;
        if (bottomOfWindow && !this.$store.loading) {
          this.$store.loading = true;
          this.$store.dispatch('moreProducts').then(() => {
            this.$store.loading = false;
          }, () => {});
        }
      };
    },
    clearCookies() {
      this.$cookies.keys().forEach(
        cookie => this.$cookies.remove(cookie)
      );
      window.location.reload();
    },
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
    margin: 0 auto;
    padding: 20px;
    width: $m-width-grid;
  }

  .home-title-container {
    display: flex;
    align-items: center;
    font-size: 2.5em;
    margin-top: 6.5vh;

    &__title {
      padding: .15em 0;
      color: $title-font-color;
    }

    &__user-name {
      border-bottom: 2px solid currentColor;
      color: $user-font-color;
    }

    &__options {
      display: flex;
      flex: 1;
      justify-content: flex-end;
    }

    &__icon {
      align-self: flex-end;
      flex: 1;
      max-width: .45em;

      &--clear {
        max-width: 1em;
        filter: drop-shadow( 2px 2px 2px $icon-shadow-color);

        &:hover {
          cursor: pointer;
        }
      }
    }
  }

  .home-products-container {
    justify-content: flex-start;
    margin-top: 2em;
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax($m-size-image, 1fr));
    grid-column-gap: $m-grid-column-gap;
    grid-row-gap: 20px;
  }

  .loader-spinner {
    margin-left: 50%;
    height: 42px;
  }

  @media (min-width: $p-break) {
    .home-products-container {
      grid-template-columns: repeat(auto-fill, minmax($p-size-image, 1fr));
      grid-column-gap: $p-grid-column-gap;
    }

    .home-container {
      font-size: $p-font-size;
      width: $p-width-grid;
      padding: 0;
    }
  }

  @media (min-width: $t-break) {
    .home-products-container {
      grid-template-columns: repeat(auto-fill, minmax($t-size-image, 1fr));
      grid-column-gap: $t-grid-column-gap;
    }

    .home-container {
      font-size: $t-font-size;
      width: $t-width-grid;
      padding: 0;
    }
  }

  @media (min-width: $d-break) {
    .home-products-container {
      grid-template-columns: repeat(auto-fill, minmax($d-size-image, 1fr));
      grid-column-gap: $d-grid-column-gap;
    }

    .home-container {
      font-size: $d-font-size;
      width: $d-width-grid;
      padding: 0;
    }
  }

  @media (min-width: $r-break) {
    .home-products-container {
      grid-template-columns: repeat(auto-fill, minmax($r-size-image, 1fr));
      grid-column-gap: $r-grid-column-gap;
    }

    .home-container {
      font-size: $r-font-size;
      width: $r-width-grid;
      padding: 0;
    }
  }

</style>

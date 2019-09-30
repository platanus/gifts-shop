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
        <div class="home-title-container__price-filter">
          <input
            class="home-title-container__price-input"
            v-model="minPrice"
            placeholder="precio mínimo"
          >
          <span>
            -
          </span>
          <input
            class="home-title-container__price-input"
            v-model="maxPrice"
            placeholder="precio máximo"
          >
          <button
            @click="submitPriceFilter"
          >
            Filtrar
          </button>
        </div>
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
  data() {
    return {
      minPrice: 1000,
      maxPrice: 50000,
    };
  },
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
    submitPriceFilter() {
      this.$store.dispatch('applyPriceFilter', [this.minPrice, this.maxPrice]);
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
  }

  .home-title-container {
    display: flex;
    align-items: center;
    font-size: 3.5em;
    margin-top: 6.5vh;

    &__title {
      padding: .15em 0;
      color: $title-font-color;
      flex: 1;
    }

    &__user-name {
      border-bottom: 2px solid currentColor;
      color: $user-font-color;
    }

    &__options {
      display: flex;
      flex: .6;
      height: .75em;
      justify-content: flex-end;
    }

    &__price-filter {
      display: flex;
      align-items: flex-end;
      justify-content: space-evenly;
      flex: .8;
      font-size: .5em;
    }

    &__price-input {
      border-radius: .5em;
      padding: 0 5px;
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
    display: flex;
    flex-flow: wrap;
    justify-content: flex-start;
    width: 1200px;
  }

  .loader-spinner {
    margin-left: 50%;
    height: 42px;
  }

</style>

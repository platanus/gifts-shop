<template>
  <div class="home-container">
    <div class="home-title-container">
      <div class="home-title-container__title">
        Mira lo que tenemos para
        <span class="home-title-container__user-name">
          Diego
        </span>
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
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';
import product from '../components/product';

export default {
  name: 'HomeView',
  components: {
    product,
  },
  computed: {
    ...mapGetters({
      products: 'productsArray',
    }),
  },
  mounted() {
    this.$store.dispatch('getProducts');
    this.scroll();
  },
  methods: {
    scroll() {
      window.onscroll = () => {
        const bottomOfWindow = document.documentElement.scrollTop + window.innerHeight ===
          document.getElementById('home').offsetHeight;
        if (bottomOfWindow) {
          this.$store.dispatch('moreProducts');
        }
      };
    },
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
    }
  }

  .home-products-container {
    display: flex;
    flex-flow: wrap;
    justify-content: flex-start;
    width: 1200px;
  }
</style>

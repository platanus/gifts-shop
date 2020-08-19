<template>
  <div class="home-container">
    <home-header />
    <div
      class="home-products-container"
      v-if="products.length > 0"
    >
      <product
        v-for="(product, index) in products"
        :key="index"
        :product="product"
      />
    </div>
    <div
      class="loader-spinner"
      v-if="this.$store.loading"
    >
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
import HomeHeader from '../components/home-header';

const SCROLL_OFFSET = 30;

export default {
  name: 'HomeView',
  components: {
    product,
    ClipLoader,
    HomeHeader,
  },
  computed: {
    ...mapState([
      'products',
      'likes',
      'feedbackActive',
    ]),
  },
  mounted() {
    this.$store.dispatch('getProducts');
  },
};
</script>

<style lang="scss">
  @import '../../styles/variables';

  .home-container {
    display: block;
    font-size: $m-font-size;
    width: 100%;
    background: $home-background;
  }

  .home-products-container {
    justify-content: flex-start;
    width: $m-width-grid;
    margin: 3vh auto;
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

      .home-products-container {
        width: $p-width-grid;
        padding: 0;
      }
    }
  }

  @media (min-width: $t-break) {
    .home-container {
      font-size: $t-font-size;

      .home-products-container {
        width: $t-width-grid;
      }
    }
  }

  @media (min-width: $d-break) {
    .home-container {
      font-size: $d-font-size;

      .home-products-container {
        width: $d-width-grid;
      }
    }
  }

  @media (min-width: $r-break) {
    .home-container {
      font-size: $r-font-size;

      .home-products-container {
        width: $r-width-grid;
      }
    }
  }

</style>

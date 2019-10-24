<template>
  <div class="home-container">
    <home-header
      :likes="likes"
      :on-top="onTop"
    />
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
import HomeHeader from '../components/home-header';

const SCROLL_OFFSET = 30;

export default {
  name: 'HomeView',
  data() {
    return {
      likes: 0,
      onTop: true,
    };
  },
  components: {
    product,
    ClipLoader,
    HomeHeader,
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

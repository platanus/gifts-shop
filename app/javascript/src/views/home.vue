<template>
  <div class="home-container">
    <home-header />
    <div v-if="category">
      <div class="py-4 bg-secondary">
        <p class="flex justify-center text-white">
          Encontramos:&nbsp; <span class="font-bold">{{ category.name }}</span>
        </p>
        <p class="flex justify-center text-sm text-white">
          {{ category.description }}
        </p>
      </div>
      <category
        :category="category"
        v-if="category"
      />
      <div class="flex flex-col w-48 pt-10 mx-auto text-gray-700 align-items-center">
        <p class="pb-3 text-center">
          No te convence?🤔
        </p>
        <button
          class="px-1 py-2 text-sm font-bold text-white rounded-sm bg-primary"
          @click="$store.dispatch('getProducts')"
        >
          SIGAMOS BUSCANDO
        </button>
      </div>
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
import category from '../components/category';
import HomeHeader from '../components/home-header';

export default {
  name: 'HomeView',
  components: {
    category,
    ClipLoader,
    HomeHeader,
  },
  computed: {
    ...mapState([
      'products',
      'category',
      'likes',
    ]),
  },
  mounted() {
    this.$store.commit('setNextPage', 0);
    this.$store.dispatch('getProducts').then(() => {
      this.$store.loading = false;
    });
  },
};
</script>

<style lang="scss">
  @import '../../styles/variables';

  .call-text {
    display: flex;
    justify-content: center;

    &__category-name {
      color: $primary-color;
    }
  }

  .button-container {
    display: flex;
    justify-content: center;
  }

  .change-option-button {
    text-align: center;
    background-color: $primary_color;
    text-decoration: none;
    -webkit-appearance: none;
    height: 2.5em;
    padding: 5px;
    color: $white;
    font-size: 15px;
    margin-bottom: 3%;
    border: 0;
    border-radius: 30.5px;

    &:hover {
      cursor: pointer;
    }
  }

  .home-container {
    display: block;
    font-size: $m-font-size;
    width: 100%;
    background: $home-background;
    min-height: 100vh;
  }

  .home-products-container {
    justify-content: flex-start;
    width: $m-width-grid;
    margin: 3vh auto;
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax($m-size-image, 1fr));
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

      .home-products-container {
        grid-template-columns: repeat(auto-fill, minmax($p-size-image, 1fr));
        width: $p-width-grid;
        padding: 0;
      }
    }
  }

  @media (min-width: $t-break) {
    .home-container {
      font-size: $t-font-size;

      .home-products-container {
        grid-template-columns: repeat(auto-fill, minmax($t-size-image, 1fr));
        width: $t-width-grid;
      }
    }
  }

  @media (min-width: $d-break) {
    .home-container {
      font-size: $d-font-size;

      .home-products-container {
        grid-template-columns: repeat(auto-fill, minmax($d-size-image, 1fr));
        width: $d-width-grid;
      }
    }
  }

  @media (min-width: $r-break) {
    .home-container {
      font-size: $r-font-size;

      .home-products-container {
        grid-template-columns: repeat(auto-fill, minmax($r-size-image, 1fr));
        width: $r-width-grid;
      }
    }
  }

</style>

<template>
  <div class="home-container">
    <home-header />
    <modal
      :show-modal="modalIsOpen"
      @accept="removeProduct"
      @close="closeModal"
    >
      <template #body>
        ¿De verdad quieres borrar este producto de tus favoritos?
      </template>
      <template #accept-button-text>
        ¡Sí!
      </template>
      <template #cancel-button-text>
        Mejor no
      </template>
    </modal>
    <div class="favorite-products">
      <div v-if="Object.keys(favoriteProducts).length === 0">
        No tienes ningún producto favorito 😢
      </div>
      <div
        v-for="(product, index) in favoriteProducts"
        :key="index"
      >
        <div
          class="favorite-product"
          :class="{'favorite-product-container--last': index === favoriteProducts.length - 1}"
        >
          <div class="favorite-product__image-name-container">
            <div class="favorite-product__image-container">
              <img
                class="favorite-product__image"
                :src="product.imageUrl"
              >
            </div>
            <div>
              <div>{{ product.name | toUpper }}</div>
              <div class="favorite-product__price">
                ${{ product.price }}
              </div>
            </div>
          </div>
          <div class="favorite-product__buttons-container">
            <button
              v-if="openCategory !== index"
              @click="openCategory = index"
              class="favorite-product__button favorite-product__button--left"
            >
              Ver categoría
            </button>
            <button
              v-else
              @click="openCategory = -1"
              class="favorite-product__button favorite-product__button--left"
            >
              Ocultar
            </button>
            <button
              class="favorite-product__button favorite-product__button--red favorite-product__button--right"
              @click="openModal(product.id)"
            >
              Sacar de favoritos
            </button>
          </div>
        </div>
        <div class="favorite-product__preview">
          <div
            class="favorite-product__preview-card"
            :class="{'favorite-product__preview-card--expanded': openCategory === index}"
          >
            <category
              :category="category"
              :hide-favorite-button="true"
            />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex';
import category from '../components/category';
import HomeHeader from '../components/home-header';
import modal from '../components/modal';

export default {
  name: 'Favorites',
  data() {
    return {
      openCategory: -1,
      modalProduct: -1,
      modalIsOpen: false,
    };
  },
  components: {
    category,
    HomeHeader,
    modal,
  },
  computed: {
    ...mapState([
      'favoriteProducts',
    ]),
  },
  filters: {
    toUpper(value) {
      return value.charAt(0).toUpperCase() + value.slice(1);
    },
  },
  methods: {
    closeModal() {
      this.modalIsOpen = false;
    },
    openModal(productIndex) {
      this.modalProduct = productIndex;
      this.modalIsOpen = true;
    },
    removeProduct() {
      this.modalIsOpen = false;
      this.$store.commit('removeFavoriteProduct', this.modalProduct);
    },
  },
};
</script>

<style lang="scss" scoped>
  @import '../../styles/variables';

  .favorite-products {
    width: calc(min(90%, 700px));
    display: flex;
    flex-direction: column;
    padding: 30px;
    margin: 10px auto;
    font-size: 1.2em;
    color: $product-name-font-color;
    border: 1px solid rgba(148, 148, 148, .16);
    box-shadow: 0 2px 6px rgba(148, 148, 148, .24);
    border-radius: 6px;
    background-color: #fff;
    padding-bottom: 40px;
  }

  .favorite-product {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    width: 100%;

    @media(max-width: 640px) {
      flex-direction: column;
    }

    &__image-name-container {
      display: flex;
      align-items: center;

      @media(max-width: 640px) {
        margin-bottom: 10px;
      }
    }

    &__buttons-container {
      display: flex;
      flex-direction: column;
      justify-content: center;

      @media(max-width: 640px) {
        flex-direction: row;
      }
    }

    &__image-container {
      display: flex;
      justify-content: center;
      width: 150px;
      height: 150px;
      margin-right: 20px;
    }

    &__image {
      object-fit: scale-down;
      max-height: 100%;
      max-width: 100%;
    }

    &__price {
      color: #949494;
      font-size: .8em;
    }

    &__button {
      text-align: center;
      background-color: $primary_color;
      text-decoration: none;
      padding: 5px;
      color: $white;
      font-size: 15px;
      margin-bottom: 3%;
      border: 0;

      &:hover {
        cursor: pointer;
      }

      &--red {
        background-color: $danger_color;
      }

      @media(max-width: 640px) {
        &--left {
          margin-right: 10px;
        }

        &--right {
          margin-left: 10px;
        }
      }
    }

    &__preview {
      overflow: hidden;
    }

    &__preview-card {
      display: flex;
      justify-content: center;
      margin-top: -200%;
      transition: all 1s;

      &--expanded {
        margin-top: 0;
      }
    }
  }
</style>

<template>
  <div
    class="flex flex-col w-auto mx-auto bg-white border border-gray-100 border-solid rounded-md shadow-md sm:w-full sm:flex-row product"
  >
    <div
      class="relative w-full h-56 product__image sm:h-auto"
    >
      <div
        class="absolute left-0 mt-4"
        :class="{ 'hidden' : !highlight }"
      >
        <div class="w-auto px-3 pt-1 pb-2 text-white bg-red-700 rounded-r">
          <span class="hidden text-xs font-bold sm:inline">🔥 Top Choice</span>
          <span class="inline text-xs font-bold sm:hidden">🔥 TOP</span>
        </div>
      </div>
      <img
        class="object-cover w-full h-full cursor-pointer gtm"
        :src="product.imageUrl"
        @load="$emit('loaded-image')"
        @click="clickAction"
      >
      <div class="sm:hidden">
        <div class="absolute top-0 block w-full h-full opacity-50 bg-gradient-to-b from-transparent via-transparent to-black" />
        <p
          class="absolute bottom-0 block mx-3 mb-2 text-xl font-bold text-white cursor-pointer gtm"
          @click="clickAction"
        >
          {{ product.name }}
        </p>
      </div>
    </div>
    <div
      class="relative flex flex-col w-full h-full px-3 mt-1 sm:mt-3 sm:h-auto product__info"
    >
      <div class="w-full text-center sm:text-left product__description">
        <span
          class="hidden text-xl font-bold cursor-pointer sm:block gtm"
          @click="clickAction"
        >
          {{ product.name }}
        </span>
        <p class="my-2 text-sm text-justify sm:mt-3 sm:mr-0 sm:text-base">
          {{ product.description }}
        </p>
        <p class="my-2 text-sm text-justify sm:mt-3 sm:mr-0 sm:text-base">
          RECUERDALO!
        </p>
        <button
          class="px-2 py-1 text-sm border border-gray-700 border-solid rounded-sm gtm"
          @click="openModal"
        >
          <img
            :src="require('assets/images/mail.svg')"
            class="w-6"
          >
        </button>
        <button
          class="px-2 py-1 text-sm border border-gray-700 border-solid rounded-sm gtm"
          @click="whatsappShare"
        >
          <img
            :src="require('assets/images/whatsapp.svg')"
            class="w-6"
          >
        </button>
      </div>
      <div class="mt-5 text-center sm:mt-0 sm:w-full sm:text-left">
        <p class="pb-2 text-sm font-bold tracking-wider uppercase">
          Escoge tu opción:
        </p>
        <div class="flex flex-row justify-center sm:justify-start">
          <div
            class="inline"
            v-for="(storeProduct, index) in store.products"
            :key="index"
          >
            <button
              class="w-12 h-12 mx-1 text-gray-600 border border-gray-400 border-solid rounded-full shadow gtm sm:mr-2 sm:ml-0"
              :class="{'border-primary' : storeProduct === product }"
              @click="$emit('change-slide', index)"
            >
              <span
                class="inline text-base font-bold text-center outline-none"
                :class="{'text-black' : storeProduct === product }"
              >
                {{ storeProduct.priceInterval | toSigns }}
              </span>
            </button>
          </div>
        </div>
        <div class="flex flex-col w-full mt-5 mb-3 text-xs sm:mb-0 sm:flex-row">
          <button
            class="w-full px-3 py-3 mb-2 font-bold text-white rounded-l-sm gtm sm:mb-0 sm:mr-1 sm:w-1/2 bg-primary place-self-center"
            @click="clickAction"
          >
            <span class="text-center">🎁 QUIERO VER ESTE REGALO</span>
          </button>
          <button
            class="w-full px-3 py-3 font-bold text-white rounded-r-sm gtm sm:w-1/2 bg-secondary place-self-center"
            @click="getAnotherstore"
          >
            <span class="text-center">🔎 SIGAMOS BUSCANDO</span>
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions, mapMutations } from 'vuex';
import convertToClp from '../utils/convert-to-clp';

const CLICKS_BEFORE_NOTIFICATION = 10;

export default {
  data() {
    return {
      whatsappNumber: process.env.PHONE_NUMBER,
    };
  },
  methods: {
    ...mapActions([
      'markClicked',
    ]),
    ...mapMutations([
      'setLoading',
      'toggleEmailModal',
      'setSharedProduct',
    ]),
    clickAction() {
      this.markClicked(this.product.id);
      window.open(this.product.referenceUrl, '_blank');
    },
    whatsappShare() {
      window.open(this.whatsappShareLink, '_blank');
    },
    openModal() {
      this.setSharedProduct(this.product);
      this.toggleEmailModal();
    },
    getAnotherstore() {
      this.$store.commit('addIdeasSearched');
      this.setLoading(true);
      this.$store.dispatch('getProducts');
      if (this.$store.state.ideasSearched === CLICKS_BEFORE_NOTIFICATION) {
        this.$notify({
          title: '¿ Aún no encuentras el regalo que buscas ?',
          message: 'No te preocupes ! tenemos una alternativa para ti',
          clickableMessage: 'queleregalo.cl →',
          clickableMessageLink: 'http://queleregalo.cl',
        });
      }
      window.scrollTo({
        top: 0,
        behavior: 'smooth',
      });
    },
  },
  props: {
    product: {
      type: Object,
      default: null,
    },
    highlight: {
      type: Boolean,
      default: false,
    },
    store: {
      type: Object,
      default: null,
    },
  },
  computed: {
    whatsappShareLink() {
      return `http://wa.me/${this.whatsappNumber}/?text=${this.whatsappShareText}`;
    },
    whatsappShareText() {
      return encodeURI(`Buenas Ideas | Adquiere tu ${this.product.name} visitando: ${this.product.referenceUrl}`);
    },
  },
  filters: {
    Price(value) {
      const price = convertToClp(value);

      return `$${price}`;
    },
    toSigns(value) {
      return '$'.repeat(value + 1);
    },
  },
};
</script>
<style lang="scss">
  @media (min-width: 640px) { // sm-breakpoint
    .product {
      height: 24rem;

      &__image {
        width: 45%;
      }

      &__info {
        width: 55%;
      }

      &__description {
        height: 13rem;
      }
    }
  }
</style>

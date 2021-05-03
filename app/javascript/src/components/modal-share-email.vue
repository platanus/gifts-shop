<template>
  <div
    class="fixed top-0 left-0 flex items-center justify-center w-full h-full transition-all duration-300 ease-in-out"
    :class="{ 'opacity-0': !showModal, 'opacity-100': showModal, 'closed-modal': !showModal, 'z-30': showModal }"
  >
    <div
      @click="closeModal"
      class="absolute w-full h-full bg-gray-900 opacity-50"
    />
    <div class="z-30 w-11/12 mx-auto overflow-y-auto bg-white rounded shadow-lg md:max-w-md">
      <div class="px-6 py-4 text-left">
        <div class="flex items-center justify-between pb-3">
          <div class="text-4xl font-bold">
            <h3>
              Ingresa tu correo para compartir este regalo!
            </h3>
          </div>
          <div
            @click="closeModal"
            class="cursor-pointer"
          >
            <img
              :src="require('assets/images/cross.svg')"
              alt="close-modal-cross"
            >
          </div>
        </div>

        <input
          v-model="email"
          placeholder="example@platan.us"
          type="email"
          class="px-2 py-2 h-10 leading-normal block w-full text-gray-800 bg-white font-sans rounded-lg text-left border border-black focus:border-blue-500"
        >
        <label
          class="block mt-2 text-xs tracking-wide text-center text-red-700 uppercase"
          v-if="emailError"
        >
          Correo inválido
        </label>
        <div class="flex justify-end pt-2">
          <button
            @click="productShareByEmail(sharedProduct)"
            type="button"
            class="w-full px-3 py-3 mb-2 font-bold text-white rounded-l-sm gtm sm:mb-0 bg-primary sm:mr-1 sm:w-1/2 place-self-center"
            v-if="!emailError"
          >
            ENVIAR
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
  .closed-modal {
    z-index: -1;
  }
</style>

<script>
import { mapState, mapMutations } from 'vuex';
import productsApi from '../api/products';
import validateEmail from '../utils/validate-email';

export default {
  data() {
    return {
      email: '',
      emailSubmitted: false,
    };
  },
  props: {
    showModal: {
      type: Boolean,
      required: true,
    },
  },
  methods: {
    ...mapMutations([
      'toggleEmailModal',
      'setUserEmail',
    ]),
    productShareByEmail(product) {
      this.setUserEmail(this.email);
      this.emailSubmitted = true;
      if (!this.emailError) {
        productsApi.shareByEmail(product.id, this.userEmail, product.referenceUrl);
        this.toggleEmailModal();
      }
    },
    closeModal() {
      this.toggleEmailModal();
      this.emailSubmitted = false;
    },
  },
  computed: {
    ...mapState([
      'sharedProduct',
      'userEmail',
    ]),
    emailError() {
      return this.emailSubmitted && !validateEmail(this.email);
    },
  },
};
</script>

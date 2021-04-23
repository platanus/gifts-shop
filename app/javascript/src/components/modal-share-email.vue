<template>
  <div
    class="fixed top-0 left-0 flex items-center justify-center w-full h-full transition-all duration-300 ease-in-out"
    :class="{ 'opacity-0': !showModal, 'opacity-100': showModal, 'closed-modal': !showModal, 'z-30': showModal }"
  >
    <div
      @click="close"
      class="absolute w-full h-full bg-gray-900 opacity-50"
    />
    <div class="z-30 w-11/12 mx-auto overflow-y-auto bg-white rounded shadow-lg md:max-w-md">
      <div class="px-6 py-4 text-left">
        <div class="flex items-center justify-between pb-3">
          <div class="text-4xl font-bold">
            <h3>
              <slot name="title" />
            </h3>
          </div>
          <div
            @click="close"
            class="cursor-pointer"
          >
            <img
              :src="require('assets/images/cross.svg')"
              alt="close-modal-cross"
            >
          </div>
        </div>

        <slot name="body" />

        <div class="flex justify-end pt-2">
          <button
            @click="accept"
            class="w-full px-3 py-3 mb-2 font-bold text-white rounded-l-sm gtm sm:mb-0 sm:mr-1 sm:w-1/2 bg-primary place-self-center"
          >
            <slot name="accept-button-text" />
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
export default {
  props: {
    showModal: {
      type: Boolean,
      required: true,
    },
  },
  methods: {
    accept() {
      this.$emit('accept');
    },
    close() {
      this.$emit('close');
    },
  },
};
</script>

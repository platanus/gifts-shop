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
          <p class="text-2xl font-bold">
            <slot name="title" />
          </p>
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
            class="p-3 px-4 mr-2 text-teal-500 bg-transparent rounded-lg hover:bg-gray-100 hover:text-teal-400"
          >
            <slot name="accept-button-text" />
          </button>
          <button
            @click="close"
            class="p-3 px-4 mr-2 text-teal-500 bg-transparent rounded-lg hover:bg-gray-100 hover:text-teal-400"
          >
            <slot name="cancel-button-text" />
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

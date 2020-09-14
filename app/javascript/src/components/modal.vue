<template>
  <div class="fixed w-full h-full top-0 left-0 flex items-center z-30 justify-center">
    <div
      @click="close"
      class="absolute w-full h-full bg-gray-900 opacity-50"
    />
    <div class="bg-white w-11/12 md:max-w-md mx-auto rounded shadow-lg z-30 overflow-y-auto">
      <div class="py-4 text-left px-6">
        <div class="flex justify-between items-center pb-3">
          <p class="text-2xl font-bold">
            <slot name="title" />
          </p>
          <div
            @click="close"
            class="cursor-pointer"
          >
            <img
              src="../assets/cross.svg"
              alt="close-modal-cross"
            >
          </div>
        </div>

        <slot name="body" />

        <div class="flex justify-end pt-2">
          <button
            @click="accept"
            class="px-4 bg-transparent p-3 rounded-lg text-teal-500 hover:bg-gray-100 hover:text-teal-400 mr-2"
          >
            <slot name="accept-button-text" />
          </button>
          <button
            @click="close"
            class="px-4 bg-transparent p-3 rounded-lg text-teal-500 hover:bg-gray-100 hover:text-teal-400 mr-2"
          >
            <slot name="cancel-button-text" />
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
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

<template>
  <div class="product-image__image-wrapper">
    <div
      class="product-image__image-container"
      :style="{ 'background': product.averageColor }"
    >
      <transition
        name="fade"
      >
        <img
          class="product-image__image"
          :src="product.imageUrl"
          @load="loaded = true;"
          v-show="loaded"
        >
      </transition>
    </div>
  </div>
</template>

<style scoped lang="scss">
  .product-image {
    &__image-wrapper {
      display: flex;
      margin: auto;
      cursor: pointer;
    }

    &__image {
      height: 100%;
      width: 100%;

      &:hover {
        opacity: 0.9;
      }
    }
  }
</style>

<script>
export default {
  data() {
    return {
      loaded: false,
    };
  },
  props: {
    product: {
      type: Object,
      default: null,
    },
  },
  methods: {
    clickAction: function() {},
  },
}
</script>
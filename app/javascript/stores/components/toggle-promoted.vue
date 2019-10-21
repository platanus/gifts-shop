<template>
  <div
    class="promoted-icon-container"
    @click="setPromoted"
  >
    <img
      v-if="state"
      class="promoted-icon__image"
      src="../assets/star_full.svg"
    >
    <img
      v-else
      class="promoted-icon__image"
      src="../assets/star_border.svg"
    >
  </div>
</template>

<script>
import catalogApi from '../api/catalog';

export default {
  props: {
    value: {
      type: Boolean, required: true,
    },
    productId: {
      type: String, required: true,
    },
  },
  data() {
    return {
      state: false,
    };
  },
  mounted() {
    this.togglePromoted(this.value);
  },
  methods: {
    setPromoted() {
      this.togglePromoted(!this.state);
      catalogApi.setPromoted(this.productId);
    },
    togglePromoted(state) {
      this.state = state;
    },
  },
};

</script>

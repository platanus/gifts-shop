<template>
  <div class="price-filter">
    <input
      class="price-filter__input"
      v-model="minPrice"
      placeholder="precio mínimo"
    >
    <span>
      -
    </span>
    <input
      class="price-filter__input"
      v-model="maxPrice"
      placeholder="precio máximo"
    >
    <button
      @click="submitPriceFilter"
    >
      Filtrar
    </button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      minPrice: 1000,
      maxPrice: 50000,
    };
  },
  methods: {
    submitPriceFilter() {
      this.$store.dispatch('applyPriceFilter', [this.minPrice, this.maxPrice]);
    },
  },
};
</script>

<style lang="scss">
  @import '../../styles/variables';

  .price-filter {
    display: flex;
    align-items: flex-end;
    justify-content: space-evenly;
    flex: .8;
    font-size: .5em;

    &__input {
      border-radius: .5em;
      padding: 0 5px;
    }
  }
</style>

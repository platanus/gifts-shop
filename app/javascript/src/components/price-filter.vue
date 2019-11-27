<template>
  <div class="price-filter">
    <div class="price-filter__form">
      <img
        class="price-filter__icon"
        src="../assets/currency-blue.svg"
      >
      <input
        class="price-filter__input"
        :class="{ 'price-filter__input--error': error }"
        v-model="minPrice"
        placeholder="precio mínimo"
      >
      a
      <input
        class="price-filter__input"
        :class="{ 'price-filter__input--error': error }"
        v-model="maxPrice"
        placeholder="precio máximo"
      >
    </div>
    <div
      class="price-filter__error"
      v-if="error"
    >
      El precio mínimo debe ser menor al precio máximo
    </div>
    <button
      class="price-filter__button"
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
      minPrice: this.$store.state.minPrice,
      maxPrice: this.$store.state.maxPrice,
      error: false,
    };
  },
  props: {
    mobile: {
      type: Boolean,
      default: false,
    },
  },
  methods: {
    submitPriceFilter() {
      if (parseInt(this.minPrice, 10) > parseInt(this.maxPrice, 10)) {
        this.error = true;
      } else {
        this.$store.dispatch('applyPriceFilter', [this.minPrice, this.maxPrice]);
        this.error = false;
        this.$emit('filtered');
      }
    },
  },
};
</script>

<style lang="scss">
  @import '../../styles/variables';

  .price-filter {
    color: $c-filter-foreground;
    background-color: $c-header-background-transparent;
    box-sizing: border-box;
    margin: auto;
    font-size: .8em;
    display: flex;
    position: absolute;
    z-index: 105;
    width: 100%;
    top: 3em;
    padding: 1.8em;

    &__form {
      display: flex;
      width: 100%;
      align-items: center;
      justify-content: center;
      background-color: $c-filter-background;
      border: 1px solid $c-header-highlight;
      border-radius: 6px 0 0 6px;
      padding: 6px 8px;
    }

    &__error {
      color: $danger-color;
      font-size: .8em;
      text-align: center;
    }

    &__input {
      text-align: center;
      background: transparent;
      color: $c-filter-foreground;
      border: 0;
      font-size: 1em;
      width: 4em;

      &--error {
        border-color: $danger-border-color;
      }
    }

    &__button {
      font-size: 1em;
      border: 1px solid $c-header-highlight;
      border-radius: 0 6px 6px 0;
      background-color: $c-header-highlight;
      color: $white;
      padding: 0 1em;
      width: 50%;

      &:hover {
        background-color: darken($color: $c-header-highlight, $amount: 5%);
      }
    }

    @media (min-width: $p-break) {
      right: 3em;
      top: 0;
      width: fit-content;
      padding: 1.5em 0 2em 21em;
    }

    @media (min-width: $t-break) {
      position: initial;
      padding: 0;
    }
  }
</style>

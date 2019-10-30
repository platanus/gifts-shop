<template>
  <div class="price-filter">
    <div class="price-filter__form">
      <img
        class="price-filter__icon"
        src="../assets/currency.svg"
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
      minPrice: 1000,
      maxPrice: 50000,
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
      }
    },
  },
};
</script>

<style lang="scss">
  @import '../../styles/variables';

  .price-filter {
    width: fit-content;
    color: $c-header-foreground;
    background-color: rgba(67, 225, 198, .02);
    box-sizing: border-box;
    margin: auto;
    font-size: .8em;
    display: flex;

    &__form {
      display: flex;
      width: fit-content;
      margin: auto;
      align-items: center;
      justify-content: center;
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
      color: $c-header-foreground;
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

      &:hover {
        background-color: darken($color: $c-header-highlight, $amount: 5%);
      }
    }
  }
</style>

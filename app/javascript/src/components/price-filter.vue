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
        @keyup.enter="submitPriceFilter"
      >
      a
      <input
        class="price-filter__input"
        :class="{ 'price-filter__input--error': error }"
        v-model="maxPrice"
        placeholder="precio máximo"
        @keyup.enter="submitPriceFilter"
      >
    </div>
    <div
      class="price-filter__error"
      v-if="error"
    >
      El precio mínimo debe ser menor al precio máximo
    </div>
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
    color: $label-color;
    border: 1px solid $label-color;
    border-radius: 6px;
    background-color: rgba(67, 225, 198, .02);
    box-sizing: border-box;
    margin: auto;
    padding: 6px 8px;
    font-size: .8em;

    &__form {
      display: flex;
      align-items: center;
      justify-content: center;
    }

    &__error {
      color: $danger-color;
      font-size: .8em;
      text-align: center;
    }

    &__input {
      text-align: center;
      background: transparent;
      color: $label-color;
      border: 0;
      font-size: 1em;
      width: 4em;

      &--error {
        border-color: $danger-border-color;
      }
    }

    &__button {
      height: fit-content;
      padding: 10px 15px;
      max-width: 40%;
      min-width: fit-content;
      border-radius: 8px;
      font-size: .7em;
      line-height: .7em;
      margin-left: 10px;
      background-color: $primary-color;
      color: $white;
      font-weight: bold;
      letter-spacing: .4px;
      text-align: center;
      text-decoration: none;
      text-transform: uppercase;
      border: 0;

      &:hover {
        background-color: darken($color: $primary-color, $amount: 5%);
      }
    }
  }
</style>

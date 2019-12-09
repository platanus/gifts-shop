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
        class="price-filter__input price-filter__input--last"
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
      error: false,
    };
  },
  props: {
    mobile: {
      type: Boolean,
      default: false,
    },
  },
  computed: {
    minPrice: {
      get() {
        return this.$store.state.minPrice;
      },
      set(value) {
        this.$store.commit('setMinPrice', value);
      },
    },
    maxPrice: {
      get() {
        return this.$store.state.maxPrice;
      },
      set(value) {
        this.$store.commit('setMaxPrice', value);
      },
    },
  },
  methods: {
    submitPriceFilter() {
      if (parseInt(this.minPrice, 10) > parseInt(this.maxPrice, 10)) {
        this.error = true;
      } else {
        this.$store.dispatch('applyPriceFilter');
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
    box-sizing: border-box;
    margin: auto;
    font-size: .8em;
    display: flex;
    position: absolute;
    z-index: 105;
    width: 100%;
    border-radius: 8px;
    justify-content: flex-end;
    top: -22px;

    &__form {
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 6px 0 0 6px;
    }

    &__error {
      position: absolute;
      bottom: -.8em;
      color: $c-filter-background;
      font-size: .8em;
      text-align: center;
    }

    &__input {
      text-align: start;
      background: transparent;
      color: #000;
      border: 0;
      border-bottom: solid 1px $label-color;
      font-size: 1em;
      width: 3em;
      margin-right: 4px;

      &--last {
        margin-left: 4px;
      }

      &--error {
        border-color: $danger-border-color;
      }
    }

    &__button {
      font-size: 1em;
      border: 1px solid $c-header-highlight;
      border-radius: 6px;
      background-color: $c-header-highlight;
      color: $white;
      padding: 0 1em;

      &:hover {
        background-color: darken($color: $c-header-highlight, $amount: 5%);
      }
    }

    @media (min-width: $p-break) {
      right: -2.5em;
      top: 23px;
      width: fit-content;
    }

    @media (min-width: $t-break) {
      position: initial;
      padding: 0;
    }
  }
</style>

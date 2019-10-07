<template>
  <div class="price-filter">
    $<input
      class="price-filter__input"
      v-model="minPrice"
      placeholder="precio mínimo"
    >
    <span class="price-filter__separator">
      -
    </span>
    $<input
      class="price-filter__input"
      v-model="maxPrice"
      placeholder="precio máximo"
    >
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
    margin-top: 1em;
    align-items: center;
    justify-content: center;
    width: $m-size-filter;
    color: $label-color;

    &__input {
      text-align: left;
      background: transparent;
      font-size: .9em;
      border: 0;
      border-bottom: 2px solid $primary-color;
      height: calc(.9em + 2px);
      margin-bottom: -2px;
      width: 30%;
      border-color: $primary-color;
      color: $label-color;
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

    &__separator {
      margin: 0 10px;
    }
  }

  @media (min-width: $p-break) {
    .price-filter {
      width: $p-size-filter;
      margin-top: 0;
    }
  }

  @media (min-width: $t-break) {
    .price-filter {
      width: $t-size-filter;
    }
  }

  @media (min-width: $d-break) {
    .price-filter {
      width: $d-size-filter;
    }
  }

  @media (min-width: $r-break) {
    .price-filter {
      width: $r-size-filter;
    }
  }
</style>

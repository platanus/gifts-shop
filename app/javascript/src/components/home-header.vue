<template>
  <div
    class="home-header"
    :class="{ 'home-header--shadow': !onTop }"
  >
    <div class="home-header__content">
      <img
        class="home-header__home-icon"
        src="../assets/amigosecreto.png"
      >
      <header-center
        :likes="likes"
        :on-top="onTop"
      />
      <div class="home-header__options">
        <div class="home-header__link">
          <img
            class="home-header__home-icon"
            src="../assets/store.svg"
            @click="goToStore"
          >
        </div>
        <price-filter
          v-if="!mobile"
        />
        <img
          class="home-header__icon home-header__icon--option"
          src="../assets/filter.svg"
          @click="showPriceFilter"
          v-if="mobile"
        >
      </div>
      <div
        class="home-header__mobile-price-filter"
        v-if="visiblePriceFilter"
      >
        <price-filter/>
      </div>
    </div>
  </div>
</template>
<script>
import HeaderCenter from './header-center';
import PriceFilter from './price-filter';

const MOBILE_WIDTH = 650;

export default {
  name: 'HomeHeader',
  data() {
    return {
      mobile: window.innerWidth <= MOBILE_WIDTH,
      visiblePriceFilter: false,
      minPrice: 1000,
      maxPrice: 50000,
    };
  },
  props: {
    likes: {
      type: Number,
      default: 0,
    },
    onTop: {
      type: Boolean,
      default: true,
    },
  },
  components: {
    HeaderCenter,
    PriceFilter,
  },
  methods: {
    showPriceFilter() {
      this.visiblePriceFilter = !this.visiblePriceFilter;
    },
    goToStore() {
      window.location = '/stores/sign_in';
    },
  },
};
</script>

<style lang="scss">
  @import '../../styles/variables';

  .home-header {
    position: sticky;
    top: 0;
    background-color: $c-header-background;
    box-shadow: $box-shadow-header;
    padding: 2vh 0;
    z-index: 100;
    align-items: center;
    border-radius: 0 0 16px 16px;

    &__content {
      margin: 0 auto;
      width: $m-width-grid;
      position: relative;
    }

    &__home-icon {
      height: 2em;
      width: 2em;
    }

    &__options {
      position: absolute;
      display: flex;
      right: 0;
      top: 0;
    }

    &__icon {
      align-self: flex-end;
      flex: 1;
      width: .45em;
      height: .45em;

      &--option {
        width: 1.5em;
        height: 1.5em;
        border-radius: 50%;
        margin-left: 1em;
        box-shadow: 2px 2px 3px $icon-shadow-color;
      }
    }

    &__mobile-price-filter {
      width: 100%;
      padding-top: 1em;
    }
  }

  @media (min-width: $p-break) {
    .home-header {
      border-radius: 0;

      &__content {
        width: $p-width-grid;
        display: flex;
        justify-content: space-between;
      }

      &__home-icon {
        width: 3em;
        height: 3em;
        position: absolute;
        left: 0;
        top: 0;
      }

      &__options {
        display: block;

        .price-filter {
          margin-top: .5em;
        }
      }
    }
  }

  @media (min-width: $t-break) {
    .home-header__content {
      width: $t-width-grid;
    }
  }

  @media (min-width: $d-break) {
    .home-header__content {
      width: $d-width-grid;
    }
  }

  @media (min-width: $r-break) {
    .home-header__content {
      width: $r-width-grid;
    }
  }
</style>

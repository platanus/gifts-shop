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
        <price-filter
          v-if="visiblePriceFilter"
        />
        <div class="home-header__link">
          <img
            class="home-header__home-icon"
            src="../assets/store.svg"
            @click="goToStore"
          >
        </div>
        <img
          class="home-header__icon home-header__icon--option home-header__icon--just-mobile"
          src="../assets/filter.svg"
          @click="showPriceFilter"
        >
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
      visiblePriceFilter: window.innerWidth > MOBILE_WIDTH,
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
    setOnResize() {
      window.onresize = () => {
        this.visiblePriceFilter = window.innerWidth > MOBILE_WIDTH;
      };
    },
    showPriceFilter() {
      this.visiblePriceFilter = !this.visiblePriceFilter;
    },
    goToStore() {
      window.location = '/stores/sign_in';
    },
  },
  mounted() {
    this.setOnResize();
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

    &__content {
      margin: 0 auto;
      width: $m-width-grid;
      display: flex;
      justify-content: space-between;
      align-items: baseline;
    }

    &__link {
      display: flex;
      justify-content: flex-end;
    }

    &__home-icon {
      width: 3em;
      height: 3em;
    }

    &__icon {
      align-self: flex-end;
      flex: 1;
      width: .45em;
      height: .45em;

      &--just-mobile {
        display: block;

        @media (min-width: $p-break) {
          display: none;
        }
      }

      &--option {
        width: 1em;
        height: 1em;
        filter: drop-shadow(2px 2px 2px $icon-shadow-color);

        &:hover {
          cursor: pointer;
        }
      }
    }
  }
</style>

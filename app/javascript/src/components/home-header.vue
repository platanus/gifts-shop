<template>
  <div
    class="home-header"
  >
    <div class="home-header__content">
      <img
        class="home-header__home-icon home-icon"
        src="../assets/buenas-ideas.svg"
      >
      <img
        class="home-header__home-icon home-icon-tablet"
        src="../assets/buenas-ideas-mini.svg"
      >
      <header-center
        :likes="likes"
        :mobile="mobile"
      />
      <div class="home-header__options">
        <img
          class="home-header__icon home-header__icon--first"
          src="../assets/store.svg"
          @click="goToStore"
        >
        <price-filter
          v-if="visiblePriceFilter"
          :mobile="mobile"
          @filtered="togglePriceFilter"
        />
        <img
          class="home-header__icon"
          src="../assets/currency.svg"
          @click="showPriceFilter"
          v-if="!visiblePriceFilter"
        >
        <img
          class="home-header__icon home-header__icon--small"
          src="../assets/close-badge.svg"
          @click="showPriceFilter"
          v-if="visiblePriceFilter"
        >
      </div>
    </div>
  </div>
</template>
<script>
import HeaderCenter from './header-center';
import PriceFilter from './price-filter';

const MOBILE_WIDTH = 650;
const SCROLL_OFFSET = 60;

export default {
  name: 'HomeHeader',
  data() {
    return {
      mobile: window.innerWidth <= MOBILE_WIDTH,
      visiblePriceFilter: false,
    };
  },
  props: {
    likes: {
      type: Number,
      default: 0,
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
    onResize() {
      this.mobile = window.innerWidth <= MOBILE_WIDTH;
    },
  },
  mounted() {
    window.addEventListener('resize', this.onResize);
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.onResize);
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
      height: 3em;
      width: 100%;
    }

    &__options {
      position: absolute;
      width: 100%;
      right: 0;
      top: 0;
    }

    &__icon {
      flex: 1;
      position: absolute;
      right: 0;
      top: .7em;
      width: 1.3em;
      height: 1.3em;

      &--small {
        width: .8em;
        height: .8em;
      }

      &--first {
        left: 0;
        margin-right: 1em;
      }

      &:hover {
        cursor: pointer;
      }
    }
  }

  .home-icon-tablet {
    display: none;
  }

  .home-icon {
    display: initial;
  }

  @media (min-width: $p-break) {
    .home-header {
      &__content {
        width: $p-width-grid;
        display: flex;
        justify-content: space-between;
      }

      &__home-icon {
        height: 4em;
        width: auto;
        position: absolute;
        left: 0;
        top: 0;
      }

      &__icon {
        position: initial;
        margin-left: .5em;

        &--first {
          margin-right: 3em;
        }
      }

      &__options {
        height: 100%;
        display: flex;
        align-items: center;
        width: fit-content;
      }
    }

    .home-icon-tablet {
      display: initial;
    }

    .home-icon {
      display: none;
    }
  }

  @media (min-width: $t-break) {
    .home-header__content {
      width: $t-width-grid;
    }

    .home-icon-tablet {
      display: none;
    }

    .home-icon {
      display: initial;
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

<template>
  <div
    class="home-header"
  >
    <div class="store-elements-container">
      <img
        class="home-header__icon home-header__icon--first"
        src="../assets/store.svg"
        @click="goToStore"
      >
      <div
        class="home-header__store-text"
        @click="goToStore"
      >
        Tiendas
      </div>
    </div>
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
        <PriceFilter
          :mobile="mobile"
          @filtered="togglePriceFilter"
        />
      </div>
    </div>
  </div>
</template>
<script>
import HeaderCenter from './header-center';
import PriceFilter from './price-filter';

const MOBILE_WIDTH = 650;
const TABLET_WIDTH = 1000;
const SCROLL_OFFSET = 60;

export default {
  name: 'HomeHeader',
  data() {
    const desktop = window.innerWidth > TABLET_WIDTH;
    return {
      mobile: window.innerWidth <= MOBILE_WIDTH,
      desktop,
      visiblePriceFilter: desktop,
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
    togglePriceFilter() {
      this.visiblePriceFilter = !this.visiblePriceFilter;
    },
    goToStore() {
      window.location = '/stores/sign_in';
    },
    onResize() {
      this.mobile = window.innerWidth <= MOBILE_WIDTH;
      this.desktop = window.innerWidth > TABLET_WIDTH;
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

    &__store-text {
      font-size: .9em;
      align-self: center;
      color: $label-color;

      &:hover {
        cursor: pointer;
        text-decoration: underline;
      }
    }

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
      right: 0;
      top: .7em;
      height: 1.3em;
      color: $c-header-foreground;

      &--small {
        width: .8em;
        height: .8em;
      }

      &--first {
        left: 0;
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

  .store-elements-container {
    display: flex;
    width: 20px;
    margin-left: 15px;
  }

</style>

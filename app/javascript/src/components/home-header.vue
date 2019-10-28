<template>
  <div
    class="home-header"
    :class="{ 'home-header--shadow': !onTop }"
  >
    <div class="home-header__content">
      <img
        class="home-header__home-icon"
        src="../assets/buenas-ideas.svg"
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
          v-if="visiblePriceFilter && !mobile"
          :mobile="false"
        />
        <img
          class="home-header__icon"
          src="../assets/currency.svg"
          @click="showPriceFilter"
        >
      </div>
      <div
        class="home-header__mobile-price-filter"
        :class="{ 'home-header__mobile-price-filter--zero-height': !visiblePriceFilter }"
        v-if="mobile"
      >
        <price-filter
          :mobile="true"
        />
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
      lastScrollTop: 0,
      scrollingDown: false,
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
      this.lastScrollTop = document.documentElement.scrollTop;
    },
    goToStore() {
      window.location = '/stores/sign_in';
    },
    onWindowScroll() {
      const curr = document.documentElement.scrollTop;
      if (curr - this.lastScrollTop > SCROLL_OFFSET) {
        this.visiblePriceFilter = false;
        this.lastScrollTop = curr;
      } else if (this.lastScrollTop - curr > SCROLL_OFFSET) {
        if (this.visiblePriceFilter) this.visiblePriceFilter = true;
        this.lastScrollTop = curr;
      }
    },
  },
  mounted() {
    window.addEventListener('scroll', () => this.onWindowScroll());
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
      margin-left: -.5em;
    }

    &__options {
      position: absolute;
      display: flex;
      right: 0;
      top: .5em;
    }

    &__icon {
      flex: 1;
      margin-left: .5em;
      width: 1.3em;
      height: 1.3em;

      &--first {
        margin-right: 1em;
      }

      &:hover {
        cursor: pointer;
      }
    }

    &__mobile-price-filter {
      width: 100%;
      margin-top: 1em;
      height: 3em;
      transition: all .3s;
      overflow: hidden;

      &--zero-height {
        height: 0;
        margin: 0;
      }
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
        height: 4em;
        position: absolute;
        left: 0;
        top: 0;
      }

      &__icon {
        &--first {
          margin-right: 3em;
        }
      }

      &__options {
        height: 100%;
        align-items: center;

        .price-filter {
          margin-right: 1em;
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

<template>
  <div
    class="home-header"
    :class="{ 'home-header--shadow': !onTop }"
  >
    <div class="home-header__link">
      <a
        href="/stores/sign_in"
        class="login-link"
      >
        ¿Tienes una tienda?
      </a>
    </div>
    <div class="home-header__content">
      <homeTitle
        :likes="likes"
        :on-top="onTop"
      />
      <div class="home-header__options">
        <price-filter
          v-if="visiblePriceFilter"
        />
        <div class="home-header__button-options">
          <img
            class="home-header__icon home-header__icon--option"
            src="../assets/close-badge.svg"
            @click="clearCookies"
          >
          <img
            class="home-header__icon home-header__icon--option home-header__icon--just-mobile"
            src="../assets/filter.svg"
            @click="showPriceFilter"
          >
          <img
            class="home-header__icon home-header__icon--option"
            src="../assets/gift-badge.svg"
          >
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import HomeTitle from './home-title';
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
    HomeTitle,
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
    clearCookies() {
      this.$store.dispatch('deleteSessionReceiver');
    },
  },
  created() {
    this.$store.dispatch('getReceiverName');
  },
  mounted() {
    this.setOnResize();
  },
};
</script>

<style lang="scss">
  @import '../../styles/variables';

  .login-link {
    color: $primary-color;
    text-decoration: none;
    margin-right: 50px;

    &:visited {
      color: $primary-color;
    }

    &:hover {
      text-decoration: underline;
    }
  }

  .home-header {
    position: sticky;
    top: 0;
    background-color: #fff;
    transition: background-color 400ms linear;
    padding: 2vh 0;
    z-index: 100;
    align-items: center;

    &--shadow {
      box-shadow: 0 0 4px;
      background-color: #dbe8ff;
    }

    &__content {
      margin: 0 auto;
      width: $m-width-grid;
      align-items: baseline;
    }

    &__title {
      padding: .15em 1em 0 .15em;
      display: flex;
      color: $title-font-color;
    }

    &__user-name {
      border-bottom: 2px solid currentColor;
      color: $user-name-font-color;
    }

    &__options {
      display: flex;
      align-items: center;
    }

    &__link {
      display: flex;
      justify-content: flex-end;
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

    &__button-options {
      position: absolute;
      top: 0;
      right: .5em;
      flex-direction: column;
      display: flex;

      .home-header__icon {
        width: 1.8em;
        height: 1.8em;
        margin-top: .5em;
        background-color: #fff;
        border-radius: 50%;
      }
    }
  }
</style>

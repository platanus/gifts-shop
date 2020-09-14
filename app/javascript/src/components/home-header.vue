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
        Vende tus productos
      </div>
    </div>
    <div class="home-header__content">
      <router-link to="/">
        <img
          class="home-header__home-icon home-icon"
          src="../assets/buenas-ideas.svg"
        >
        <img
          class="home-header__home-icon home-icon-tablet"
          src="../assets/buenas-ideas-mini.svg"
        >
      </router-link>
    </div>
    <div class="home-header__button-container">
      <router-link to="/favorites">
        <button class="home-header__button">
          Ver mis favoritas
        </button>
      </router-link>
    </div>
  </div>
</template>
<script>
const MOBILE_WIDTH = 650;
const TABLET_WIDTH = 1000;

export default {
  name: 'HomeHeader',
  data() {
    const desktop = window.innerWidth > TABLET_WIDTH;

    return {
      mobile: window.innerWidth <= MOBILE_WIDTH,
      desktop,
    };
  },
  methods: {
    goToStore() {
      window.location = '/stores/catalog/new';
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
    z-index: 20;
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

    &__button-container {
      position: absolute;
      right: 15px;
      top: 15px;
    }

    &__button {
      text-align: center;
      background-color: $primary_color;
      text-decoration: none;
      height: 2.5em;
      padding: 5px;
      color: $white;
      font-size: 15px;
      margin-bottom: 3%;
      border: 0;

      &:hover {
        cursor: pointer;
      }
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
        position: relative;
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
    width: 180px;
    margin-left: 15px;
  }

</style>

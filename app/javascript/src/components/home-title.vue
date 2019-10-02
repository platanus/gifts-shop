<template>
  <div class="home-title">
    <div class="home-title__title">
      Busquemos un regalo para
      <span class="home-title__user-name">{{ receiverName }}</span>
      <img
        class="home-title_icon home-title__icon--clear"
        src="../assets/close-badge.svg"
        @click="clearCookies"
      >
    </div>
    <div class="home-title__subtitle">
      Con el
      <img
        class="home-title__icon home-title__icon"
        src="../assets/gift-color-badge.svg"
      >
      las sugerencias mejorarán
      <img
        class="home-title__icon home-title__icon"
        src="../assets/magic-wand.svg"
      >
      <span class="home-title__emphasis-word">
        mágicamente
      </span>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex';

export default {
  name: 'HomeTitle',
  computed: {
    ...mapState([
      'receiverName',
    ]),
  },
  methods: {
    clearCookies() {
      this.$cookies.keys().forEach(
        cookie => this.$cookies.remove(cookie)
      );
      window.location.reload();
    },
  },
};
</script>

<style lang="scss">
  @import '../../styles/variables';

  .home-title {
    display: flex;
    flex: 1 70%;
    font-size: 2.6em;
    flex-direction: column;

    &__title {
      flex-direction: row;
      align-items: center;
      padding: .15em 0;
      color: $title-font-color;
    }

    &__subtitle {
      font-size: .5em;
      color: $subtitle-font-color;
      font-weight: 300;
    }

    &__emphasis-word {
      font-style: italic;
      color: $emphasis-word-font-color;
    }

    &__user-name {
      border-bottom: 2px solid currentColor;
      margin-left: .1em;
      color: $user-name-font-color;
    }

    &__icon {
      align-self: flex-end;
      max-width: .75em;

      &--clear {
        min-width: .6em;
        filter: drop-shadow( 2px 2px 2px $icon-shadow-color);

        &:hover {
          cursor: pointer;
        }
      }
    }
  }
</style>

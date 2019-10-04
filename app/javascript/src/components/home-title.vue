<template>
  <div class="home-title">
    <div v-if="likes <= 0 && onTop">
      Busquemos un regalo para
      <span class="home-title__user-name">{{ receiverName }}</span>
    </div>
    <div v-else>
      {{ likes }} likes: {{ likes > 0 ? `${likes} idea(s)` : 'Guarda las buenas ideas con ' }}
      <img
        class="home-title__icon"
        src="../assets/gift-badge.svg"
      >
      {{ likes > 0 ? 'para Diego' : '' }}
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
  computed: {
    ...mapState([
      'receiverName',
    ]),
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
    }
  }
</style>

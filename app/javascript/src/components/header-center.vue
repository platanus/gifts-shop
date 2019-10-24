<template>
  <div class="header-center">
    <div class="header-center__title">
      Poder recomendador de ideas para <span class="header-center__title--emphasis-word"> {{receiverName}} </span>
      <img
        class="header-center__icon header-center__icon--title"
        src="../assets/close-badge.svg"
        @click="clearCookies"
      >
    </div>
    <div class="header-center__powerbar">
      <img
        class="header-center__icon header-center__icon--powerbar"
        src="../assets/bot.svg"
      >
      <div class="powerbar__background">
        <div class="powerbar__foreground" />
      </div>
    </div>
    <div
      class="header-center__subtitle"
      :class="{ 'header-center__subtitle--zero-height': !onTop}"
    >
      Aumenta el poder con
      <img
        class="header-center__icon header-center__icon--subtitle"
        src="../assets/like-badge.svg"
      >
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
  methods: {
    clearCookies() {
      this.$store.dispatch('deleteSessionReceiver');
    },
  },
  created() {
    this.$store.dispatch('getReceiverName');
  },
};
</script>

<style lang="scss">
  @import '../../styles/variables';

  .header-center {
    margin: auto;

    &__title {
      flex-direction: row;
      align-items: center;
      font-weight: 300;
      width: 100%;
      text-align: center;
      margin: .15em 0;
      color: $title-font-color;

      &--emphasis-word {
        font-style: italic;
        color: $emphasis-word-font-color;
      }
    }

    &__subtitle {
      color: $subtitle-font-color;
      opacity: .56;
      font-size: .9em;
      text-align: center;
      transition: all .5s;
      height: 1em;
      overflow: hidden;

      &--zero-height {
        height: 0;
      }

      @media (min-width: $p-break) {
        text-align: right;
        height: fit-content;

        &--zero-height {
          height: fit-content;
        }
      }
    }

    &__user-name {
      border-bottom: 2px solid currentColor;
      color: $user-name-font-color;
    }

    &__icon {
      align-self: flex-end;
      margin-bottom: -.1em;

      &--powerbar {
        margin: 0 1em .3em 0;
        width: 2.3em;
        height: 2.3em;
      }

      &--title {
        border-radius: 50%;
        box-shadow: 2px 2px 3px #bbb;

        &:hover {
          cursor: pointer;
        }
      }

      &--subtitle {
        width: 1em;
        height: 1em;
      }
    }
  }
</style>

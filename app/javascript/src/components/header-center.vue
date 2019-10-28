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
    <div class="header-center__powerbar-container">
      <img
        class="header-center__icon header-center__icon--powerbar"
        src="../assets/bot.svg"
        v-if="mobile"
      >
      <div class="powerbar__background">
        <div class="powerbar__foreground" />
      </div>
    </div>
    <div
      class="header-center__subtitle"
      v-if="!mobile"
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
    font-size: .9em;
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
        color: $emphasis-word-font-color;
        text-transform: capitalize;
      }
    }

    &__subtitle {
      color: $subtitle-font-color;
      opacity: .56;
      font-size: .9em;
      text-align: center;
      height: 1em;
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
        box-shadow: 2px 2px 3px $icon-shadow-color;

        &:hover {
          cursor: pointer;
        }
      }

      &--subtitle {
        width: 1em;
        height: 1em;
      }
    }

    &__powerbar-container {
      display: flex;
      align-items: center;

      .powerbar {
        &__background {
          height: 5px;
          width: 100%;
          border-radius: 4px;
          background-color: rgba(148, 148, 148, .24);
          position: relative;
        }

        &__foreground {
          border-radius: 4px;
          height: 100%;
          z-index: 105;
          position: absolute;
          background-image: linear-gradient(to right, #ff5a5a 0, #ffc563 140px, #16a69e 280px);
          background-size: 100%;
          width: 100%;
        }
      }

      @media (min-width: $p-break) {
        .powerbar__background {
          margin: 1em auto;
          width: 90%;
        }
      }
    }
  }
</style>

<template>
  <div class="header-center">
    <div class="header-center__title">
      Poder recomendador de ideas para <span class="header-center__title--emphasis-word"> {{ receiverName }}</span>
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
        <div
          class="powerbar__foreground"
          :style="style"
        />
      </div>
    </div>
    <div
      class="header-center__subtitle"
      v-if="!mobile"
    >
      Aumenta el poder con
      <img
        class="header-center__icon header-center__icon--subtitle"
        src="../assets/like-badge-white.svg"
      >
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex';

const LIKES_TO_TOTAL_POWER = 6;
const INITIAL_POWER = 10;
const TOTAL_POWER = 100;

export default {
  name: 'HomeTitle',
  props: {
    likes: {
      type: Number,
      default: 0,
    },
    mobile: {
      type: Boolean,
      default: true,
    },
  },
  computed: {
    ...mapState([
      'receiverName',
    ]),
    style() {
      let power = TOTAL_POWER;
      if (this.likes < LIKES_TO_TOTAL_POWER) {
        power = (this.likes * (TOTAL_POWER - INITIAL_POWER) / LIKES_TO_TOTAL_POWER) + INITIAL_POWER;
      }

      return { width: `${power}%` };
    },
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
        text-decoration: underline;
        text-transform: capitalize;
      }
    }

    &__subtitle {
      color: $subtitle-font-color;
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
        margin-left: .5em;

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
          background-color: rgba(255, 255, 255, .24);
          position: relative;
        }

        &__foreground {
          border-radius: 4px;
          height: 100%;
          z-index: 105;
          position: absolute;
          background-size: 100%;
          background-color: #fff;
          transition: width .6s;
          width: 10%;
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

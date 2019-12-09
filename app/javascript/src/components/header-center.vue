<template>
  <div class="header-center">
    <div class="header-center__title">
      Busquemos regalo para <span
        class="header-center__title--emphasis-word"
        @click="clearCookies"
      >
        {{ receiverName }}</span>
    </div>
    <div class="header-center__powerbar-container">
      <img
        src="../assets/like-color-badge.svg"
        :key="likes"
        class="powerbar__icon"
        :class="{ 'powerbar__icon--pumping': pumping }"
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
      Mejora las sugerencias con más
      <img
        class="header-center__icon header-center__icon--subtitle"
        src="../assets/like-badge.svg"
      >
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex';

const LIKES_TO_TOTAL_POWER = 6;
const INITIAL_POWER = 15;
const TOTAL_POWER = 75;
const PUMP_TIMEOUT = 1000;

export default {
  name: 'HomeTitle',
  data() {
    return {
      resetButton: false,
      pumping: false,
      pumpingTimeOut: null,
    };
  },
  props: {
    mobile: {
      type: Boolean,
      default: true,
    },
  },
  computed: {
    ...mapState([
      'receiverName',
      'likes',
    ]),
    style() {
      let power = TOTAL_POWER;
      if (this.likes < LIKES_TO_TOTAL_POWER) {
        power = (this.likes * (TOTAL_POWER - INITIAL_POWER) / LIKES_TO_TOTAL_POWER) + INITIAL_POWER;
      }

      return { width: `${power}%` };
    },
  },
  watch: {
    likes(newValue, oldValue) {
      if (newValue > oldValue) {
        if (this.pumpingTimeOut) {
          clearTimeout(this.pumpingTimeOut);
        }
        this.pumping = true;
        this.pumpingTimeOut = setTimeout(() => {
          this.pumping = false;
        }, PUMP_TIMEOUT);
      }
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

  @keyframes main-pump {
    0% {
      transform: scale(1);
    }

    30% {
      transform: scale(1.4);
    }

    100% {
      transform: scale(1);
    }
  }

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

        &:hover {
          color: darken($color: $emphasis-word-font-color, $amount: 15%);
        }
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
        height: 17px;

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
          height: 6px;
          width: 100%;
          border-radius: 4px;
          background-color: $home-background;
          position: relative;
          margin: 1em auto;
        }

        &__icon {
          margin-right: .5em;
          width: 24px;

          &--pumping {
            animation: main-pump 1s;
          }
        }

        &__foreground {
          border-radius: 4px;
          height: 100%;
          z-index: 105;
          position: absolute;
          background-size: 100%;
          background-color: #f5525b;
          transition: width 1.5s;
          width: 10%;
        }
      }

      @media (min-width: $p-break) {
        .powerbar__background {
          width: 90%;
        }
      }
    }
  }
</style>

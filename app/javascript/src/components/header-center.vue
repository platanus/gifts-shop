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
        class="header-center__icon header-center__icon--title"
        src="../assets/bot.svg"
      >
      <div class="powerbar__background">
        <div class="powerbar__foreground" />
      </div>
    </div>
    <div class="header-center__subtitle">
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
      padding: .15em 0;
      color: $title-font-color;
    }

    &__subtitle {
      color: $subtitle-font-color;
      font-weight: 300;
    }

    &__emphasis-word {
      font-style: italic;
      color: $emphasis-word-font-color;
    }

    &__user-name {
      border-bottom: 2px solid currentColor;
      color: $user-name-font-color;
    }

    &__icon {
      align-self: flex-end;
    }
  }
</style>

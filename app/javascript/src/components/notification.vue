<template>
  <transition name="slide-fade">
    <div
      v-show="visible"
      @mouseenter="clearTimer"
      @mouseleave="startTimer"
      class="flex flex-col text-center fixed top-0 right-0 z-50 p-4 mx-4 mt-4 border-l-8 rounded-lg shadow-lg bg-white"
    >
      <p class="font-bold text-lg">
        {{ title }}
      </p><br>
      <p class="text-gray-600">
        {{ message }}
      </p><br>
      <a
        v-if="clickableMessage"
        class="underline text-purple-500"
        :href="clickableMessageLink"
      >
        {{ clickableMessage }}
      </a>
    </div>
  </transition>
</template>

<script>
const DELETE_KEY = 46;
const BACKSPACE_KEY = 8;
const ESCAPE_KEY = 27;

export default {
  data() {
    return {
      title: '',
      message: '',
      clickableMessage: '',
      clickableMessageLink: '',
      visible: false,
      closed: false,
      duration: 6500,
    };
  },
  methods: {
    close() {
      this.closed = true;
      this.visible = false;
    },
    clearTimer() {
      clearTimeout(this.timer);
    },
    startTimer() {
      if (this.duration > 0) {
        this.timer = setTimeout(() => {
          if (!this.closed) {
            this.close();
          }
        }, this.duration);
      }
    },
    keydown(e) {
      if (e.keyCode === DELETE_KEY || e.keyCode === BACKSPACE_KEY) {
        this.clearTimer();
      } else if (e.keyCode === ESCAPE_KEY) {
        if (!this.closed) {
          this.close();
        }
      } else {
        this.startTimer();
      }
    },
  },
  mounted() {
    this.startTimer();
    document.addEventListener('keydown', this.keydown);
  },
  beforeDestroy() {
    document.removeEventListener('keydown', this.keydown);
  },
};
</script>

<style scoped lang="scss">
  .slide-fade-enter-active {
    transition: all .3s ease;
  }
  .slide-fade-leave-active {
    transition: all .5s cubic-bezier(1, .5, .8, 0);
  }
  .slide-fade-enter,
  .slide-fade-leave-to {
    transform: translateX(10px);
    opacity: 0;
  }
</style>

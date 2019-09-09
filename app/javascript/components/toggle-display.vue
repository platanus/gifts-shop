<template>
  <div
    class="toggle-display"
    :class="stateClass"
    @click.self="onClick"
  >
    <div
      class="draggable"
      @mousedown.prevent="dragStart"
      :style="style"
    />
  </div>
</template>

<script>

const fullSize = 100;
const halfSize = 50;
const emptySize = 30;

export default {
  props: {
    value: { type: Boolean, required: true },
  },
  data() {
    return {
      width: 50,
      state: false,
      pressed: 0,
      position: 0,
    };
  },
  mounted() {
    this.toggleDisplay(this.value);
  },
  computed: {
    style() {
      return {
        transform: `translateX(${this.posPercentage})`,
      };
    },
    posPercentage() {
      return `${this.position / this.width * fullSize}%`;
    },
    stateClass() {
      if (this.state) {
        return 'active';
      }

      return '';
    },
  },
  watch: {
    position() {
      this.state = this.position >= halfSize;
    },
  },
  methods: {
    onClick() {
      this.toggleDisplay(!this.state);
      this.emit();
    },
    toggleDisplay(state) {
      this.state = state;
      this.position = state ?
        fullSize :
        0;
    },
    dragging(e) {
      const pos = e.clientX - this.$el.offsetLeft;
      const percent = pos / this.width * fullSize;
      if (percent <= 0) {
        this.position = 0;
      } else {
        if (percent >= fullSize) {
          this.position = fullSize;
        } else {
          this.position = percent;
        }
      }
    },
    dragStart() {
      this.startTimer();
      window.addEventListener('mousemove', this.dragging);
      window.addEventListener('mouseup', this.dragStop);
    },
    dragStop() {
      window.removeEventListener('mousemove', this.dragging);
      window.removeEventListener('mouseup', this.dragStop);
      this.resolvePosition();
      clearInterval(this.$options.interval);
      if (this.pressed < emptySize) {
        this.toggleDisplay(!this.state);
      }
      this.pressed = 0;
      this.emit();
    },
    startTimer() {
      this.$options.interval = setInterval(() => {
        this.pressed++;
      }, 1);
    },
    resolvePosition() {
      this.position = this.state ?
        fullSize :
        0;
    },
    emit() {
      this.$emit('input', this.state);
    },
  },
};

</script>

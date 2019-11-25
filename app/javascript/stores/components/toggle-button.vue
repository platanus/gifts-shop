<template>
  <div
    class="toggle-button"
    :class="stateClass"
    @click.self="toggleAction"
  >
    <div
      class="draggable"
      @mousedown.prevent="dragStart"
      :style="style"
    />
  </div>
</template>

<script>
import catalogApi from '../api/catalog';

const fullSize = 100;
const halfSize = 50;
const emptySize = 30;

export default {
  props: {
    value: {
      type: Boolean, required: true,
    },
    productId: {
      type: String, required: true,
    },
    attribute: {
      type: String, required: true,
    },
    enabled: {
      type: Boolean, required: true,
    },
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
    this.toggleSwitch(this.value);
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
      if (!this.enabled) {
        return 'disabled';
      } else if (this.state) {
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
    toggleAction() {
      if (this.enabled) {
        this.toggleSwitch(!this.state);
        catalogApi.setValue(this.productId, this.attribute);
        this.emit();
      }
    },
    toggleSwitch(state) {
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
      if (this.enabled) {
        this.startTimer();
        window.addEventListener('mousemove', this.dragging);
        window.addEventListener('mouseup', this.dragStop);
      }
    },
    dragStop() {
      window.removeEventListener('mousemove', this.dragging);
      window.removeEventListener('mouseup', this.dragStop);
      this.resolvePosition();
      clearInterval(this.$options.interval);
      if (this.pressed < emptySize) {
        this.toggleSwitch(!this.state);
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

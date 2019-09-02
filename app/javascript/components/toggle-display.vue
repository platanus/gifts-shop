<template>
  <div class="ToggleDisplay" :class=[this.state_class] @click.self="onClick">
    <div class="draggable" @mousedown.prevent="dragStart" :style="style"></div>
  </div>
</template>

<script>

export default {
  name: 'ToggleDisplay',
  props: {
    value: {type: Boolean, required: true},
  },
  data () {
    return {
      width: 50,
      state: false,
      pressed: 0,
      position: 0
    }
  },
  mounted() {
    this.ToggleDisplay(this.value)
  },
  computed: {
    style() {
      return {
        transform: `translateX(${this.pos_percentage})`
      }
    },
    pos_percentage() {
      return `${this.position / this.width * 100}%`
    },
    state_class() {
      if (this.state) {
        return 'active'
      }
    }
  },
  watch: {
    position() {
      this.state = this.position >= 50
    }
  },
  methods: {
    onClick() {
      this.ToggleDisplay(!this.state)
      this.emit()
    },
    ToggleDisplay(state) {
      this.state = state
      this.position = !state
        ? 0
        : 100
    },
    dragging(e) {
      const pos = e.clientX - this.$el.offsetLeft 
      const percent = pos / this.width * 100
      this.position = percent <= 0
        ? 0
        : percent >= 100
          ? 100
          : percent
    },
    dragStart(e) {
      this.startTimer()
      window.addEventListener('mousemove', this.dragging)
      window.addEventListener('mouseup', this.dragStop)
    },
    dragStop() {
      window.removeEventListener('mousemove', this.dragging)
      window.removeEventListener('mouseup', this.dragStop)
      this.resolvePosition()
      clearInterval(this.$options.interval)
      if (this.pressed < 30) {
        this.ToggleDisplay(!this.state)
      }
      this.pressed = 0
      this.emit()
    },
    startTimer() {
      this.$options.interval = setInterval(() => {
        this.pressed++
      }, 1)
    },
    resolvePosition() {
      this.position = this.state
        ? 100
        : 0
    },
    emit() {
      this.$emit('input', this.state)
    }
  }
};
</script>

<template>
  <div
    class="toggle-button"
    :class="stateClass"
    @click="toggleAction"
  >
    <div
      class="draggable"
      :style="style"
    />
  </div>
</template>

<script>

import productApi from '../api/product';

const fullSize = 100;
const halfSize = 50;

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
    storeId: {
      type: Number, required: false, default: null,
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
      }
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
    toggleAction() {
      if (this.enabled) {
        this.toggleSwitch(!this.state);
        productApi.setValue(this.productId, this.attribute).then(() => {
          this.updateBalance();
        });
        this.emit();
      }
    },
    toggleSwitch(state) {
      this.state = state;
      this.position = state ?
        fullSize :
        0;
    },
    updateBalance() {
      if (this.storeId) {
        this.$store.dispatch('updateBalance', this.storeId);
      }
    },
    emit() {
      this.$emit('input', this.state);
    },
  },
};

</script>

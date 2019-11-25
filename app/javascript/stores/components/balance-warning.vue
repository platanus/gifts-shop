<template>
  <div
    class="warning-container"
    v-show="lowBalance"
  >
    <div class="balance-warning">
      ¡No tienes saldo suficiente para promocionar tus productos!<br>
      <span
        class="balance-warning balance-warning__action"
        @click="goToPayments"
      >
        Agregar saldo
      </span>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex';

export default {
  props: {
    storeId: {
      type: Number,
      required: true,
    },
  },
  computed: {
    ...mapState([
      'lowBalance',
    ]),
  },
  methods: {
    goToPayments() {
      window.location = '/stores/payments/about';
    },
  },
  mounted() {
    this.$store.dispatch('updateBalance', this.storeId);
  },
};
</script>

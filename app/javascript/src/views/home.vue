<template>
  <div class="block w-full min-h-screen text-base bg-gf-gray-light">
    <navbar />
    <modal
      :show-modal="emailModalIsOpen"
    />
    <div
      v-if="store"
    >
      <store
        :store="store"
      />
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex';
import modal from '../components/modal-share-email.vue';
import store from '../components/store';
import navbar from '../components/navbar';

export default {
  name: 'HomeView',
  components: {
    store,
    navbar,
    modal,
  },
  computed: {
    ...mapState([
      'store',
      'emailModalIsOpen',
    ]),
  },
  mounted() {
    this.$store.dispatch('getProducts');
  },
};
</script>

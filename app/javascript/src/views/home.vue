<template>
  <div class="block w-full min-h-screen text-base bg-gf-gray-light">
    <navbar />
    <modal
      :show-modal="emailModalIsOpen"
    />
    <div
      v-if="category"
    >
      <category
        :category="category"
      />
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex';
import modal from '../components/modal-share-email.vue';
import category from '../components/category';
import navbar from '../components/navbar';

export default {
  name: 'HomeView',
  components: {
    category,
    navbar,
    modal,
  },
  computed: {
    ...mapState([
      'category',
      'emailModalIsOpen',
    ]),
  },
  mounted() {
    this.$store.dispatch('getProducts');
  },
};
</script>

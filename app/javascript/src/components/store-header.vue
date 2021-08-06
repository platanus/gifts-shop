<template>
  <div
    class="pt-5 bg-white md:pb-7"
  >
    <div
      class="flex flex-col lg:mx-24 xl:mx-48 md:flex-row md:justify-between"
    >
      <div class="w-full">
        <p
          class="mx-4 text-sm font-roboto text-gf-gray-dark"
        >
          Estás buscando en la tienda:
        </p>
        <div class="flex items-center justify-between mt-2 mx-3 text-2xl md:text-3xl font-semibold border rounded-md text-gf-gray-dark px-2.5 h-12 md:h-14 md:max-w-md">
          <p>{{ storeName }}</p>
          <button
            @click="getProducts"
            class="h-full"
          >
            <img
              :src="require('assets/images/shuffle.svg')"
              alt="shuffle-icon"
            >
          </button>
        </div>
      </div>
      <div class="md:space-x-5 flex justify-between px-3.5 py-1 mt-5 md:mt-6 border-t md:border-t-0">
        <div
          v-for="(interval, index) in priceIntervals"
          :key="index"
          class="flex-col items-center justify-center w-24 text-sm rounded-lg cursor-pointer md:rounded-2xl md:w-20 md:h-14 md:border md:pt-1"
          :class="selectedInterval == index ? 'bg-gf-emerald text-white font-semibold md:border-gf-emerald' : 'text-gf-gray font-normal'"
          @click="setSelectedInterval(index)"
        >
          <p class="text-center">
            {{ index | toSigns }}
          </p>
          <p class="text-center">
            {{ interval }}
          </p>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import { mapState, mapMutations, mapActions } from 'vuex';

export default {
  props: {
    storeName: {
      type: String,
      required: true,
    },
  },
  computed: {
    ...mapState([
      'selectedInterval',
    ]),
    priceIntervals() {
      // eslint-disable-next-line no-undef
      const intervals = process.env.PRICE_INTERVAL_LIMITS.split(',');
      intervals.splice(0, 1);

      return intervals;
    },
  },
  methods: {
    ...mapMutations([
      'setSelectedInterval',
    ]),
    ...mapActions([
      'getProducts',
    ]),
  },
  filters: {
    toSigns(value) {
      return '$'.repeat(value + 1);
    },
  },
};
</script>

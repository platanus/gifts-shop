<template>
  <div
    class="sticky top-0 z-20 grid items-center w-full h-16 grid-cols-3 mx-auto bg-white shadow-md"
  >
    <div class="h-full mt-2">
      <router-link to="/">
        <img
          class="h-12 mx-auto"
          :src="require('assets/images/buenas-ideas.svg')"
        >
      </router-link>
    </div>
  </div>
</template>
<script>
const MOBILE_WIDTH = 650;
const TABLET_WIDTH = 1000;

export default {
  name: 'HomeHeader',
  data() {
    const desktop = window.innerWidth > TABLET_WIDTH;

    return {
      mobile: window.innerWidth <= MOBILE_WIDTH,
      desktop,
    };
  },
  methods: {
    onResize() {
      this.mobile = window.innerWidth <= MOBILE_WIDTH;
      this.desktop = window.innerWidth > TABLET_WIDTH;
    },
  },
  mounted() {
    window.addEventListener('resize', this.onResize);
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.onResize);
  },
};
</script>

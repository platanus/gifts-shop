<template>
  <div
    id="home"
    class="home-main"
  >
    <router-view />
  </div>
</template>

<style lang="scss">
  @import '../styles/variables';

  .home-main {
    display: flex;
    align-self: center;
    justify-content: center;
    font-family: 'Work Sans', sans-serif;
    font-size: 11px;
  }
</style>

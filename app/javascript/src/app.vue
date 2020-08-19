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
    font-size: 11px;
    min-height: 100vh;
  }
</style>

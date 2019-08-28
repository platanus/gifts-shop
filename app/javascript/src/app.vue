<template>
  <div
    id="app"
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
    overflow-y: scroll;
    font-family: 'Work Sans', sans-serif;
    height: 100vh;
    font-size: 11px;
  }
</style>

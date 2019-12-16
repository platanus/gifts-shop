<template>
  <div class="home-card-container">
    <div class="home-card">
      <div class="home-card__image-wrapper">
        <div class="image-container">
          <img
            class="home-card__image"
            src="../assets/like-badge.svg"
          >
        </div>
      </div>
      <div class="home-information">
        <div class="home-information home-information__title">
          ¡Mejora las recomendaciones!
        </div>
        <div class="home-information home-information__subtitle">
          <br>Entre más <img
            src="../assets/like-badge.svg"
            class="text-icon"
            align="top"
          >
          aprietes, tendremos una mejor idea de lo que le podría gustar a <span
            class="home-card__receiverName"
          >
            {{ receiverName }}
          </span><br>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex';

export default {
  computed: {
    ...mapState([
      'receiverName',
    ]),
  },
};
</script>

<style lang="scss">
  @import '../../styles/variables';

  .home-card {
    display: flex;
    flex-direction: column;
    height: 100%;
    position: relative;
    margin: auto;
    font-size: 1.2em;
    color: $product-name-font-color;
    width: $m-size-image;
    border: 1px solid rgba(148, 148, 148, .16);
    box-shadow: 0 2px 6px rgba(148, 148, 148, .24);
    border-radius: 4px;
    background-color: #fff;

    @media (min-width: $p-break) {
      width: $p-size-image;
    }

    @media (min-width: $t-break) {
      width: $t-size-image;
    }

    @media (min-width: $d-break) {
      width: $d-size-image;
    }

    @media (min-width: $r-break) {
      width: $r-size-image;
    }

    &__receiverName {
      text-transform: capitalize;
      color: $label-color;
    }

    &__icon-container {
      position: absolute;
      top: 8px;
      right: 8px;
      height: 1.5em;
      width: 1.5em;
      border-radius: 50%;
      padding: .1em;
      background-color: #fff;
      box-shadow: 0 4px 6px 0 rgba(43, 43, 43, .13);
      z-index: 20;

      &:hover {
        cursor: pointer;
      }
    }

    &__image-wrapper {
      display: flex;
      justify-content: center;
      width: $m-size-image;
      height: $m-size-image;
      border-radius: 4px 4px 0 0;
      cursor: pointer;

      .image-container {
        background: $card-background;
        border-radius: 4px 4px 0 0;
        width: 100%;
        height: 100%;
        text-align: center;
      }

      @media (min-width: $p-break) {
        height: $p-size-image;
        width: $p-size-image;

        .image-container {
          height: $p-size-image;
          width: $p-size-image;
        }
      }

      @media (min-width: $t-break) {
        height: $t-size-image;
        width: $t-size-image;

        .image-container {
          height: $t-size-image;
          width: $t-size-image;
        }
      }

      @media (min-width: $d-break) {
        height: $d-size-image;
        width: $d-size-image;

        .image-container {
          height: $d-size-image;
          width: $d-size-image;
        }
      }

      @media (min-width: $r-break) {
        height: $r-size-image;
        width: $r-size-image;

        .image-container {
          height: $r-size-image;
          width: $r-size-image;
        }
      }
    }

    &__image {
      padding-top: 30%;
      width: 40%;
      height: 40%;
      border-radius: 4px 4px 0 0;
    }

    &__icon {
      vertical-align: middle;
      height: 80%;
      width: 80%;
      margin: .17em;
      cursor: pointer;
    }

    &__title {
      text-align: center;
      font-size: 1.2em;
      margin: 8px auto;
      display: -webkit-box; //stylelint-disable value-no-vendor-prefix
      line-height: 1.2em;
      max-height: 2.5em;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical; //stylelint-disable property-no-vendor-prefix
      cursor: pointer;
    }
  }

  .home-information {
    text-align: center;
    margin: 5px;

    &__title {
      font-size: 1em;
      font-weight: bolder;
    }

    &__subtitle {
      font-size: .7em;
      text-align: center;
      opacity: .7;
    }
  }

  .text-icon {
    vertical-align: middle;
    height: 1.3em;
  }

</style>

<template>
  <div class="feedback-window-container">
    <div class="feedback-window">
      <div class="feedback-header">
        <div class="header-left">
          <img
            src="../assets/close-badge.svg"
            @click="closeFeedback"
          >
        </div>
      </div>
      <div
        class="feedback-body"
        v-if="start"
      >
        <div class="body-text-container">
          <div
            class="feedback-body__title"
          >
            ¿Encontraste regalo?
          </div>
        </div>
        <div class="feedback-body__actions">
          <button
            class="helper-btn btn"
            @click="fulfillment"
          >
            Si
          </button>
          <button
            class="helper-btn helper-btn--cancel btn"
            @click="proceed"
          >
            No, AYUDA!!
          </button>
        </div>
      </div>
      <div
        class="feedback-body"
        v-else
      >
        <div class="body-text-container">
          <div
            class="feedback-body__title"
          >
            Apliquemos plan B
          </div>
          <div class="feedback-body__subtitle">
            Nuestro regalador experto te ayudará por WhatsApp
          </div>
        </div>
        <div class="feedback-form-container">
          <input
            type="text"
            class="user-contact"
            name="phoneNumber"
            v-model="contact"
            placeholder="+569..."
            autocomplete="off"
          >
          <div
            class="feedback-warning"
            :style="contactError ? {opacity: 1} : {opacity: 0}"
          >
            El número debe ser válido
          </div>
          <button
            class="helper-btn btn"
            @click="validateContact"
          >
            AYUDA!
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex';
import feedbackApi from '../api/feedback';

const PHONE_NUMBER_LENGTH = 11;

export default {
  data() {
    return {
      contact: '',
      start: true,
      contactError: false,
    };
  },
  methods: {
    ...mapActions([
      'toggleFeedback',
    ]),
    proceed() {
      this.start = false;
    },
    closeFeedback() {
      this.toggleFeedback();
    },
    submitRequest() {
      feedbackApi.postFeedback(false, this.contact);
      this.closeFeedback();
    },
    validateContact() {
      if (this.contact.length >= PHONE_NUMBER_LENGTH) {
        this.submitRequest();
      } else {
        this.contactError = true;
      }
    },
    fulfillment() {
      feedbackApi.postFeedback(true, '');
      this.closeFeedback();
    },
  },
};
</script>

<style lang="scss">
  @import '../../styles/variables';

  .feedback-window-container {
    z-index: 9998;
    position: fixed;
    bottom: 0;
    right: 0;
    height: 16em;
    width: 100%;
    max-width: 450px;
    background: $c-header-background;
    box-shadow: 0 2px 6px rgba(148, 148, 148, .24);
  }

  .feedback-window {
    height: 100%;
    width: 100%;
    text-align: center;
  }

  .feedback-header {
    background: $label-color;
    height: 10%;
  }

  .feedback-body {
    height: 100%;

    &__title {
      padding-top: 5%;
      font-size: 1.5em;
    }

    &__subtitle {
      opacity: .5;
      margin-top: 5px;
    }

    &__actions {
      height: 50%;
      display: flex;
      justify-content: space-evenly;
      flex-wrap: wrap;
    }
  }

  .header-left {
    text-align: left;
    padding-left: 13px;
    padding-top: .3em;
  }

  .helper-btn {
    height: 2.5em;
    width: 150px;
    border-radius: 30.5px;
    border: 0;
    line-height: 0;
    color: $white;
    text-transform: uppercase;
    font-size: 14px;
    font-weight: 600;
    letter-spacing: .4px;
    text-align: center;
    margin-top: 10px;
    margin-bottom: 10px;

    &:hover {
      background-color: darken($color: $primary-color, $amount: 5%);
    }
  }

  .body-text-container {
    height: 40%;
  }

  .user-contact {
    border: 0;
    border-bottom: solid 2px $primary-color;
    width: 60%;
    font-size: 1.5em;
    outline: none;
    text-align: center;
  }

  .feedback-form-container {
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .feedback-warning {
    color: $danger-label-color;
    font-size: .7em;
    margin-top: 8px;
    margin-bottom: 8px;
  }

</style>

<template>
  <div>
    <form
      action="/create"
      method="POST"
      class="new-product-form"
      enctype="multipart/form-data"
    >
      <input
        type="hidden"
        name="authenticity_token"
        :value="csrfToken"
        autocomplete="off"
      >
      <div class="new-product-form__info">
        <div class="product-input">
          <div class="product-input__label">
            NOMBRE DEL PRODUCTO
          </div>
          <input
            type="text"
            class="product-input__box"
            name="name"
            placeholder="Ej: Cortinas Roller"
          >
        </div>
        <div class="product-input">
          <div class="product-input__label">
            PRECIO
          </div>
          <input
            type="text"
            class="product-input__box"
            name="price"
            placeholder="$0"
          >
        </div>
        <div class="product-input">
          <div class="product-input__label">
            LINK A TIENDA
          </div>
          <input
            type="text"
            class="product-input__box"
            name="link"
            placeholder="http://"
          >
        </div>
      </div>
      <div class="new-product-form__image">
        <div class="image-preview__label">
          FOTO DEL PRODUCTO
        </div>
        <div class="file-container">
          <div
            class="image-preview"
            v-if="imageData.length > 0"
          >
            <img
              class="image-preview__preview"
              :src="imageData"
            >
          </div>
          <div class="image-preview__value">
            Seleccionar archivo...
          </div>
          <div class="file-input">
            <input
              class="image-preview__input"
              type="file"
              @change="previewImage"
              accept="image/*"
              name="image"
            >
          </div>
        </div>
      </div>
      <div class="button-container">
        <form
          class=""
          method="get"
          action="/stores/catalog"
        >
          <input
            class="product-input__btn product-input__btn--cancel"
            value="VOLVER"
            type="submit"
          >
        </form>
        <input
          type="submit"
          class="product-input__btn product-input__btn--accept"
          value="AGREGAR"
        >
      </div>
    </form>
  </div>
</template>

<script>
import getCsrfToken from '../utils/csrf_token.js';

export default {
  data() {
    return {
      csrfToken: getCsrfToken(),
      imageData: '',
    };
  },
  methods: {
    previewImage(event) {
      const input = event.target;
      if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = (e) => {
          this.imageData = e.target.result;
        };
        reader.readAsDataURL(input.files[0]);
      }
    },
  },
};
</script>

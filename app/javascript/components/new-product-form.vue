<template>
  <div>
    <form action="/create" method="POST" class="new-product-form" enctype=multipart/form-data >
      <input type="hidden" name="authenticity_token" :value="csrfToken" autocomplete="off">
      <div class="new-product-form__info">
        <div class="product-input">
          <div class="product-input__label">Nombre</div>
          <input type="text" class="product-input__box" name="name">
        </div>
        <div class="product-input">
          <div class="product-input__label">Precio</div>
          <input type="text" class="product-input__box" name="price"/>
        </div>
        <div class="product-input">
          <div class="product-input__label">Link</div>
          <input type="text" class="product-input__box" name="link"/>
        </div>
        <div class="product-input">
          <input type="submit" class="product-input__btn" value="Agregar" >
        </div>
      </div>
      <div class="new-product-form__image">
        <div class="image-preview" v-if="imageData.length > 0" >
          <img class="image-preview__preview" :src="imageData">
        </div>
        <div class="image-preview" v-else>
          <img class="image-preview__preview" src="../../assets/images/default-gift.png" >
        </div>
        <input class="image-preview__input" type="file" @change="previewImage" accept="image/*" name="image">
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

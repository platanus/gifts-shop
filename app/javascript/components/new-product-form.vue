<template>
  <form action="/create" method="post" class="new-product-form">
    <input type="hidden" name="authenticity_token" :value="csrfToken" autocomplete="off">
    <div class="new-product-form__info">
      <div class="product-input">
        <div class="product-input__label">Nombre</div>
        <input type="text" class="product-input__box" name="name"/>
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
        <img class="preview" :src="imageData">
      </div>
      <input type="file" class="upload-image" @change="previewImage" accept="image/*" name="imageData">
    </div>
  </form>
</template>


<script>
import getCsrfToken from '../utils/csrf_token.js';


export default {
  data() {
    return {
      csrfToken: getCsrfToken(),
      imageData: "",
    }
  },
  methods: {
    previewImage(event) {
      var input = event.target;
      if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = (e) => {
          this.imageData = e.target.result;
        }
        reader.readAsDataURL(input.files[0]);
      }
    }
  },
};
</script>
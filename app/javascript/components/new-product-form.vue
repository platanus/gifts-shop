<template>
  <div>
    <form
      action="/create"
      method="POST"
      class="new-product-form"
      enctype="multipart/form-data"
      @submit="checkForm"
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
            v-model="name"
            :class="getHtmlClass('product-input__box', 'name')"
            name="name"
            placeholder="Ej: Cortinas Roller"
          >
          <div
            class="product-input__label product-input__label--danger"
            v-if="errors.name"
          >
            {{ errors.name }}
          </div>
        </div>
        <div class="product-input">
          <div class="product-input__label">
            PRECIO
          </div>
          <input
            type="text"
            v-model="price"
            :class="getHtmlClass('product-input__box', 'price')"
            name="price"
            placeholder="$0"
          >
          <div
            class="product-input__label product-input__label--danger"
            v-if="errors.price"
          >
            {{ errors.price }}
          </div>
        </div>
        <div class="product-input">
          <div class="product-input__label">
            LINK A TIENDA
          </div>
          <input
            type="text"
            v-model="link"
            :class="getHtmlClass('product-input__box', 'link')"
            name="link"
            placeholder="http://"
          >
          <div
            class="product-input__label product-input__label--danger"
            v-if="errors.link"
          >
            {{ errors.link }}
          </div>
        </div>
      </div>
      <div class="new-product-form__image">
        <div class="image-preview__label">
          FOTO DEL PRODUCTO
        </div>
        <div
          :class="getHtmlClass('file-container', 'image')"
        >
          <div
            class="image-preview"
            v-if="imageData.length > 0"
          >
            <img
              class="image-preview__preview"
              :src="imageData"
            >
          </div>
          <div>
            <div>
              <div
                :class="getHtmlClass('image-preview__value', 'image')"
              >
                Seleccionar archivo...
              </div>
              <div>
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
            <div>
              <div
                class="image-preview__label image-preview__label--danger"
                v-if="errors.image"
              >
                {{ errors.image }}
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="button-container">
        <a
          href="/stores/catalog"
          class="btn product-input__link product-input__link--cancel"
        >
          <div class="link-button-text">
            VOLVER
          </div>
        </a>
        <button
          type="submit"
          class="product-input__btn product-input__btn--accept"
        >
          AGREGAR
        </button>
      </div>
    </form>
  </div>
</template>

<script>
import getCsrfToken from '../utils/csrf_token.js';

const MINIMUM_NAME_LENGTH = 5;
const MINIMUM_LINK_LENGTH = 5;

export default {
  data() {
    return {
      csrfToken: getCsrfToken(),
      imageData: '',
      errors: {},
      name: '',
      link: '',
      price: null,
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
    checkForm(e) {
      this.errors = {};
      this.validateName();
      this.validateImage();
      this.validatePrice();
      this.validateLink();
      if (this.errors.length === 0) {
        return true;
      }
      e.preventDefault();

      return false;
    },
    validateName() {
      if (this.name.length < MINIMUM_NAME_LENGTH) {
        this.errors.name = 'El nombre debe tener al menos 5 caracteres';
      }
    },
    validatePrice() {
      if (!this.price) {
        this.errors.price = 'El precio no puede estar estar en blanco';
      }
    },
    validateLink() {
      if (this.link.length < MINIMUM_LINK_LENGTH) {
        this.errors.link = 'El link debe ser válido';
      }
    },
    validateImage() {
      if (!this.imageData) {
        this.errors.image = 'El producto debe tener una imagen';
      }
    },
    getHtmlClass(baseClass, errorName) {
      if (this.errors[errorName]) {
        return `${baseClass} ${baseClass}--danger`;
      }

      return `${baseClass}`;
    },
  },
};
</script>

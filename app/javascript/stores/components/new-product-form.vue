<template>
  <div>
    <form
      :action="product ? `/stores/catalog/${product.id}`: '/stores/catalog'"
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
      <input
        type="hidden"
        name="_method"
        value="put"
        autocomplete="off"
        v-if="product"
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
            placeholder="Ej: 5500"
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
            LINK AL PRODUCTO <span class="product-input__subtitle">(Instagram o sitio web)</span>
          </div>
          <input
            type="text"
            v-model="link"
            :class="getHtmlClass('product-input__box', 'link')"
            name="link"
            placeholder="www.tienda.com/calcetines"
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
          class="image-preview"
          v-if="imageData.length > 0"
        >
          <img
            class="image-preview__preview"
            :src="imageData"
          >
        </div>
        <div
          :class="getHtmlClass('file-container', 'image')"
        >
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
          class="btn product-input__btn product-input__btn--accept"
        >
          {{ product ? 'GUARDAR' : 'AGREGAR' }}
        </button>
        <form
          method="post"
          :action="`/stores/catalog/${product.id}`"
          v-if="product"
          @submit="confirmDelete"
        >
          <input
            type="hidden"
            name="_method"
            value="delete"
          >
          <input
            type="hidden"
            name="authenticity_token"
            :value="csrfToken"
            autocomplete="off"
          >
          <button
            type="submit"
            class="btn product-input__btn product-input__btn--danger"
          >
            ELIMINAR
          </button>
        </form>
      </div>
    </form>
  </div>
</template>

<script>
import getCsrfToken from '../../utils/csrf_token.js';

const MINIMUM_NAME_LENGTH = 5;
const MINIMUM_LINK_LENGTH = 5;

export default {
  data() {
    return this.product ? {
      csrfToken: getCsrfToken(),
      imageData: this.product.image_url || '',
      errors: {},
      name: this.product.name,
      link: this.product.link,
      price: this.product.price,
    } : {
      csrfToken: getCsrfToken(),
      imageData: '',
      errors: {},
      name: '',
      link: '',
      price: null,
    };
  },
  props: {
    product: {
      type: Object,
      default: null,
    },
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
    confirmDelete(e) {
      const destroy = confirm('Seguro que deseas eliminar este producto?'); // eslint-disable-line no-alert
      if (!destroy) e.preventDefault();

      return destroy;
    },
    checkForm(e) {
      this.errors = {};
      this.validateName();
      this.validateImage();
      this.validatePrice();
      this.validateLink();
      if (Object.keys(this.errors).length === 0) {
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
      if (this.price) {
        this.price = this.cleanPrice(this.price);
        if (!this.isNumber(this.price)) {
          this.errors.price = 'Solo se aceptan números (0-9)';
        } else if (parseInt(this.price, 10) <= 0) {
          this.errors.price = '¡No regales tus productos!';
        }
      } else {
        this.errors.price = 'Debes ponerle un precio a tu producto';
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
    cleanPrice(price) {
      return price.replace(/[.,\s]/g, '');
    },
    isNumber(value) {
      return /^\d+$/.test(value);
    },
  },
};
</script>

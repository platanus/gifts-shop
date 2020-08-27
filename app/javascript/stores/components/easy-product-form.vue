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
        <div class="product-input">
          <div class="product-input__label">
            CORREO ELECTRÓNICO
          </div>
          <input
            type="email"
            v-model="email"
            :class="getHtmlClass('product-input__box', 'email')"
            name="email"
            placeholder="ejemplo@tienda.com"
          >
          <div
            class="product-input__label product-input__label--danger"
            v-if="errors.email"
          >
            {{ errors.email }}
          </div>
        </div>
      </div>
      <div class="button-container">
        <a
          href="/#"
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
      errors: {},
      name: this.product.name,
      link: this.product.link,
      price: this.product.price,
      email: this.product.email,
    } : {
      csrfToken: getCsrfToken(),
      errors: {},
      name: '',
      link: '',
      price: null,
      email: '',
    };
  },
  props: {
    product: {
      type: Object,
      default: null,
    },
  },
  methods: {
    checkForm(e) {
      this.errors = {};
      this.validateName();
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
      const pattern = new RegExp(
        '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|' +
        '((\\d{1,3}\\.){3}\\d{1,3}))' +
        '(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*' +
        '(\\?[;&a-z\\d%_.~+=-]*)?' +
        '(\\#[-a-z\\d_]*)?$', 'i');
      if (!pattern.test(this.link)) {
        this.errors.link = 'El link debe ser válido';
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

import api from './index';

export default {
  products() {
    const path = '/api/v1/products';

    return api({
      method: 'get',
      url: path,
    });
  },
  markDisplay(productId) {
    const path = '/api/v1/product_actions';

    return api({
      method: 'post',
      url: path,
      data: { productId },
    });
  },
};

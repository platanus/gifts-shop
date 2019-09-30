/* eslint-disable camelcase */
import api from './index';

export default {
  products(numberOfProducts) {
    const path = `/api/v1/products?number_of_products=${numberOfProducts}`;

    return api({
      method: 'get',
      url: path,
    });
  },
  markDisplayed(payload) {
    const path = '/api/v1/product_actions';

    return api({
      method: 'post',
      url: path,
      data: {
        product_id: payload,
        action_type: 'display',
      },
    });
  },
  markLiked(payload) {
    const path = '/api/v1/product_actions';

    return api({
      method: 'post',
      url: path,
      data: {
        product_id: payload,
        action_type: 'like',
      },
    });
  },
};

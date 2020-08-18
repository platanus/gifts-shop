/* eslint-disable camelcase */
import api from './index';

export default {
  products(numberOfProducts, minPrice, maxPrice, numberOfPromoted) {
    const path = `/api/v1/products?number_of_products=${numberOfProducts}&min_price=${minPrice}` +
      `&max_price=${maxPrice}&promoted=${numberOfPromoted}`;

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
  markClicked(payload) {
    const path = '/api/v1/product_actions';

    return api({
      method: 'post',
      url: path,
      data: {
        product_id: payload,
        action_type: 'click',
      },
    });
  },
};

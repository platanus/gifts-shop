/* eslint-disable camelcase */
import api from './index';

export default {
  category(page) {
    const path = `/api/v1/categories?page=${page}`;

    return api({
      method: 'get',
      url: path,
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
  shareByEmail(name, price, link, email) {
    const path = '/api/v1/product_share/';

    return api({
      method: 'post',
      url: path,
      data: {
        product_name: name,
        product_price: price,
        product_link: link,
        to_email: email,
      },
    });
  },
};

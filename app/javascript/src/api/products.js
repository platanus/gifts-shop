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
  addProductAction(payload, actionType) {
    const path = '/api/v1/product_actions';

    return api({
      method: 'post',
      url: path,
      data: {
        product_id: payload,
        action_type: actionType,
      },
    });
  },
  shareByEmail(payload, email, link) {
    const path = '/api/v1/product_share';

    return api({
      method: 'post',
      url: path,
      data: {
        product_id: payload,
        product_link: link,
        to_email: email,
        platform: 'email',
      },
    });
  },
};

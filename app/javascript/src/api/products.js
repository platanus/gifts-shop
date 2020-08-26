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
};

import api from './index';

export default {
  products() {
    const path = '/api/v1/products';

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
};

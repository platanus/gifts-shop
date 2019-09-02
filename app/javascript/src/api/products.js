import api from './index';

export default {
  products() {
    const path = '/api/v1/products';

    return api({
      method: 'get',
      url: path,
    });
  },
};

import api from './index';

export default {

  setValue(productId, type) {
    const path = `/api/v1/products/${productId}`;

    return api({
      method: 'put',
      url: path,
      data: {
        type,
      },
    });
  },
};

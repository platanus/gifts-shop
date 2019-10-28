import api from './index';

export default {
  setValue(productId, type) {
    const path = `/api/v1/catalogs/${productId}`;

    return api({
      method: 'put',
      url: path,
      data: {
        type,
      },
    });
  },
};

import api from './index';

export default {
  setPromoted(productId) {
    const path = `/api/v1/catalogs/${productId}`;

    return api({
      method: 'put',
      url: path,
      data: {
        type: 'promoted',
      },
    });
  },
};

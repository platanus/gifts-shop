import api from './index';

export default {

  getStore(storeId) {
    const path = `/api/v1/stores/${storeId}`;

    return api({
      method: 'get',
      url: path,
    });
  },
};

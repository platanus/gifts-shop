/* eslint-disable camelcase */
import api from './index';

export default {
  index(page) {
    const path = `/api/v1/stores?page=${page}`;

    return api({
      method: 'get',
      url: path,
    });
  },
};

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
  addSocialNetworkClick(storeId, socialMedia) {
    const path = `/api/v1/stores/${storeId}/add_social_network_click`;

    return api({
      method: 'post',
      url: path,
      data: {
        social_media: socialMedia,
      },
    });
  },
};

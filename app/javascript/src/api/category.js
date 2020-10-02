import api from './index';

export default {
  getCategory(categoryId) {
    const path = `/api/v1/categories/${categoryId}`;

    return api({
      method: 'get',
      url: path,
    });
  },
};

import api from './index';

export default {
  getReceiver() {
    const path = '/api/v1/receivers/get';

    return api({
      method: 'get',
      url: path,
    });
  },
  deleteSession() {
    const path = '/api/v1/receivers/delete_session';

    return api({
      method: 'delete',
      url: path,
    });
  },
};

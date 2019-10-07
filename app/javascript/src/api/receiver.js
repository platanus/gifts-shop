import api from './index';

export default {
  getReceiver(receiverId) {
    const path = `/api/v1/receivers/${receiverId}`;

    return api({
      method: 'get',
      url: path,
    });
  },
};

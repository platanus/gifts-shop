/* eslint-disable camelcase */
import api from './index';

export default {
  postFeedback(fulfilled, contact) {
    const path = '/api/v1/feedbacks';

    return api({
      method: 'post',
      url: path,
      data: { feedback: {
        fulfilled,
        phone_number: contact,
      },
      },
    });
  },

};

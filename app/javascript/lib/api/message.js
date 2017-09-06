import axios from 'axios'

export default {
  paginate: (uri = '/api/v1/messages') => {
    return axios.get(uri);
  },
  detail: (message_id) => {
    return axios.get('/api/v1/messages/' + message_id);
  },
  create: (token, message, message_buttons, mentions) => {
    return axios.post('/api/v1/messages', {
      authenticity_token: token,
      message: message.message,
      require_confirm: message.require_confirm,
      button_type: message.button_type,
      due_at: message.due_at,
      message_buttons: message_buttons,
      mentions: mentions
    });
  }
}
import axios from 'axios'

export default {
  list: () => {
    return axios.get('/api/v1/messages');
  },
  detail: (message_id) => {
    return axios.get('/api/v1/messages/' + message_id);
  },
  create: (token, message, message_buttons, mentions) => {
    return axios.post('/api/v1/messages', {
      authenticity_token: token,
      message: message.message,
      require_confirm: message.require_confirm,
      due_at: message.due_at,
      message_buttons: message_buttons,
      mentions: mentions
    });
  }
}
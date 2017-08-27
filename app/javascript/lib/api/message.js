import axios from 'axios'

export default {
  list: () => {
    return axios.get('/api/v1/messages');
  },
  create: (message, message_buttons, mentions) => {
    return axios.post('/api/v1/messages', { params: {
      message,
      message_buttons: message_buttons,
      mentions: mentions
    }});
  }
}
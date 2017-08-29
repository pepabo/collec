import axios from 'axios'

export default {
  list: () => {
    return axios.get('/api/v1/slack/users');
  }
}
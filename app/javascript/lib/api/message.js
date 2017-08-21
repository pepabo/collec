import axios from 'axios'

export default {
  list: () => {
    return axios.get('http://localhost:3000/api/v1/messages');
  }
}
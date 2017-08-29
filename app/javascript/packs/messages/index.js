import Vue from 'vue'
import Api from '../../lib/api'
import moment from 'moment'
import _ from 'underscore'
import MessageStatus from '../components/message_status.vue'
import MessageDetail from '../components/messages/detail.vue'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#js-messages__index',
    components: {
      'message_status': MessageStatus,
      'message_detail': MessageDetail
    },
    data: {
      selected_message: null,
      messages: []
    },
    created() {
      this.fetchMessageList()
    },
    methods: {
      fetchMessageList() {
        Api.Message.list().then((response) => {
          this.messages = _.map(response.data, (message) => {
            message.due_at_for_view = moment(message.due_at).format('YYYY/MM/DD HH:mm')
            return message
          })
        })
      },
    }
  })
})

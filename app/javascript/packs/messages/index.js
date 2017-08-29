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
            message.due_at_for_view = moment(message.due_at).format('MM/DD HH:mm')
            return message
          })
        })
      },
    }
  })
})
window.addEventListener('load', () => {
  new Vue({
    el: '#js-messages__index__notification',
    data: {
      show: true
    },
    mounted() {
      this.delayUnload()
    },
    methods: {
      delayUnload() {
        var that = this
        setInterval(function () {
          that.show = false
        }, 1000);
      }
    }
  });
})

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
      is_loaded: false,
      messages: [],
      paging: null
    },
    created() {
      this.fetchMessageList()
    },
    methods: {
      fetchMessageList(page = null) {
        Api.Message.list(page).then((response) => {
          this.messages = _.map(response.data.messages, (message) => {
            message.due_at_for_view = moment(message.due_at).format('MM/DD HH:mm')
            this.is_loaded = true
            return message
          })
          this.paging = response.data.paging
        })
      },
      fetchNextMessages() {
        let next_page = this.paging.current_page + 1
        this.fetchMessageList(next_page)
      },
      fetchPreviousMessages() {
        let previous_page = this.paging.current_page - 1
        this.fetchMessageList(previous_page)
      }
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

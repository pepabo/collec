import Vue from 'vue'
import Api from '../../lib/api'
import $ from 'jquery'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#message_create',
    data: {
      message: '',
      require_confirm: false,
      due_at_year: null,
      due_at_month: null,
      due_at_day: null,
      due_at_hour: null,
      due_at_minute: null,
      messageButtons: [
        {}
      ]
    },
    computed: {
      due_at() {
        return this.due_at_year + '-' + this.due_at_month + '-' + this.due_at_day + ' ' + this.due_at_hour + ':' + this.due_at_minute+ ':00'
      }
    },
    methods: {
      addMessageButton() {
        this.messageButtons.push({})
      },
      removeMessageButton(key) {
        Vue.delete(this.messageButtons, key)
      },
      register() {
        Api.Message.create(
          $("input[name='authenticity_token'").val(),
          {
            message: this.message,
            require_confirm: this.require_confirm,
            due_at: this.due_at
          },
          [
            { text: 'button_name001'}
          ],
          [
            { slack_id: 'UHOGEHOGE', name: 'hypermkt', profile_picture_url: 'http://hogehoge.jp' }
          ]
        )
        window.location.href = '/';
      }
    }
  })
})
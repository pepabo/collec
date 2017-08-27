import Vue from 'vue'
import Api from '../../lib/api'
import $ from 'jquery'

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#message_create',
    data: {
      messageButtons: [
        {}
      ]
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
            message: 'hoge',
            require_confirm: 0,
            due_at: '2017-08-28 10:00:00'
          },
          [
            { text: 'button_name001'}
          ],
          [
            { slack_id: 'UHOGEHOGE', name: 'hypermkt', profile_picture_url: 'http://hogehoge.jp' }
          ]
        )
      }
    }
  })
})
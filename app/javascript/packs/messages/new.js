import Vue from 'vue'

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
      }
    }
  })
})
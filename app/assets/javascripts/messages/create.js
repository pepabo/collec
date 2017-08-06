window.onload = function() {
  new Vue({
    el: '#message_create',
    data: {
      messageButtons: []
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
}
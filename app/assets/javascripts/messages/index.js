var messages = [
  {
    messages_id: 1,
    message: '件名1',
    deadline_at: '2017-01-11 00:00',
    require_confirm: true,
    remind_interval: 1
  },
  {
    messages_id: 2,
    message: '件名2',
    deadline_at: '2017-10-11 00:00',
    require_confirm: false,
    remind_interval: 2
  }
]

var messageButtons = [
  { messages_id: 1, message_button_id: 1, name: "選択肢1", value: 1 },
  { messages_id: 1, message_button_id: 2, name: "選択肢2", value: 2 },
  { messages_id: 1, message_button_id: 3, name: "選択肢3", value: 3 },
  { messages_id: 2, message_button_id: 4, name: "選択肢1", value: 1 },
  { messages_id: 2, message_button_id: 5, name: "選択肢2", value: 2 }
]

var mentionedUsers = [
  { messages_id: 1, mentioned_users_id: 1, mentioned_users: '@user1' },
  { messages_id: 1, mentioned_users_id: 2, mentioned_users: '@user2' },
  { messages_id: 2, mentioned_users_id: 3, mentioned_users: '@user1' },
  { messages_id: 2, mentioned_users_id: 4, mentioned_users: '@user10' },
  { messages_id: 2, mentioned_users_id: 5, mentioned_users: '@user100' }
]

var answers = [
  { message_id:1, ansers_id: 1, mentioned_user_id:1, message_button_id:1 },
  { message_id:2, ansers_id: 2, mentioned_user_id:5, message_button_id:1 }
]

Vue.component('messages-table', {
  template: '#messages-table-template',
  props: {
    data: Array,
    columns: Array,
    filterKey: String
  },
  data: function () {
    var sortOrders = {}
    this.columns.forEach(function (key) {
      sortOrders[key] = 1
    })
    return {
      sortKey: '',
      sortOrders: sortOrders
    }
  },
  computed: {
    filteredData: function () {
      var sortKey = this.sortKey
      var filterKey = this.filterKey && this.filterKey.toLowerCase()
      var order = this.sortOrders[sortKey] || 1
      var data = this.data
      if (filterKey) {
        data = data.filter(function (row) {
          return Object.keys(row).some(function (key) {
            return String(row[key]).toLowerCase().indexOf(filterKey) > -1
          })
        })
      }
      if (sortKey) {
        data = data.slice().sort(function (a, b) {
          a = a[sortKey]
          b = b[sortKey]
          return (a === b ? 0 : a > b ? 1 : -1) * order
        })
      }
      return data
    }
  },
  filters: {
    capitalize: function (str) {
      return str.charAt(0).toUpperCase() + str.slice(1)
    }
  },
  methods: {
    sortBy: function (key) {
      this.sortKey = key
      this.sortOrders[key] = this.sortOrders[key] * -1
    }
  }
})

var messagesTable = new Vue({
  el: '#messages-table',
  data: {
    searchQuery: '',
    gridColumns: ['message', 'deadline_at'],
    gridData: messages
  }
})

var messages = [
  {
    'messages_id': 1,
    'message': '飲み会の参加可否を入力してください！',
    'dut_at': '2017-01-01 10:00'
  },
  {
    'messages_id': 2,
    'message': '歓迎会の参加可否を入力してください！',
    'dut_at': '2017-02-01 10:00'
  },
]

var mentioned_users = [
  {
    'mentioned_user_id': 1,
    'message_id': 1,
    'slack_id': 'takumakume'
  },
  {
    'mentioned_user_id': 2,
    'message_id': 1,
    'slack_id': 'pyama'
  },
  {
    'mentioned_user_id': 3,
    'message_id': 2,
    'slack_id': 'takumakume'
  }
]

var message_buttons = [
  {
    'message_button_id': 1,
    'message_id': 1,
    'text': '参加',
    'name': '62xgk32f7t',
  },
  {
    'message_button_id': 2,
    'message_id': 1,
    'text': '不参加',
    'name': 'mrfesbpusi',
  },
  {
    'message_button_id': 3,
    'message_id': 2,
    'text': '参加',
    'name': 'tp8j5nmr93',
  },
  {
    'message_button_id': 4,
    'message_id': 2,
    'text': '不参加',
    'name': '7ujirtdwpa',
  },
]

var message_answers = [
  {
    'message_answer_id': 1,
    'message_id': 1,
    'mentioned_user_id': 1,
    'message_button_id': 1,
  },
  {
    'message_answer_id': 2,
    'message_id': 1,
    'mentioned_user_id': 2,
    'message_button_id': 2,
  },
  {
    'message_answer_id': 3,
    'message_id': 2,
    'mentioned_user_id': 3,
    'message_button_id': 4,
  },
]

Vue.component('messages-table', {
  template: '#js-index__left__messages__table__template',
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
  el: '#js-index__left__messages__table',
  data: {
    messagesTableSearchQuery: '',
    messagesTableColumns: ['message', 'dut_at'],
    messages: messages
  }
})

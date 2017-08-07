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

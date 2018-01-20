import Vue from 'vue'
import VeeValidate from 'vee-validate';
import Multiselect from 'vue-multiselect'
import Api from '../../lib/api'
import $ from 'jquery'
import moment from 'moment'
import Datepicker from 'vuejs-datepicker';

Vue.use(VeeValidate)

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#message_create',
    components: {
      Multiselect,
      Datepicker
    },
    data: {
      is_loaded: false,
      message: '',
      button_type: 'single',
      require_confirm: false,
      due_at_year: moment().format('YYYY'),
      due_at_month: moment().format('M'),
      due_at_day: moment().format('D'),
      due_at_hour: moment().format('H'),
      due_at_minute: moment().format('mm'),
      messageButtons: [
        { text: '' }
      ],
      slack_users: [],
      selected_slack_users: [],
      selected: "180",
      options: [
        { text: '3 hours later', value: "180" },
        { text: '6 hours later', value: "360" },
        { text: '1 days later', value: "1440" },
        { text: '3 days later', value: "4320" },
        { text: 'other', value: "0" },
      ],
      state: {
        disabled: true,
      },
      customFormatter(date) {
        return moment(date).format('YYYY/MM/DD');
      }
    },
    created() {
      Api.SlackUser.list().then((response) => {
        this.is_loaded = true
        this.slack_users = response.data
      })
    },
    methods: {
      keyupButtonText(key) {
        if(this.messageButtons.length -1 == key && this.messageButtons[key].text != undefined) {
          this.messageButtons.push({})
        }
      },
      removeMessageButton(key) {
        // 最後の一個は削除させない
        if(this.messageButtons.length != 1) {
          Vue.delete(this.messageButtons, key)
        } else if(this.messageButtons.length == 1){
          Vue.set(this.messageButtons, key, "")
        }
      },
      onRemindChange() {
        if(this.selected == 0) {
          this.state.disabled = false
          this.state.date = new Date()
        } else {
          this.state.disabled = true
          this.state.date = null
        }
      },
      register() {
        var last = this.messageButtons.length - 1
        if(this.messageButtons[last].text === undefined && last != 0) {
          this.removeMessageButton(last)
        }

        // カレンダー選択
        if(this.selected == 0) {
          this.due_at =  new Date(this.state.date.getYear(), this.state.date.getMonth(), this.state.date.getDay(), 23, 59)
        } else {
          this.due_at =  new Date(Date.now() + this.selected * 60000)
        }

        this.$validator.validateAll().then(result => {
          if (result) {
            Api.Message.create(
              $("input[name='authenticity_token'").val(),
              {
                message: this.message,
                require_confirm: this.require_confirm,
                due_at: this.due_at,
                button_type: this.button_type
              },
              this.messageButtons,
              this.selected_slack_users
            )
            window.location.href = '/';
            return
          }
          // validation failed.
        }).catch(() => {
          // something went wrong (non-validation related).
        });
      }
    }
  })
})

import Vue from 'vue'
import VeeValidate from 'vee-validate';
import Multiselect from 'vue-multiselect'
import Api from '../../lib/api'
import $ from 'jquery'
import moment from 'moment'

Vue.use(VeeValidate)

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#message_create',
    components: { Multiselect },
    data: {
      message: '',
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
      selected_slack_users: []
    },
    computed: {
      due_at() {
        return this.due_at_year + '-' + this.due_at_month + '-' + this.due_at_day + ' ' + this.due_at_hour + ':' + this.due_at_minute+ ':00'
      }
    },
    created() {
      Api.SlackUser.list().then((response) => {
        this.slack_users = response.data
      })
    },
    methods: {
      addMessageButton() {
        this.messageButtons.push({})
      },
      keyupButtonText(key) {
        if(this.messageButtons.length -1 == key) {
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
      register() {
        this.$validator.validateAll().then(result => {
          if (result) {
            Api.Message.create(
              $("input[name='authenticity_token'").val(),
              {
                message: this.message,
                require_confirm: this.require_confirm,
                due_at: this.due_at
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

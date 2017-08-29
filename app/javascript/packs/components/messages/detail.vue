<template>
  <div>
    <div v-if="isMessageSelected()" class="column is-6">
      {{ selected_message.id }}
      <h3 class="title is-3">Result Report</h3>

      <div v-if="isFetched()">
        <h4 class="title is-4">Answers</h4>
        <div style="width: 300px; height: 300px; margin: auto;">
          <canvas id="result_report"></canvas>
        </div>

        <table class="table" width="100%">
          <tr v-for="answer in this.message.report.answers">
            <td width="40%">{{ answer.text }}</td>
            <td width="10%" nowrap>{{ answer.percentage }}% / {{ answer.count }}</td>
            <td width="50%"><progress class="progress is-danger" value="5" max="100">{{ answer.percentage }}%</progress></td>
          </tr>
        </table>

        <h5 class="title is-5">Voters</h5>
        <table class="table" width="100%">
          <thead>
          <tr>
            <th>アイコン</th>
            <th>回答者</th>
            <th>回答</th>
            <th>回答日時</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td><img src="https://avatars.slack-edge.com/2016-04-01/31165631686_d9eb6d000965c39bfbaa_192.jpg" class="image is-48x48"></td>
            <td>@takumakume</td>
            <td>回答A</td>
            <td>2017-08-03 10:13:10</td>
          </tr>
          <tr>
            <td><img src="https://avatars.slack-edge.com/2015-05-08/4787287488_5cdb45313c223b678927_192.jpg" class="image is-48x48"></td>
            <td>@hypermkt</td>
            <td>回答B</td>
            <td>2017-08-03 10:13:10</td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div v-else>
      select message
    </div>
  </div>
</template>

<script>
import Api from '../../../lib/api'

export default {
  props: ['selected_message'],
  data() {
    return {
      message: null,
    }
  },
  watch: {
    selected_message() {
      this.fetchMessage(this.selected_message)
    }
  },
  methods: {
    isMessageSelected() {
      return this.selected_message !== null
    },
    isFetched() {
      return this.message !== null
    },
    fetchMessage(message) {
      Api.Message.detail(message.id).then((response) => {
        console.log(JSON.stringify(response.data))
        this.message = response.data
      })
    }
  }
}
</script>

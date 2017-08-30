<template>
  <div>
    <div v-if="isMessageSelected()" class="column is-6">
      <h3 class="title is-3">Result Report</h3>

      <div v-if="isFetched()">
        <h4 class="title is-4">Answers</h4>
        <pie-chart :chart-data="chart_data"></pie-chart>

        <table class="table" width="100%">
          <tr v-for="answer in this.message.report.answers">
            <td width="40%">{{ answer.text }}</td>
            <td width="10%" nowrap>{{ answer.percentage }}% / {{ answer.count }}</td>
            <td width="50%"><progress class="progress is-danger" :value="answer.percentage" max="100">{{ answer.percentage }}%</progress></td>
          </tr>
        </table>

        <h5 class="title is-5">Mentioned users</h5>
        <table class="table" width="100%">
          <thead>
          <tr>
            <th>アイコン</th>
            <th>回答者</th>
            <th>回答</th>
            <!--<th>回答日時</th>-->
          </tr>
          </thead>
          <tbody>
          <tr v-for="mention in this.message.report.mentioned">
            <td><img :src="mention.profile_picture_url" class="image is-48x48"></td>
            <td>@{{ mention.name }}</td>
            <td>
              <span v-if="mention.answers.length > 0">
                <p v-for="answer in mention.answers">
                  {{ answer.answer }}
                </p>
              </span>
              <span v-else>
                <p>Not answered</p>
              </span>
            </td>
            <!--<td>2017-08-03 10:13:10</td>-->
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
import PieChart from '../../../lib/chartjs/pie-chart.js'
import _ from 'underscore'

export default {
  props: ['selected_message'],
  components: { PieChart },
  data() {
    return {
      message: null,
      chart_data: null,
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
        this.chart_data = this.createChartData(response.data.report.answers)
      })
    },
    createChartData(answers) {
      return {
        labels: _.map(answers, 'text'),
        datasets: [
          {
            backgroundColor: [
              '#ff6384', // pink
              '#ff9f40', // orange
              '#ffcd56', // yellow
              '#4bc0c0', // green
              '#36a2eb', // blue
              '#9966ff', // purple
              '#c9cbcf', // gray
              '#c9cbcf', // gray
              '#c9cbcf', // gray
              '#c9cbcf', // gray
              '#c9cbcf', // gray
            ],
            data: _.map(answers, 'percentage')
          }
        ]
      }
    }
  }
}
</script>

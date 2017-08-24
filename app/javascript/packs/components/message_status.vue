<template>
  <div>
    <span v-if="this.isCompleted()" class="tag is-info">Completed( {{ this.answer_ratio }} )</span>
    <span v-else class="tag is-primary">In Progress( {{ this.answer_ratio }} )</span>
  </div>
</template>

<script>
import moment from 'moment'

export default {
  props: ['report'],
  computed: {
    answer_ratio() {
      return this.report.answered_count + '/' + this.report.mentioned_count
    }
  },
  methods: {
    isCompleted() {
      return this.report.answered_count >= this.report.mentioned_count
    },
  }
}
</script>

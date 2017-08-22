<template>
  <div>
    <span v-if="this.isCompleted()" class="tag is-info">Completed</span>
    <span v-else class="tag is-primary">In Progress</span>
  </div>
</template>

<script>
import moment from 'moment'

export default {
  props: ['due_at'],
  methods: {
    isCompleted() {
      return moment(this.due_at).isBefore()
    }
  }
}
</script>

<template>
  <div class="searching-history">
    <el-drawer
      :title="title"
      :visible.sync="showing"
      direction="rtl"
      :before-close="handleClose"
    >
      <div class="content">
        <ul>
          <li v-for="item in history">
            {{ item.name }}
            <span class="badge badge-secondary">ID: {{ item.id }}</span>
          </li>
        </ul>
      </div>
    </el-drawer>
  </div>
</template>

<script>
export default {
  name: 'searching-history',
  props: {
    history: {
      type: Array,
      required: true
    },
  },
  data () {
    return {
      showing: false,
      title: 'Searching History (Order by Most Recent)'
    }
  },
  computed: {
    noHistory: function () {
      return false
    }
  },
  methods: {
    showWindow () {
      this.showing = true
    },
    handleClose (done) {
      this.showing = false
      done()
    },
  },
  created: function () {
    eventBus.$on('showSearchingHistoryWindow', () => {
      this.showWindow()
    })
  },
  beforeDestroy: function () {
    eventBus.$off('showSearchingHistoryWindow')
  }
}
</script>

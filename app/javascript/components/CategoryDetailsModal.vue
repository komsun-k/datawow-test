<template>
  <div id="category-details-modal">
    <el-dialog
      :title="category.name || 'Undefined'"
      :visible.sync="showing"
      :before-close="handleClose"
    >
      <table class="table table-sm">
        <thead>
          <tr>
            <th scope="col">Field</th>
            <th scope="col">Value</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th scope="row">ID</th>
            <td>{{ category.id }}</td>
          </tr>
          <tr>
            <th scope="row">First Level Category ID</th>
            <td>{{ category.firstLevelCatId }}</td>
          </tr>
          <tr>
            <th scope="row">Name</th>
            <td>{{ category.name }}</td>
          </tr>
          <tr>
            <th scope="row">Label</th>
            <td>{{ category.label }}</td>
          </tr>
          <tr>
            <th scope="row">Is Leaf</th>
            <td>{{ category.isLeaf }}</td>
          </tr>
          <tr>
            <th scope="row">Cat Property Models</th>
            <td>{{ category.catPropertyModels }}</td>
          </tr>
          <tr>
            <th scope="row">Rules</th>
            <td>{{ category.rules }}</td>
          </tr>
          <tr>
            <th scope="row">Lsc Set Id</th>
            <td>{{ category.lscSetId }}</td>
          </tr>
          <tr>
            <th scope="row">Variation Category</th>
            <td>{{ category.variationCat }}</td>
          </tr>
          <tr>
            <th scope="row">Active</th>
            <td>{{ category.active }}</td>
          </tr>
        </tbody>
      </table>
      <span slot="footer" class="dialog-footer">
        <button
          type="button"
          class="btn btn-dark"
          @click.prevent="closeDialog"
        >Close</button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  name: 'category-details-modal',
  data () {
    return {
      showing: false,
      loading: false,
      category: {
        id: 0,
        name: 'Undefined'
      }
    }
  },
  methods: {
    showDialog (category) {
      this.showing = true
      this.category = category
      this.fetchCategoryDetails()
    },
    closeDialog () {
      this.showing = false
    },
    fetchCategoryDetails () {
      axios.get(`/api/categories/${this.category.id}`)
        .then(response => {
          this.category = response.data.listing
        })
        .catch(error => {
          this.$message({
            message: 'ผิดพลาด: ไม่สามารถดึงข้อมูลได้',
            type: 'error'
          })
        })
        .then(() => {
          this.loading = false
        })
    },
    handleClose(done) {
      done()
    }
  },
  created: function () {
    eventBus.$on('showCategoryDetailsDialog', category => {
      this.showDialog(category)
    })
  },
  beforeDestroy: function () {
    eventBus.$off('showCategoryDetailsDialog')
  }
}
</script>

<template>
  <div>
    <div id="selecting-category" class="shadow-sm">
      <div v-if="form.selectedCategory">
        <strong>Your selecting category</strong>
        <p>{{ form.selectedCategory.name }}</p>
        <p>ID: {{ form.selectedCategory.id }}</p>
      </div>
      <div v-else>
        <strong>No selecting category</strong>
      </div>
      <button
        v-if="selectingItem"
        type="button"
        class="btn btn-sm btn-dark btn-block"
        @click="viewSelectingItemDetails"
      >View Details</button>
      <button
        type="button"
        class="btn btn-sm btn-light btn-block"
        @click="viewHistory"
      >Searching History</button>
    </div>

    <div class="search-wrapper">
      <div class="search-form">
        <el-autocomplete
          popper-class="my-autocomplete"
          v-model="form.selectedCategoryName"
          :fetch-suggestions="querySearch"
          placeholder="Please input"
          @select="handleSelect">
          <i
            class="el-icon-search el-input__icon"
            slot="suffix"
            @click="handleIconClick">
          </i>
          <template slot-scope="{ item }">
            <div class="value">{{ item.name }}</div>
          </template>
        </el-autocomplete>
        <p class="">You can select a main category from dropdown or typing something to search.</p>
      </div>

      <div
        v-if="!selectingItem"
        class="no-search-results"
      >
        <p>คุณสามารถเริ่มต้นการค้นหาได้โดยการเลือกหมวดหมู่หลักจากการคลิก search box เพื่อเปิดตัวเลือก</p>
        <p>หรือสามารถค้นหาจากชื่อหมวดหมู่ เพื่อให้แอพลิเคชันช่วยหาหมวดหมู่ที่ตรงความต้องการของคุณได้</p>
      </div>
      <transition name="fade">
        <div
          v-if="selectingItem"
          class="search-results"
        >
          <h2 class="text-left">Search results</h2>
          <nav aria-label="breadcrumb">
            <ol v-if="loading" class="breadcrumb">
              <li><i class="el-icon-loading"></i></li>
            </ol>
            <ol v-else class="breadcrumb">
              <li
                v-for="ascendant in searchResults.ascendants"
                :key="`ascendant-${ascendant.id}`"
                class="breadcrumb-item"
              >
                <a @click.prevent="navigateAscendant(ascendant)">
                  {{ ascendant.name }}
                </a>
              </li>
              <li
                class="breadcrumb-item active"
                aria-current="page"
              >
                {{ form.selectedCategory.name }}
              </li>
            </ol>
          </nav>

          <p
            v-if="selectingItem && presenceOfSubcategoryListings"
            class="text-left"
          >คุณสามารถเลือกหมวดหมู่ย่อยของ<strong>{{ form.selectedCategory.name }}</strong> ดังรายการต่อไปนี้</p>

          <div
            v-if="loading"
            class="loading-listings"
          ><i class="el-icon-loading"></i> กำลังโหลด{{ form.selectedCategory.name }}</div>
          <div
            v-if="selectingItem && !presenceOfSubcategoryListings && !loading"
            class="no-listings"
          >
            <p><strong>{{ form.selectedCategory.name }}</strong> เป็นหมวดหมู่ย่อยที่สุดแล้ว</p>
            <p>คุณสามารถ<a @click.prevent="viewSelectingItemDetails">เรียกดูรายละเอียดของหมวดหมู่นี้</a>ได้</p>
          </div>
          <div v-if="!loading" class="listings">
            <div
              v-for="category in searchResults.subcategories"
              :key="`child-categories-${category.id}`"
              class="listing"
              @click="selectCategory(category)"
            >
              {{ category.name }}
            </div>
          </div>
        </div>
      </transition>
    </div>

    <category-details-modal></category-details-modal>
    <searching-history :history="searchingHistory"></searching-history>
  </div>
</template>

<script>
import axios from 'axios'
import CategoryDetailsModal from '../components/CategoryDetailsModal.vue'
import SearchingHistory from '../components/SearchingHistory.vue'
export default {
  name: 'homepage',
  components: {
    CategoryDetailsModal,
    SearchingHistory,
  },
  data () {
    return {
      loading: false,
      savedQuery: '',
      rootCategories: [],
      dynamicCategoryOptions: [],
      searchingHistory: [],
      searchResults: {
        ascendants: [],
        subcategories: []
      },
      form: {
        selectedCategory: '',
        selectedCategoryName: '',
      }
    }
  },
  computed: {
    selectingItem: function () {
      return this.form.selectedCategory.name ? true : false
    },
    presenceOfSubcategoryListings: function () {
      return this.searchResults.subcategories.length > 0
    }
  },
  methods: {
    getInlineData () {
      let elementData = document.getElementById('data-inline')
      let rootCategories =
        JSON.parse(elementData.getAttribute('data-inline-root-categories'))

      this.rootCategories = rootCategories.listings
    },
    querySearch (queryString, cb) {
      if (queryString && queryString.length >= 3) {
        // In case no changing a query-string, use the existing search
        // results, and do not fetch.
        if (this.savedQuery === queryString) {
          cb(this.dynamicCategoryOptions)
          return
        }

        this.savedQuery = queryString

        axios.get(`/api/search_requests?q=${queryString.trim()}`)
          .then(response => {
            this.dynamicCategoryOptions = response.data.listings
            cb(this.dynamicCategoryOptions)
          })
          .catch(error => {
            this.$message({
              message: 'ผิดพลาด: ไม่สามารถดึงข้อมูลได้',
              type: 'error'
            })
          })
      } else {
        this.savedQuery = ''
        cb(this.rootCategories)
      }
    },
    handleSelect(item) {
      this.form.selectedCategoryName = this.savedQuery
      this.selectedCategory(item)
      this.fetchCategoryForDrildown(item.id)
    },
    fetchCategoryForDrildown (categoryId) {
      this.loading = true

      axios.get(`/api/search_requests/${categoryId}`)
        .then(response => {
          this.searchResults.ascendants = response.data.ascendants.listings
          this.searchResults.subcategories = response.data.subcategories.listings
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
    handleIconClick(ev) {},
    navigateAscendant (category) {
      this.selectedCategory(category)
      this.fetchCategoryForDrildown(category.id)
    },
    selectCategory (category) {
      this.selectedCategory(category)
      this.fetchCategoryForDrildown(category.id)
    },
    selectedCategory (category) {
      this.form.selectedCategory = category
      this.searchingHistory.unshift(category)
    },
    viewSelectingItemDetails () {
      eventBus.$emit('showCategoryDetailsDialog', this.form.selectedCategory)
    },
    viewHistory () {
      eventBus.$emit('showSearchingHistoryWindow')
    },
  },
  mounted: function () {
    this.getInlineData()
  },
}
</script>

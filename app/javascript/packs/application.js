import Vue from 'vue/dist/vue.esm'

import 'es6-promise/auto'
import axios from 'axios'

import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import langEn from 'element-ui/lib/locale/lang/en'
import langTh from 'element-ui/lib/locale/lang/th'
import locale from 'element-ui/lib/locale'

// Pages
import Homepage from '../pages/Homepage.vue'

window.eventBus = new Vue()
Vue.config.productionTip = false
Vue.use(ElementUI, { langTh, langEn })
locale.use(langEn)

document.addEventListener('DOMContentLoaded', () => {
  axios.defaults.headers.common['X-CSRF-Token'] = document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute('content')

  const app = new Vue({
    el: '#app',
    data() {
      return {
      }
    },
    components: {
      Homepage
    }
  })
})

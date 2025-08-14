import { createApp } from 'vue/dist/vue.esm-bundler.js'
import pageWatcher from '@/src/javascripts/plugins/pageWatcher'
import BaseAlert from '@/src/vueComponents/base/BaseAlert.vue'
import TablesorterSearch from '@/src/vueComponents/base/TablesorterSearch.vue'
import SettingNavbar from '@/src/vueComponents/setting/SettingNavbar.vue'
import UserForm from '@/src/vueComponents/setting/users/UserForm.vue'
import formLeaveConfirm from '@/src/javascripts/plugins/formLeaveConfirm.js'
import setTablesorter from '@/src/javascripts/plugins/setTablesorter.js'

pageWatcher({
  controller: 'setting/users',
  action: ['index', 'new', 'edit'],
  handler: () => {
    const app = document.getElementById('app')
    if (app && !app.__vue_app__) {
      createApp({
        components: {
          BaseAlert,
          SettingNavbar,
          TablesorterSearch,
          UserForm
        },
        methods: {},
        mounted () {
          formLeaveConfirm()
          setTablesorter()
        }
      }).mount(app)
    }
  }
})

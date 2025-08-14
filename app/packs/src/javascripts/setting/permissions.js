import { createApp } from 'vue/dist/vue.esm-bundler.js'
import pageWatcher from '@/src/javascripts/plugins/pageWatcher'
import BaseAlert from '@/src/vueComponents/base/BaseAlert.vue'
import SettingNavbar from '@/src/vueComponents/setting/SettingNavbar.vue'
import PermissionForm from '@/src/vueComponents/setting/permissions/PermissionForm.vue'
import formLeaveConfirm from '@/src/javascripts/plugins/formLeaveConfirm.js'

pageWatcher({
  controller: 'setting/permissions',
  action: ['index', 'new', 'edit'],
  handler: () => {
    const app = document.getElementById('app')
    if (app && !app.__vue_app__) {
      createApp({
        components: { BaseAlert, SettingNavbar, PermissionForm },
        methods: {},
        mounted () {
          formLeaveConfirm()
        }
      }).mount(app)
    }
  }
})

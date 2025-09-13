import { createApp } from 'vue'
import pageWatcher from '@/src/javascripts/plugins/pageWatcher'
import setFlashAlert from '@/src/javascripts/plugins/setFlashAlert.js'
import BaseNavbar from '@/src/vueComponents/base/BaseNavbar.vue'
import ImportForm from '@/src/vueComponents/setting/import/ImportForm.vue'

pageWatcher({
  controller: 'setting/import',
  action: ['index'],
  handler: () => {
    setFlashAlert()

    const navbarApp = document.getElementById('navbar-app')
    if (navbarApp && !navbarApp.__vue_app__) {
      const items = JSON.parse(navbarApp.dataset.items)
      createApp(BaseNavbar, { items }).mount(navbarApp)
    }

    const formApp = document.getElementById('form-app')
    if (formApp && !formApp.__vue_app__) {
      createApp(ImportForm).mount(formApp)
    }
  }
})

import { createApp } from 'vue'
import pageWatcher from '@/src/javascripts/plugins/pageWatcher'
import setFlashAlert from '@/src/javascripts/plugins/setFlashAlert.js'
import BaseNavbar from '@/src/vueComponents/base//BaseNavbar.vue'
import UserForm from '@/src/vueComponents/setting/users/UserForm.vue'
import UserIndexTable from '@/src/vueComponents/setting/users/UserIndexTable.vue'
import UserIndexSearch from '@/src/vueComponents/setting/users/UserIndexSearch.vue'

pageWatcher({
  controller: 'setting/users',
  action: ['index', 'new', 'edit'],
  handler: () => {
    setFlashAlert()

    const navbarApp = document.getElementById('navbar-app')
    if (navbarApp && !navbarApp.__vue_app__) {
      const items = JSON.parse(navbarApp.dataset.items)
      createApp(BaseNavbar, { items }).mount(navbarApp)
    }

    const indexTableApp = document.getElementById('index-table-app')
    if (indexTableApp && !indexTableApp.__vue_app__) {
      const appDatabase = indexTableApp.dataset
      const dataset = {
        users: JSON.parse(appDatabase.users),
        editPerm: JSON.parse(appDatabase.editPerm)
      }
      createApp(UserIndexTable, dataset).mount(indexTableApp)
    }

    const indexSearchApp = document.getElementById('index-search-app')
    if (indexSearchApp && !indexSearchApp.__vue_app__) {
      createApp(UserIndexSearch).mount(indexSearchApp)
    }

    const formApp = document.getElementById('form-app')
    if (formApp && !formApp.__vue_app__) {
      const appDatabase = formApp.dataset
      const dataset = {
        user: JSON.parse(appDatabase.user),
        permissions: JSON.parse(appDatabase.permissions)
      }
      createApp(UserForm, dataset).mount(formApp)
    }
  }
})

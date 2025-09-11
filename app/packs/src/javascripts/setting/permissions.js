import { createApp } from 'vue'
import pageWatcher from '@/src/javascripts/plugins/pageWatcher'
import setFlashAlert from '@/src/javascripts/plugins/setFlashAlert.js'
import BaseNavbar from '@/src/vueComponents/base/BaseNavbar.vue'
import PermissionIndexTable from '@/src/vueComponents/setting/permissions/PermissionIndexTable.vue'
import PermissionForm from '@/src/vueComponents/setting/permissions/PermissionForm.vue'

pageWatcher({
  controller: 'setting/permissions',
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
        permissions: JSON.parse(appDatabase.permissions),
        permissionItems: JSON.parse(appDatabase.permissionItems),
        editPerm: JSON.parse(appDatabase.editPerm)
      }
      createApp(PermissionIndexTable, dataset).mount(indexTableApp)
    }

    const formApp = document.getElementById('form-app')
    if (formApp && !formApp.__vue_app__) {
      const appDatabase = formApp.dataset
      const dataset = {
        permission: JSON.parse(appDatabase.permission),
        permissionItems: JSON.parse(appDatabase.permissionItems)
      }
      createApp(PermissionForm, dataset).mount(formApp)
    }
  }
})

import { createApp } from 'vue'
import pageWatcher from '@/src/javascripts/plugins/pageWatcher'
import IndexPage from '@/src/vueComponents/session/IndexPage.vue'

pageWatcher({
  controller: 'session',
  action: ['index'],
  handler: function () {
    const indexApp = document.getElementById('index-app')
    if (indexApp && !indexApp.__vue_app__) {
      const moduleList = JSON.parse(indexApp.dataset.modules)
      createApp(IndexPage, { moduleList }).mount(indexApp)
    }
  }
})

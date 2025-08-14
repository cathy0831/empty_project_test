import { createApp } from 'vue/dist/vue.esm-bundler.js'
import pageWatcher from '@/src/javascripts/plugins/pageWatcher'
import BaseAlert from '@/src/vueComponents/base/BaseAlert.vue'
import IndexPage from '@/src/vueComponents/session/IndexPage.vue'

pageWatcher({
  controller: 'session',
  action: ['index'],
  handler: function () {
    const app = document.getElementById('app')
    if (app && !app.__vue_app__) {
      createApp({
        components: { BaseAlert, IndexPage },
        mounted () {}
      }).mount(app)
    }
  }
})

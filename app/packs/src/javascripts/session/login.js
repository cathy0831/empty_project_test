import { createApp } from 'vue/dist/vue.esm-bundler.js'
import BaseAlert from '@/src/vueComponents/base/BaseAlert.vue'
import LoginPage from '@/src/vueComponents/session/LoginPage.vue'

const loginApp = document.getElementById('login-app')
if (loginApp && !loginApp.__vue_app__) {
  createApp({
    components: { BaseAlert, LoginPage }
  }).mount(loginApp)
}

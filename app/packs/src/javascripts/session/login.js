import { createApp } from 'vue'
import setFlashAlert from '@/src/javascripts/plugins/setFlashAlert.js'
import LoginPage from '@/src/vueComponents/session/LoginPage.vue'

const loginApp = document.getElementById('login-app')
if (loginApp && !loginApp.__vue_app__) {
  const dataset = loginApp.dataset
  createApp(LoginPage, dataset).mount(loginApp)
}

setFlashAlert()

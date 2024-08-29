import '@hotwired/turbo'
import { hashFnv32a } from '@/src/javascripts/script'
import Vue from 'vue/dist/vue.esm.js'
import vueswal from '@/src/vueComponent/vueSwal.vue'

$(document).ready(function () {
  if (document.body.dataset.controller === 'session') {
    new Vue({
      el: document.getElementById('login-app'),
      components: { vueswal },
      methods: {
        onLogin (event) {
          event.preventDefault()
          const hashpwd = hashFnv32a(
            document.getElementById('login_password').value,
            true
          )
          document.getElementById('login_password').value = hashpwd
          event.target.submit()
        }
      },
      mounted () {
        this.$refs.account.focus()
      }
    })
  }
})

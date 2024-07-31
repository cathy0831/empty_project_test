import jquery from 'jquery'

window.jQuery = jquery
window.$ = jquery

import * as Turbo from '@hotwired/turbo'
/* Turbo 千千萬萬絕對不要刪，會爆掉 */
import Vue from 'vue/dist/vue.esm.js'
import 'tablesorter'

import vueswal from '@/src/vueComponent/vueSwal.vue'
import { Select, AutoComplete } from 'ant-design-vue'
import I18n from 'i18n-js'

I18n.locale = i18n_locale
I18n.translations = i18n_translations
window.I18n = I18n

Vue.use(Select)
Vue.use(AutoComplete)
$(document).on('turbo:load turbo:render', (turboParams) => {
  if (document.getElementById('notice')) {
    new Vue({
      el: document.getElementById('notice'),
      components: {
        vueswal
      },
      mounted: function () {
        $.ajaxSetup({
          headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
          }
        })
      }
    })
  }
  if (turboParams.type === 'turbo:load') {
    if (document.getElementById('page-header')) {
      new Vue({
        el: document.getElementById('page-header'),
        data() {
          return {
            isOpen: false
          }
        },
        methods: {
          toggleLogoutButton() {
            this.isOpen = !this.isOpen
          }
        }
      })
    }

    const $tablesorter = $('.tablesorter')
    $tablesorter.tablesorter({
      duplicateSpan: true,

      widthFixed: true,
      widgets: ['filter'],
      widgetOptions: {
        filter_external: 'input.search',
        filter_reset: '.reset'
      }
    })
  }
})

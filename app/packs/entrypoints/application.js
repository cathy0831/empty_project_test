import * as Turbo from '@hotwired/turbo'
import { I18n } from 'i18n-js'
import '@/src/javascripts/layouts/header.js'
import '@/src/javascripts/session/index.js'
import '@/src/javascripts/setting/users.js'
import '@/src/javascripts/setting/permissions.js'

Turbo.start()

const initializingI18n = () => {
  const i18n = new I18n()
  if (window.i18n_locale) {
    i18n.locale = window.i18n_locale
  }
  if (window.i18n_translations) {
    i18n.translations = window.i18n_translations
  }
  window.I18n = i18n
}
initializingI18n()

import { I18n } from 'i18n-js'
const i18n = new I18n()
const i18nSetupElement = document.getElementById('i18n-setup')

if (i18nSetupElement) {
  const i18nDataset = i18nSetupElement.dataset
  if (i18nDataset.locale) {
    i18n.locale = i18nDataset.locale
  }

  if (i18nDataset.translations) {
    i18n.translations = JSON.parse(i18nDataset.translations)
  }
}

window.I18n = i18n

export default i18n

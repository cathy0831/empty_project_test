import * as Turbo from '@hotwired/turbo'
import '@/src/javascripts/plugins/myI18n.js'
import '@/src/javascripts/layouts/header.js'
import '@/src/javascripts/session/index.js'

/* 僅使用於開發模式 - 動態載入模組 script
 * script 檔案的存放方法與命名方式, 根據 controller 劃分
 * 例如: 基本設定的人員管理, data-controller="setting/users"
 * 該模組使用檔案應為 @/src/javascripts/setting/users.js
 * */
const modules = import.meta.glob('@/src/javascripts/**/*.js')
const moduleCache = {}
const asyncImport = () => {
  const controllerName = document.body.dataset.controller
  if (controllerName) {
    const [mainCtrl, secondCtrl] = controllerName.split('/') || []
    if (!mainCtrl || !secondCtrl) return
    if (moduleCache[controllerName]) return
    const importMod = modules[`/src/javascripts/${mainCtrl}/${secondCtrl}.js`]
    if (!importMod) return
    importMod()
    moduleCache[controllerName] = importMod
  }
}

$(document).on('turbo:load', () => {
  asyncImport()
})

Turbo.start()

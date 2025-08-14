import { createApp, ref, provide } from 'vue'
import BaseAlert from '@/src/vueComponents/base/BaseAlert.vue'
import UserSettingModal from '@/src/vueComponents/layouts/UserSettingModal.vue'

$(document).on('turbo:load turbo:render', () => {
  const pageHeader = document.querySelector('#page-header')
  if (pageHeader && !pageHeader.__vue_app__) {
    const isUserSettingShow = ref(false)
    const openUserSetting = () => {
      isUserSettingShow.value = true
    }

    const isOpen = ref(false)
    const toggleLogoutButton = () => {
      isOpen.value = !isOpen.value
    }

    createApp({
      components: { BaseAlert, UserSettingModal },
      setup () {
        provide('isUserSettingShow', isUserSettingShow)
        return {
          isUserSettingShow,
          openUserSetting,
          isOpen,
          toggleLogoutButton
        }
      }
    }).mount(pageHeader)
  }
})

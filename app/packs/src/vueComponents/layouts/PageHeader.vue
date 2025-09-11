<script setup>
import { ref, computed, toRefs } from 'vue'
import { handleLogout } from '@/src/javascripts/helpers/formHelper.js'
import UserSettingModal from '@/src/vueComponents/layouts/UserSettingModal.vue'

const i18n = I18n

const props = defineProps({
  currentUser: {
    type: Object,
    default: null
  },
  systemName: {
    type: String,
    default: ''
  },
  rootPath: {
    type: String,
    default: '/'
  }
})

const { currentUser, systemName, rootPath } = toRefs(props)

const hasCurrentUser = computed(() => {
  return currentUser.value !== null
})

const isOpen = ref(false)
const isUserSettingShow = ref(false)

const toggleLogoutButton = () => {
  isOpen.value = !isOpen.value
}

const openUserSetting = () => {
  isUserSettingShow.value = true
}
</script>

<template>
  <div class="flex sm:flex-col">
    <div class="flex flex-1 items-stretch justify-between sm:text-sm">
      <h2 class="my-0 flex-1 bg-primary py-3 pl-2 text-2xl font-bold text-white sm:text-xl">
        <div class="flex items-center gap-2">
          <a :href="rootPath" class="flex items-center gap-x-2 no-underline">
            <span class="bottom-0 inline-block px-2 sm:w-[11em] sm:px-1">{{ systemName }}</span>
          </a>
        </div>
      </h2>
      <div
        v-if="hasCurrentUser"
        class="flex max-w-[20em] items-center break-all bg-primary sm:cursor-pointer"
        @click="toggleLogoutButton"
      >
        <p
          class="min-w-[8em] break-all px-4 text-lg font-medium leading-6 text-white sm:flex-wrap sm:px-2 md:text-base"
        >
          {{ `${i18n.t('hello')}, ` }}
          {{ currentUser.name }}
        </p>
        <i class="icon-menu hidden text-lg text-white sm:block sm:pr-1"></i>
      </div>
    </div>
    <div
      v-if="hasCurrentUser"
      :class="[
        'flex text-lg transition duration-150 ease-in-out sm:w-full md:text-base',
        { 'sm:hidden': isOpen }
      ]"
    >
      <div
        class="flex flex-1 cursor-pointer items-center border-x border-gray-300 bg-primary text-white hover:bg-primary/80 sm:border-l-0 sm:border-t"
        @click="openUserSetting"
      >
        <span class="whitespace-nowrap px-4 text-center font-medium sm:w-full sm:py-1">
          變更密碼
        </span>
      </div>
      <button
        type="button"
        class="flex flex-1 cursor-pointer items-center border-gray-300 bg-primary text-white hover:bg-primary/80 sm:border-x-0 sm:border-t"
        @click.prevent="handleLogout"
      >
        <span class="whitespace-nowrap px-4 text-center font-medium sm:w-full sm:py-1"> 登出 </span>
      </button>
    </div>
  </div>

  <!-- 用戶設定模態框 -->
  <UserSettingModal v-if="currentUser" v-model:isShow="isUserSettingShow" />
</template>

<style lang="scss" scoped></style>

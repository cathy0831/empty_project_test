<script setup>
import { toRefs, ref, onMounted } from 'vue'
import myAxios from '@/src/javascripts/plugins/myAxios.js'
import mySwal from '@/src/javascripts/plugins/mySwal.js'
import BaseTextInput from '@/src/vueComponents/base/BaseTextInput.vue'
import BasePasswordInput from '@/src/vueComponents/base/BasePasswordInput.vue'
import { hashFnv32a } from '@/src/javascripts/plugins/script.js'

const props = defineProps({
  systemName: {
    type: String
  },
  loginUrl: {
    type: String
  },
  redirectUrl: {
    type: String
  }
})

const { systemName, loginUrl, redirectUrl } = toRefs(props)
const account = ref('')
const password = ref('')

const onLogin = async (event) => {
  if (!event.target.reportValidity()) return false

  try {
    const response = await myAxios({
      method: 'POST',
      url: loginUrl.value,
      data: {
        account: account.value,
        password: hashFnv32a(password.value, true)
      }
    })

    if (response.status === 0) {
      window.location.replace(redirectUrl.value || '/')
    } else {
      password.value = ''
      mySwal.error({
        title: response.message,
        text: response.error
      })
    }
  } catch (error) {
    password.value = ''
  }
}

onMounted(() => {
  document.querySelector('input[name="account"]')?.focus()
})
</script>

<template>
  <div
    class="w-full max-w-[33rem] rounded-md border border-gray-200 bg-white px-10 pb-16 pt-14 shadow-md sm:px-3"
  >
    <form @submit.prevent="onLogin" autocomplete="off">
      <h2
        class="mb-[1.2rem] flex items-center justify-center gap-3 text-center font-sans text-[1.7em] font-extrabold text-primary"
      >
        <span class="sm:w-[10em]">{{ systemName }}</span>
      </h2>
      <div class="px-4">
        <div class="mb-4 w-full">
          <BaseTextInput
            :label="'員工編號/帳號'"
            :name="'account'"
            v-model="account"
            :enter-prevent="false"
            :no-mask="true"
            required
          />
        </div>
        <div class="mb-8 w-full">
          <BasePasswordInput
            :label="'密碼'"
            :type="'password'"
            :name="'password'"
            v-model="password"
            :enter-prevent="false"
            :no-mask="true"
            required
          />
        </div>
        <div class="flex items-center justify-between">
          <button type="submit" class="custom-primary-button w-full">登入</button>
        </div>
      </div>
    </form>
  </div>
</template>

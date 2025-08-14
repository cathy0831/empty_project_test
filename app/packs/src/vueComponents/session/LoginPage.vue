<script setup>
import { onMounted, ref, nextTick } from 'vue'
import BaseTextInput from '@/src/vueComponents/base/BaseTextInput.vue'
import { hashFnv32a } from '@/src/javascripts/plugins/script.js'

defineProps({
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

const password = ref('')
const onLogin = (event) => {
  if (!event.target.reportValidity()) return false
  password.value = hashFnv32a(password.value, true)
  nextTick(() => {
    event.target.submit()
  })
}

onMounted(() => {
  document.querySelector('input[name="account"]')?.focus()
})
</script>

<template>
  <div
    class="w-full max-w-[33rem] rounded-md border border-gray-200 bg-white px-10 pb-16 pt-14 shadow-md"
  >
    <form
      :action="loginUrl"
      method="post"
      @submit.prevent="onLogin"
      autocomplete="off"
      local="false"
      data-turbo="false"
    >
      <input type="hidden" name="redirect_url" :value="redirectUrl" />
      <div>
        <h2
          class="mb-[1.2rem] flex items-center justify-center gap-3 text-center font-sans text-3xl font-extrabold text-blue-900"
        >
          {{ systemName }}
        </h2>
      </div>
      <div class="px-4">
        <div class="mb-4 w-full">
          <BaseTextInput
            :label="'員工編號/帳號'"
            :name="'account'"
            required
            :enter-prevent="false"
            :no-mask="true"
          />
        </div>
        <div class="mb-8 w-full">
          <BaseTextInput
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

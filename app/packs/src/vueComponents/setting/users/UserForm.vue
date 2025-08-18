<script setup>
import { ref, toRefs, onBeforeMount, computed } from 'vue'
import myAxios from '@/src/javascripts/plugins/myAxios.js'
import mySwal from '@/src/javascripts/plugins/mySwal.js'
import BaseTextInput from '@/src/vueComponents/base/BaseTextInput.vue'
import BasePasswordInput from '@/src/vueComponents/base/BasePasswordInput.vue'
import BaseSelect from '@/src/vueComponents/base/BaseSelect.vue'
import StateRadio from '@/src/vueComponents/base/StateRadio.vue'
import { hashFnv32a } from '@/src/javascripts/plugins/script.js'
import { isNewAction } from '@/src/javascripts/helpers/formHelper.js'
import { visit } from '@hotwired/turbo'

const props = defineProps({
  user: {
    type: Object
  },
  permissions: {
    type: Array,
    default: () => {
      return []
    }
  }
})

const { user, permissions } = toRefs(props)
const userInfo = ref({})
onBeforeMount(() => {
  userInfo.value = { ...user.value }
  if (!isNewAction()) {
    userInfo.value.permission_id = userInfo.value.permission.id
  }
})

const baseUrl = '/setting/users'
const actionHelper = computed(() => {
  if (isNewAction()) {
    return {
      method: 'post',
      url: baseUrl
    }
  } else {
    return {
      method: 'patch',
      url: `${baseUrl}/${userInfo.value.id}`
    }
  }
})

const onSubmitForm = (event) => {
  if (!event.target.reportValidity()) return false
  const userInfoData = {
    state: userInfo.value.state,
    account: userInfo.value.account,
    password: userInfo.value.password ? hashFnv32a(userInfo.value.password, true) : '',
    name: userInfo.value.name,
    email: userInfo.value.email,
    permission_id: userInfo.value.permission_id
  }

  myAxios({
    method: actionHelper.value.method,
    url: actionHelper.value.url,
    data: userInfoData
  }).then((response) => {
    if (response.state < 0) {
      mySwal.error({
        title: response.message
      })
    }
    visit(baseUrl)
  })
}
</script>

<template>
  <form @submit.prevent="onSubmitForm" class="leave-need-confirm" autocomplete="off">
    <div class="mb-4">
      <state-radio v-model="userInfo.state"></state-radio>
      <div class="mb-4 grid grid-cols-2 gap-4 md:grid-cols-1">
        <BaseTextInput
          :label="'帳號'"
          :name="'account'"
          v-model="userInfo.account"
          :maxlength="20"
          required
        />
        <div>
          <p class="flex gap-1 py-1">
            <span class="">密碼</span>
            <span v-if="isNewAction()" class="text-sm font-light text-red-400"> * </span>
            <span v-else>
              <small class="align-middle text-gray-400">若不修改密碼，則毋須填寫此欄位 </small>
            </span>
          </p>
          <BasePasswordInput
            :name="'password'"
            v-model="userInfo.password"
            :required="isNewAction()"
            autocomplete="new-password"
            :minlength="4"
          />
        </div>
        <BaseTextInput
          :label="'名稱'"
          :name="'name'"
          v-model="userInfo.name"
          :maxlength="20"
          required
        />
        <BaseTextInput
          type="email"
          :label="'電子信箱'"
          :name="'email'"
          v-model="userInfo.email"
          :maxlength="50"
        />
        <BaseSelect
          :label="'權限'"
          :name="'permission_id'"
          :optionList="permissions"
          :optionsSelected="userInfo.permission_id"
          :field-names="{ value: 'id', label: 'name' }"
          :placeholder="'請選擇權限'"
          @select="userInfo.permission_id = $event"
          required
        />
      </div>
    </div>
    <div class="custom-button-bar">
      <a href="/setting/users" class="custom-cancel-button">回使用者列表</a>
      <button type="submit" class="custom-primary-button">送出</button>
    </div>
  </form>
</template>

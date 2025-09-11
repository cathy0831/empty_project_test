<script setup>
import { ref, toRefs, onBeforeMount, onMounted, computed } from 'vue'
import myAxios from '@/src/javascripts/plugins/myAxios.js'
import mySwal from '@/src/javascripts/plugins/mySwal.js'
import { hashFnv32a } from '@/src/javascripts/plugins/script.js'
import formLeaveConfirm from '@/src/javascripts/plugins/formLeaveConfirm.js'
import { isNewAction } from '@/src/javascripts/helpers/formHelper.js'
import {
  yupFieldNameValidate,
  reportCustomValidity
} from '@/src/javascripts/helpers/validHelper.js'
import {
  onlyAlphanumericSchema,
  passwordSchema,
  emailSchema
} from '@/src/javascripts/helpers/yupSchemaHelper.js'
import BaseTextInput from '@/src/vueComponents/base/BaseTextInput.vue'
import BasePasswordInput from '@/src/vueComponents/base/BasePasswordInput.vue'
import BaseSelect from '@/src/vueComponents/base/BaseSelect.vue'
import StateRadio from '@/src/vueComponents/base/StateRadio.vue'
import * as yup from 'yup'
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
  if (isNewAction()) {
    userInfo.value.state = 'enable'
  } else {
    userInfo.value.permission_id = userInfo.value.permission.id
  }
})

onMounted(() => {
  formLeaveConfirm()
})

const inputValidate = ref({
  account: { errorState: false, message: '' },
  password: { errorState: false, message: '' },
  email: { errorState: false, message: '' }
})

const schema = yup.object({
  account: onlyAlphanumericSchema,
  password: passwordSchema,
  email: emailSchema
})
const yupValidInputValue = async (fieldName) => {
  inputValidate.value[fieldName] = await yupFieldNameValidate(schema, userInfo.value, fieldName)
}

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
  if (!reportCustomValidity(inputValidate.value)) return false

  mySwal.simpleLoading()
  const userInfoData = {
    ...userInfo.value,
    password: userInfo.value.password ? hashFnv32a(userInfo.value.password, true) : ''
  }

  myAxios({
    method: actionHelper.value.method,
    url: actionHelper.value.url,
    data: userInfoData
  }).then((response) => {
    if (response.status < 0) {
      mySwal.error({
        title: response.message
      })
      return false
    }
    visit(baseUrl)
  })
}
</script>

<template>
  <form @submit.prevent="onSubmitForm" class="leave-need-confirm" autocomplete="off">
    <div class="mb-4">
      <StateRadio v-model="userInfo.state" />
      <div class="mb-4 grid grid-cols-2 gap-4 md:grid-cols-1">
        <BaseTextInput
          :label="'帳號'"
          :name="'account'"
          v-model="userInfo.account"
          :maxlength="20"
          required
          :customValidate="inputValidate.account.errorState"
          :customValidateText="inputValidate.account.message"
          @blur="yupValidInputValue('account')"
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
            :autocomplete="'new-password'"
            :customValidate="inputValidate.password.errorState"
            :customValidateText="inputValidate.password.message"
            @blur="yupValidInputValue('password')"
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
          :label="'電子信箱'"
          :name="'email'"
          v-model="userInfo.email"
          :maxlength="50"
          :customValidate="inputValidate.email.errorState"
          :customValidateText="inputValidate.email.message"
          @blur="yupValidInputValue('email')"
        />
        <BaseSelect
          :label="'權限'"
          :name="'permission_id'"
          :optionList="permissions"
          :optionsSelected="userInfo.permission_id"
          :fieldNames="{ value: 'id', label: 'name' }"
          :placeholder="'請選擇權限'"
          @select="userInfo.permission_id = $event"
          required
        />
      </div>
    </div>
    <div class="custom-button-bar">
      <a :href="baseUrl" class="custom-cancel-button">回使用者列表</a>
      <button type="submit" class="custom-primary-button">送出</button>
    </div>
  </form>
</template>

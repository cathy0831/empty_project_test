<script setup>
import { ref, watch } from 'vue'
import { hashFnv32a } from '@/src/javascripts/plugins/script.js'
import myAxios from '@/src/javascripts/plugins/myAxios.js'
import mySwal from '@/src/javascripts/plugins/mySwal.js'
import {
  yupFieldNameValidate,
  reportCustomValidity
} from '@/src/javascripts/helpers/validHelper.js'
import { passwordSchema } from '@/src/javascripts/helpers/yupSchemaHelper.js'
import BaseDialog from '@/src/vueComponents/base/BaseDialog.vue'
import BasePasswordInput from '@/src/vueComponents/base/BasePasswordInput.vue'
import * as yup from 'yup'

// 支援 v-model 綁定
const props = defineProps({
  isShow: {
    type: Boolean,
    default: false
  }
})

const emit = defineEmits(['update:isShow'])
const isUserSettingShow = ref(props.isShow)

const dialogHelper = ref({
  isDialogOpen: isUserSettingShow.value,
  dialogTitle: '變更密碼'
})

// 監聽 props 變化
watch(
  () => props.isShow,
  (newVal) => {
    isUserSettingShow.value = newVal
    dialogHelper.value.isDialogOpen = newVal
  }
)

const userPassword = ref({
  old_password: '',
  new_password: '',
  confirm_password: ''
})

const inputValid = {
  errorState: false,
  message: ''
}

const inputValidate = ref({
  old_password: { ...inputValid },
  new_password: { ...inputValid },
  confirm_password: { ...inputValid }
})

const resetValidState = (fieldName) => {
  inputValidate.value[fieldName] = { ...inputValid }
}

const closeUserSetting = () => {
  userPassword.value = {
    old_password: '',
    new_password: '',
    confirm_password: ''
  }
  resetValidState('old_password')
  resetValidState('new_password')
  resetValidState('confirm_password')

  emit('update:isShow', false)
}

const checkPasswordSchema = passwordSchema.test('checkPassword', (value) => {
  if (!value) return true
  const newPassword = userPassword.value.new_password
  const confirmPassword = userPassword.value.confirm_password
  if (newPassword && confirmPassword && newPassword !== confirmPassword) {
    const invalidSamePassword = {
      errorState: true,
      message: '請輸入相同密碼'
    }
    inputValidate.value = {
      ...inputValidate.value,
      new_password: { ...invalidSamePassword },
      confirm_password: { ...invalidSamePassword }
    }
    return false
  } else {
    resetValidState('new_password')
    resetValidState('confirm_password')
    return true
  }
})

const schema = yup.object({
  new_password: checkPasswordSchema,
  confirm_password: checkPasswordSchema
})

const yupValidInputValue = async (fieldName) => {
  inputValidate.value[fieldName] = await yupFieldNameValidate(schema, userPassword.value, fieldName)
}

const submitForm = async () => {
  if (!reportCustomValidity(inputValidate.value)) return false
  const { confirm_password, ...rest } = {
    ...userPassword.value,
    old_password: hashFnv32a(userPassword.value.old_password, true),
    new_password: hashFnv32a(userPassword.value.new_password, true)
  }

  try {
    const response = await myAxios({
      method: 'post',
      url: '/reset_password',
      data: rest
    })

    if (response.status === 0) {
      closeUserSetting()
      mySwal
        .success({
          title: response.message
        })
        .then(() => {
          window.location.replace('/login')
        })
    } else {
      inputValidate.value.old_password = {
        errorState: true,
        message: response.error
      }
    }
  } catch (error) {
    console.error('Error:', error)
  }
}
</script>
<template>
  <BaseDialog :dialogHelper="dialogHelper" @closeDialog="closeUserSetting">
    <form @submit.prevent="submitForm" autocomplete="off">
      <div class="flex flex-col gap-y-2 py-4">
        <BasePasswordInput
          :name="'old_password'"
          :label="'舊密碼'"
          v-model="userPassword.old_password"
          :autocomplete="'new-password'"
          required
          noMask
          :customValidate="inputValidate.old_password.errorState"
          :customValidateText="inputValidate.old_password.message"
          @change="resetValidState('old_password')"
        />
        <BasePasswordInput
          :name="'new_password'"
          :label="'新密碼'"
          v-model="userPassword.new_password"
          :autocomplete="'new-password'"
          required
          noMask
          :customValidate="inputValidate.new_password.errorState"
          :customValidateText="inputValidate.new_password.message"
          @blur="yupValidInputValue('new_password')"
        />
        <BasePasswordInput
          :name="'confirm_password'"
          :label="'確認密碼'"
          v-model="userPassword.confirm_password"
          :autocomplete="'new-password'"
          required
          noMask
          :customValidate="inputValidate.confirm_password.errorState"
          :customValidateText="inputValidate.confirm_password.message"
          @blur="yupValidInputValue('confirm_password')"
        />
      </div>
      <div class="flex items-center justify-end gap-4 border-t-2 pt-4">
        <button type="button" class="custom-cancel-button" @click="closeUserSetting">取消</button>
        <button type="submit" class="custom-primary-button">送出</button>
      </div>
    </form>
  </BaseDialog>
</template>
<style lang="scss" scoped></style>

<script setup>
import { ref, inject } from 'vue'
import { hashFnv32a } from '@/src/javascripts/plugins/script.js'
import myAxios from '@/src/javascripts/plugins/myAxios.js'
import mySwal from '@/src/javascripts/plugins/mySwal.js'
import BaseDialog from '@/src/vueComponents/base/BaseDialog.vue'
import BasePasswordInput from '@/src/vueComponents/base/BasePasswordInput.vue'

const dialogHelper = ref({
  isDialogOpen: inject('isUserSettingShow'),
  dialogTitle: '變更密碼'
})

const userPassword = ref({
  old_password: '',
  new_password: '',
  confirm_password: ''
})

const closeUserSetting = () => {
  userPassword.value = {
    old_password: '',
    new_password: '',
    confirm_password: ''
  }

  dialogHelper.value.isDialogOpen = false
  isPasswordUnequal.value = false
}

const isPasswordUnequal = ref(false)

const submitForm = async () => {
  if (userPassword.value.new_password !== userPassword.value.confirm_password) {
    isPasswordUnequal.value = true
  } else {
    isPasswordUnequal.value = false

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
        mySwal.success({
          title: response.message
        })
        closeUserSetting()
      } else {
        mySwal.error({
          title: response.message,
          text: response.error
        })
      }
    } catch (error) {
      console.error('Error:', error)
    }
  }
}
</script>
<template>
  <BaseDialog :dialogHelper="dialogHelper" @closeDialog="closeUserSetting">
    <form @submit.prevent="submitForm">
      <div class="flex flex-col gap-y-2 py-4">
        <BasePasswordInput
          :name="'old_password'"
          :label="'舊密碼'"
          v-model="userPassword.old_password"
          autocomplete="false"
          :no-mask="true"
          required
        />
        <BasePasswordInput
          :name="'new_password'"
          :label="'新密碼'"
          :customValidate="isPasswordUnequal"
          :validateText="'請填寫相同密碼'"
          v-model="userPassword.new_password"
          autocomplete="new-password"
          :no-mask="true"
          required
        />
        <BasePasswordInput
          :name="'confirm_password'"
          :label="'確認密碼'"
          :customValidate="isPasswordUnequal"
          :validateText="'請填寫相同密碼'"
          v-model="userPassword.confirm_password"
          autocomplete="new-password"
          :no-mask="true"
          required
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

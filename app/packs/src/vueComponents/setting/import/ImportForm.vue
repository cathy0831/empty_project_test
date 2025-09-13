<script setup>
import { ref } from 'vue'
import myAxios from '@/src/javascripts/plugins/myAxios.js'
import mySwal from '@/src/javascripts/plugins/mySwal.js'
import StateRadio from '@/src/vueComponents/base/StateRadio.vue'
import { visit } from '@hotwired/turbo'

const importType = ref({
  customer: '客戶資料',
  product: '產品資料'
})

const importInfo = ref({
  import_type: null,
  file: null
})

const fileInput = ref(null)
const resetFile = () => {
  importInfo.value.file = null
  fileInput.value.value = null
}

const uploadFile = (event) => {
  importInfo.value.file = event.target.files[0]
}

const baseUrl = '/setting/import'
const onSubmitForm = (event) => {
  if (!event.target.reportValidity()) return false
  mySwal.simpleLoading()
  myAxios({
    headers: {
      'Content-Type': 'multipart/form-data'
    },
    method: 'POST',
    url: baseUrl,
    data: importInfo.value
  }).then((response) => {
    if (response.status === 0) {
      visit(baseUrl)
    } else {
      mySwal.error({
        title: response.message,
        text: response.error
      })
    }
  })
}
</script>
<template>
  <div class="relative mx-auto border border-solid border-secondary md:mx-0">
    <div class="p-4">
      <form @submit.prevent="onSubmitForm" class="" autocomplete="off">
        <StateRadio
          :label="'類別'"
          v-model="importInfo.import_type"
          :name="'import_type'"
          :stateObj="importType"
          required
        />
        <div class="flex items-center gap-4 pt-4 md:flex-wrap">
          <label class="flex items-center">
            <input
              type="file"
              name="file"
              id="file"
              :accept="'.xlsx'"
              ref="fileInput"
              @change="uploadFile"
              @click="resetFile"
              class="hidden"
            />
            <span class="custom-outline-blue-button">上傳檔案</span>
          </label>
          <p class="break-words sm:px-0">{{ importInfo.file?.name }}</p>
        </div>
        <div class="pt-8">
          <button type="submit" class="custom-primary-button">匯入檔案</button>
        </div>
      </form>
    </div>
  </div>
</template>

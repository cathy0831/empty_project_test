<script setup>
import { ref, toRefs, computed } from 'vue'
import mySwal from '@/src/javascripts/plugins/mySwal.js'

const props = defineProps({
  label: {
    type: String
  },
  projectFileList: {
    type: Array,
    default: () => {
      return []
    }
  },
  acceptFileType: {
    type: String,
    default: '*/*'
  },
  readonly: {
    type: Boolean,
    default: true
  },
  canDeleteProjectFile: {
    type: Boolean,
    default: true
  },
  maxFileSize: {
    type: Number,
    default: 3
  },
  maxFileNum: {
    type: Number,
    default: 2
  },
  showUploadedFile: {
    type: Boolean,
    default: true
  }
})

const { label, projectFileList, readonly, canDeleteProjectFile, maxFileSize, maxFileNum } =
  toRefs(props)
const emit = defineEmits(['deleteProjectFile', 'uploadFile', 'deletePreviewFile'])

const editProjectFileList = ref(projectFileList.value)
function deleteProjectFile (id, fileIndex) {
  editProjectFileList.value = [
    ...editProjectFileList.value.slice(0, fileIndex),
    ...editProjectFileList.value.slice(fileIndex + 1)
  ]

  emit('deleteProjectFile', id)
}

const uploadFilePreviewList = ref([])
const totalFileNum = computed(() => {
  return editProjectFileList.value.length + uploadFilePreviewList.value.length
})

const limitFileAlertList = (fileList) => {
  const alertFileSizeInfo = []
  fileList.forEach((item) => {
    if (item.size > 1024 * 1024 * maxFileSize.value) {
      alertFileSizeInfo.push(item.name)
    }
  })
  return alertFileSizeInfo
}

function uploadFile (event) {
  const files = Array.from(event)
  const fileAlertList = limitFileAlertList(files)
  if (fileAlertList.length > 0) {
    mySwal.error({
      title: '請重新選擇檔案',
      text: `檔案太大，超過 ${maxFileSize.value} MB！`
    })
    event.target.value = ''
    return false
  }

  const list = [...event]
  list.forEach((item) => {
    uploadFilePreviewList.value.push(item)
  })

  if (totalFileNum.value > maxFileNum.value) {
    mySwal.error({
      title: `檔案不得超過 ${maxFileNum.value} 個！`
    })

    if (editProjectFileList.value.length === maxFileNum.value) {
      uploadFilePreviewList.value = []
    } else {
      const previewListStartDeletingAt = totalFileNum.value - uploadFilePreviewList.value.length
      const previewListDeletingNum = totalFileNum.value - maxFileNum.value
      uploadFilePreviewList.value.splice(previewListStartDeletingAt, previewListDeletingNum)
    }
  }

  emit('uploadFile', uploadFilePreviewList.value)
}

const fileInput = ref(null)
function resetFile () {
  // 為了避免檔案重複選取時，change 因相同內容而事件無法觸發(無法選擇重複檔案)
  // 解法參考: https://stackoverflow.com/questions/12030686/html-input-file-selection-event-not-firing-upon-selecting-the-same-file
  fileInput.value.value = null
}

function deletePreviewFile (fileIndex) {
  uploadFilePreviewList.value = [
    ...uploadFilePreviewList.value.slice(0, fileIndex),
    ...uploadFilePreviewList.value.slice(fileIndex + 1)
  ]

  emit('deletePreviewFile', fileIndex)
}
</script>
<template>
  <div class="flex flex-col gap-3">
    <label v-if="label" class="block text-lg font-bold"> {{ label }} </label>
    <div v-if="showUploadedFile" class="border-b-2 py-2">
      <p class="mb-2">已上傳 {{ editProjectFileList.length }} 份檔案:</p>
      <div class="px-5">
        <ul v-for="(file, index) in editProjectFileList" :key="index">
          <li class="flex gap-3 py-2">
            <a
              :href="file.url"
              target="_blank"
              class="text-scp-royal-blue flex flex-1 items-center gap-2 rounded border border-gray-200 p-2 font-bold"
            >
              <i class="icon-report"></i>
              <span>{{ file.name }}</span>
            </a>
            <button
              v-if="!readonly && canDeleteProjectFile"
              @click.prevent="deleteProjectFile(file.id, index)"
              class="flex items-center rounded-md px-1 font-bold text-red-400"
            >
              <i class="icon-trash text-2xl"></i>
            </button>
          </li>
        </ul>
      </div>
    </div>
    <div v-if="!readonly">
      <div class="py-2">
        <p class="mb-2">檔案預覽:</p>
        <div class="px-5">
          <ul v-for="(file, index) in uploadFilePreviewList" :key="index">
            <li class="flex gap-3 py-2">
              <a
                :href="file.url"
                target="_blank"
                class="text-scp-royal-blue flex flex-1 items-center gap-2 rounded border border-gray-200 p-2 font-bold"
              >
                <i class="icon-report"></i>
                <span>{{ file.name }}</span>
              </a>
              <button
                @click.prevent="deletePreviewFile(index)"
                class="flex items-center rounded-md px-1 font-bold text-red-400"
              >
                <i class="icon-trash text-2xl"></i>
              </button>
            </li>
          </ul>
        </div>
      </div>
      <div class="flex items-center gap-3">
        <label class="addButton">
          <input
            type="file"
            :accept="acceptFileType"
            multiple="true"
            direct_upload="true"
            ref="fileInput"
            @change="uploadFile($event.target.files)"
            @click="resetFile"
            class="hidden"
          />
          <i class="icon-plus"></i>
          <span>上傳檔案</span>
        </label>
        <span>目前上傳 {{ uploadFilePreviewList.length }} 份檔案</span>
      </div>
    </div>
  </div>
</template>
<style lang="scss" scoped>
.addButton {
  padding: 0.75rem;
  outline: solid 1px #0e3884;
  border-radius: 0.25rem;
  background-color: #fff;
  color: #0e3884;
  cursor: pointer;
  font-weight: 500;
}
</style>

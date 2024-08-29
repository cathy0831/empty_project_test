<template>
  <div class="flex flex-col gap-3">
    <label v-if="hasLabel" class="block pb-3 font-bold"> {{ label }}</label>
    <div v-if="isPersisted">
      <p class="mb-4">已上傳 {{ projectFileList.length }} 份檔案:</p>
      <div class="flex flex-col gap-3">
        <p
          v-for="(file, index) in projectFileList"
          :key="`projectFile_${index}`"
          class="flex items-center gap-3"
        >
          <button
            v-if="allowDelProjectFile"
            @click.prevent="deleteProjectFile(file.file_id, index)"
            class="deleteButton"
            style="height: fit-content"
          >
            <i class="icon-trash"></i>
          </button>
          <a
            :href="file.url"
            class="block break-all rounded-md border border-green-600 bg-white p-3 text-green-600 hover:shadow-md"
          >
            <span>{{ file.name }}</span>
          </a>
        </p>
      </div>
    </div>
    <div v-if="uploadFilePreviewList.length > 0">
      <p class="mb-4">{{ reviewText }}:</p>
      <div class="flex flex-col gap-3">
        <p
          v-for="(file, index) in uploadFilePreviewList"
          :key="`uploadFile_${index}`"
          class="flex items-center gap-3"
        >
          <button
            @click.prevent="deletePreviewFile(index)"
            class="deleteButton"
            style="height: fit-content"
          >
            <i class="icon-trash"></i>
          </button>
          <span
            class="block break-all rounded-md border border-green-600 bg-white p-3 text-green-600"
          >
            <span>{{ file.name }}</span>
          </span>
        </p>
      </div>
    </div>
    <div class="relative flex items-center gap-3">
      <label
        class="inline-block cursor-pointer rounded-md border border-blue-600 bg-white p-3 text-base text-blue-600 hover:bg-blue-600 hover:text-white"
      >
        <input
          type="file"
          :accept="fileAccept"
          :multiple="multiple"
          direct_upload="true"
          ref="fileInput"
          @change="uploadFile($event)"
          @click="resetFile"
          class="hidden"
        />
        <i class="icon-plus"></i>
        <span>{{ buttonText }}</span>
      </label>
      <span>{{ uploadedText }}</span>
    </div>
    <input
      type="file"
      ref="formFileInput"
      :id="fileId"
      :name="name"
      :multiple="multiple"
      direct_upload="true"
      class="hidden"
    />
  </div>
</template>
<script>
export default {
  props: {
    label: {
      type: String,
      default: () => {
        return '上傳檔案'
      }
    },
    buttonText: {
      type: String,
      default: () => {
        return '選擇檔案'
      }
    },
    reviewText: {
      type: String,
      default: () => {
        return '已選擇的檔案'
      }
    },
    fileId: {
      type: String,
      default: () => {
        return 'files'
      }
    },
    name: {
      type: String,
      default: () => {
        return ''
      }
    },
    fileAccept: {
      type: String,
      default: () => {
        return '*/*'
      }
    },
    multiple: {
      type: Boolean,
      default: () => {
        return false
      }
    },
    initProjectFileList: {
      type: Array,
      default: () => {
        return []
      }
    },
    allowDelProjectFile: {
      type: Boolean,
      default: () => {
        return false
      }
    }
  },
  data () {
    return {
      projectFileList: [],
      uploadFilePreviewList: [],
      deletedFileList: [],
      isPersisted: false
    }
  },
  watch: {
    initProjectFileList: {
      handler: function (newVal) {
        this.projectFileList = [...newVal]
      },
      deep: true
    },
    uploadFilePreviewList: {
      handler: function (newVal) {
        const dataTransfer = new DataTransfer()
        newVal.forEach((file) => {
          dataTransfer.items.add(file)
        })
        this.$refs.formFileInput.files = dataTransfer.files
      },
      deep: true
    }
  },
  computed: {
    hasLabel () {
      return !['', null, undefined].includes(this.label)
    },
    uploadedText () {
      return `選擇 ${this.uploadFilePreviewList.length} 個檔案`
    }
  },
  methods: {
    uploadFile (event) {
      const list = [...event.target.files]
      if (this.multiple) {
        list.forEach((item) => {
          this.uploadFilePreviewList.push(item)
        })
      } else {
        this.uploadFilePreviewList = list
      }
    },
    deletePreviewFile (fileIndex) {
      this.uploadFilePreviewList = [
        ...this.uploadFilePreviewList.slice(0, fileIndex),
        ...this.uploadFilePreviewList.slice(fileIndex + 1)
      ]
    },
    deleteProjectFile (id, fileIndex) {
      this.projectFileList = [
        ...this.projectFileList.slice(0, fileIndex),
        ...this.projectFileList.slice(fileIndex + 1)
      ]

      this.deletedFileList.push(id)
    },
    resetFile () {
      // 為了避免檔案重複選取時，change 因相同內容而事件無法觸發
      // 解法參考: https://stackoverflow.com/questions/12030686/html-input-file-selection-event-not-firing-upon-selecting-the-same-file
      this.$refs.fileInput.value = null
    }
  },
  mounted () {
    this.isPersisted = this.initProjectFileList.length > 0
    this.projectFileList = [...this.initProjectFileList]
  }
}
</script>

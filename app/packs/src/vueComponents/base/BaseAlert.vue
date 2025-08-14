<script setup>
import { toRefs, onMounted } from 'vue'
import mySwal from '@/src/javascripts/plugins/mySwal.js'
const props = defineProps({
  title: {
    type: [String],
    required: true
  },
  text: {
    type: String,
    required: false
  },
  icon: {
    type: String,
    default: 'success'
  },
  type: {
    type: String,
    default: 'toast'
  }
})
const { title, text, icon, type } = toRefs(props)

onMounted(() => {
  if (mySwal[type.value] !== undefined) {
    mySwal[type.value]({
      icon: icon.value,
      title: title.value,
      text: text.value
    })
  }
})
</script>
<template>
  <div></div>
</template>
<style lang="scss" scoped></style>

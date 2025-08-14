<script setup>
import { toRefs } from 'vue'

const props = defineProps({
  dataColumn: {
    type: [String, Number],
    default: 'all'
  },
  placeholder: {
    type: String,
    default: '搜尋...'
  }
})

const { dataColumn, placeholder } = toRefs(props)
</script>
<template>
  <div class="hidden md:block">
    <input
      type="search"
      class="search custom-input mb-2 p-1"
      :data-column="dataColumn"
      :placeholder="placeholder"
    />
  </div>
</template>

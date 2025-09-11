<script setup>
import { toRefs } from 'vue'
import BaseRadio from '@/src/vueComponents/base/BaseRadio.vue'

const props = defineProps({
  label: {
    type: String,
    default: () => {
      return '狀態'
    }
  },
  name: {
    type: String,
    default: () => {
      return 'state'
    }
  },
  stateObj: {
    type: Object
  },
  modelValue: {
    type: [String, Number, Boolean]
  },
  required: {
    type: Boolean,
    default: () => {
      return true
    }
  },
  disabled: {
    type: Boolean
  }
})
const { label, name, stateObj, modelValue, required, disabled } = toRefs(props)

let stateData = {
  enable: I18n.t('enumerize.defaults.state.enable'),
  disable: I18n.t('enumerize.defaults.state.disable')
}

if (stateObj.value) {
  stateData = { ...stateObj.value }
}
</script>
<template>
  <div class="mb-2">
    <p class="flex gap-1">
      <span>{{ label }}</span>
      <span v-if="required" class="text-sm font-light text-red-400">*</span>
    </p>
    <div class="flex gap-4 pt-1">
      <div v-for="(label, key) in stateData" :key="key">
        <BaseRadio
          :label="label"
          :name="name"
          :value="key"
          :required="required"
          :disabled="disabled"
          :modelValue="modelValue"
          @update:modelValue="$emit('update:modelValue', $event)"
        />
      </div>
    </div>
  </div>
</template>
<style lang="scss" scoped></style>

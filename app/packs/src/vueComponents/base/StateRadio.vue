<script setup>
import { toRefs } from 'vue'
import BaseRadio from '@/src/vueComponents/base/BaseRadio.vue'

const props = defineProps({
  name: {
    type: String,
    default: () => {
      return 'state'
    }
  },
  modelValue: {
    type: [String, Number]
  },
  required: {
    type: Boolean
  },
  disabled: {
    type: Boolean
  }
})
const { name, modelValue, required, disabled } = toRefs(props)

const stateList = ['enable', 'disable']
const stateName = (state) => {
  return I18n.t(`enumerize.defaults.state.${state}`)
}
</script>
<template>
  <div class="mb-4">
    <p class="flex gap-1 py-1">
      <span>狀態</span>
      <span class="text-sm font-light text-red-400">*</span>
    </p>
    <div class="flex gap-4">
      <div v-for="state in stateList" :key="state">
        <BaseRadio
          :label="stateName(state)"
          :name="name"
          :value="state"
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

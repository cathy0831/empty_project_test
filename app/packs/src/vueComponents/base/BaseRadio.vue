<script setup>
import { toRefs, computed } from 'vue'

const props = defineProps({
  label: {
    type: String
  },
  name: {
    type: String
  },
  value: {
    type: String
  },
  modelValue: {
    type: [String, Number, Boolean]
  },
  required: {
    type: Boolean
  },
  disabled: {
    type: Boolean
  }
})

const { label, name, value, modelValue, required, disabled } = toRefs(props)
const checkedValue = computed(() => {
  return modelValue.value?.toString() === value.value?.toString()
})
</script>
<template>
  <label class="flex cursor-pointer items-baseline gap-2">
    <input
      type="radio"
      :name="name"
      :value="value"
      :checked="checkedValue"
      @change="$emit('update:modelValue', $event.target.value)"
      class="w3-radio"
      :required="required"
      :disabled="disabled"
    />
    <span>{{ label }}</span>
  </label>
</template>
<style lang="scss" scoped></style>

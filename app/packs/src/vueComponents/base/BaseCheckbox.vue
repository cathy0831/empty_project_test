<script setup>
import { toRefs } from 'vue'

const props = defineProps({
  label: {
    type: String
  },
  name: {
    type: String
  },
  value: {
    type: [String, Number]
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

const { label, name, value, modelValue, required, disabled } = toRefs(props)
</script>
<template>
  <label class="flex cursor-pointer items-baseline gap-2">
    <input
      type="checkbox"
      :name="name"
      :value="value"
      :checked="modelValue === value"
      @change="
        $emit('update:modelValue', { checked: $event.target.checked, value: $event.target.value })
      "
      class="w3-check"
      :required="required"
      :disabled="disabled"
    />
    <span>{{ label }}</span>
  </label>
</template>
<style lang="scss" scoped></style>

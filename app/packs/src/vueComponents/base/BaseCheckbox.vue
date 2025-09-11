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
    type: [String, Number]
  },
  modelValue: {
    type: [String, Number, Array]
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
  if (Array.isArray(modelValue.value)) {
    return new Set(modelValue.value).has(value.value)
  } else {
    return modelValue.value === value.value
  }
})
</script>
<template>
  <label class="flex cursor-pointer items-baseline gap-2">
    <input
      type="checkbox"
      :name="name"
      :value="value"
      :checked="checkedValue"
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

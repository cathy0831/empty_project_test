<script setup>
import { toRefs } from 'vue'

const props = defineProps({
  label: {
    type: String
  },
  name: {
    type: String
  },
  modelValue: {
    type: [String, Number]
  },
  required: {
    type: Boolean
  },
  customValidate: {
    type: Boolean
  },
  customValidateText: {
    type: String
  },
  maxlength: {
    type: Number,
    default: () => {
      return 1000
    }
  },
  noMask: {
    type: Boolean,
    default: () => {
      return false
    }
  }
})

const { label, name, modelValue, required, customValidate, customValidateText, noMask } =
  toRefs(props)
</script>
<template>
  <label>
    <p v-if="label" class="flex gap-1 py-1">
      <span>{{ label }}</span>
      <span v-if="required && !noMask" class="text-sm font-light text-red-400">*</span>
    </p>
    <div>
      <textarea
        ref="textareaRef"
        :name="name"
        :maxlength="maxlength"
        :value="modelValue === 'null' ? null : modelValue"
        @input="$emit('update:modelValue', $event.target.value)"
        class="custom-input"
        :class="{ 'custom-validate-input': customValidate }"
        :required="required"
        autocomplete="off"
        v-bind="$attrs"
      />
      <p v-if="customValidate" class="mb-0 mt-3 text-sm text-red-400">
        {{ customValidateText }}
      </p>
    </div>
  </label>
</template>
<style lang="scss" scoped>
input[type='text'][disabled] {
  color: #212529;
}
</style>

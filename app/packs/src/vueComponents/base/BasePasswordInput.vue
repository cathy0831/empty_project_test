<script setup>
import { toRefs } from 'vue'

import { InputPassword as AInputPassword } from 'ant-design-vue'

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
  validateText: {
    type: String
  },
  maxlength: {
    type: Number,
    default: null
  },
  autocomplete: {
    type: String,
    default: 'off'
  },
  enterPrevent: {
    type: Boolean,
    default: () => {
      return true
    }
  },
  noMask: {
    type: Boolean,
    default: () => {
      return false
    }
  }
})

const { label, name, modelValue, required, customValidate, validateText, enterPrevent, noMask } =
  toRefs(props)
const enterHandler = (event) => {
  if (enterPrevent.value) event.preventDefault()
}
</script>
<template>
  <label>
    <p v-if="label" class="flex items-baseline gap-1 py-1">
      <span>{{ label }}</span>
      <span v-if="required && !noMask" class="text-sm font-light text-red-400">*</span>
    </p>
    <div>
      <input class="hidden" :name="name" :value="modelValue" :required="required" />
      <a-input-password
        ref="passwordInputRef"
        v-bind="$attrs"
        :name="name"
        :maxlength="maxlength"
        :value="modelValue === 'null' ? null : modelValue"
        @input="$emit('update:modelValue', $event.target.value)"
        @keydown.enter="enterHandler"
        class="custom-input"
        :class="{ 'border-2 border-red-400': customValidate }"
        :required="required"
        :autocomplete="autocomplete"
      />
      <p v-if="customValidate" class="mb-0 mt-2 text-sm text-red-400">
        {{ validateText }}
      </p>
    </div>
  </label>
</template>
<style lang="scss" scoped></style>

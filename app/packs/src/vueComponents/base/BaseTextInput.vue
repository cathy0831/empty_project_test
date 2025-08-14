<script setup>
import { toRefs } from 'vue'

const props = defineProps({
  label: {
    type: String
  },
  type: {
    type: String,
    default: 'text'
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
  validate: {
    type: Boolean
  },
  validateText: {
    type: String
  },
  maxlength: {
    type: Number,
    default: null
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

const { label, type, name, modelValue, required, validate, validateText, enterPrevent, noMask } =
  toRefs(props)
const enterHandler = (event) => {
  if (enterPrevent.value) event.preventDefault()
}
</script>
<template>
  <label>
    <p v-if="label" class="flex gap-1 py-1">
      <span>{{ label }}</span>
      <span v-if="required && !noMask" class="text-sm font-light text-red-400">*</span>
    </p>
    <div>
      <input
        ref="inputRef"
        :type="type"
        :name="name"
        :maxlength="maxlength"
        :value="modelValue === 'null' ? null : modelValue"
        @input="$emit('update:modelValue', $event.target.value)"
        @keydown.enter="enterHandler"
        :class="['custom-input', { 'border-2 border-red-400': validate }]"
        :required="required"
        autocomplete="off"
        v-bind="$attrs"
      />
      <p v-if="validate" class="mb-0 mt-3 text-sm text-red-400">
        {{ validateText }}
      </p>
    </div>
  </label>
</template>
<style lang="scss" scoped>
input[type='text'][disabled] {
  color: #212529;
}
</style>

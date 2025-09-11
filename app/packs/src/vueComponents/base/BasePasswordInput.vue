<script setup>
import { toRefs } from 'vue'

import { InputPassword as AInputPassword, ConfigProvider as AConfigProvider } from 'ant-design-vue'

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

const {
  label,
  name,
  modelValue,
  required,
  customValidate,
  customValidateText,
  enterPrevent,
  autocomplete,
  noMask
} = toRefs(props)
const enterHandler = (event) => {
  if (enterPrevent.value) event.preventDefault()
}

const antdConfigTheme = {
  token: {
    colorPrimary: '#4096ff',
    fontSize: '15px',
    fontFamily: 'Verdana,sans-serif'
  }
}
</script>
<template>
  <label :for="name">
    <p v-if="label" class="flex items-baseline gap-1 py-1">
      <span>{{ label }}</span>
      <span v-if="required && !noMask" class="text-sm font-light text-red-400">*</span>
    </p>
    <div class="relative">
      <input
        class="absolute bottom-0 right-1/2 opacity-0"
        :name="name"
        :value="modelValue"
        :required="required"
        tabindex="-1"
      />
      <AConfigProvider :theme="antdConfigTheme">
        <aInputPassword
          ref="passwordInputRef"
          v-bind="$attrs"
          :name="name"
          :id="name"
          :maxlength="maxlength"
          :value="modelValue === 'null' ? null : modelValue"
          @input="$emit('update:modelValue', $event.target.value)"
          @keydown.enter="enterHandler"
          :class="['custom-input', { 'custom-validate-input': customValidate }]"
          :required="required"
          :autocomplete="autocomplete"
        />
      </AConfigProvider>
      <p v-if="customValidate" class="custom-validate-message">
        {{ customValidateText }}
      </p>
    </div>
  </label>
</template>
<style lang="scss" scoped></style>

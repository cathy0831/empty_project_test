<script setup>
import { toRefs } from 'vue'
import { InputNumber as AInputNumber, ConfigProvider as AConfigProvider } from 'ant-design-vue'

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
  unit: {
    type: String
  },
  thousandth: {
    type: Boolean
  },
  customValidate: {
    type: Boolean
  },
  customValidateText: {
    type: String
  }
})

const { label, name, modelValue, required, unit, thousandth, customValidate, customValidateText } =
  toRefs(props)

function formattedValue (value) {
  if (!thousandth.value || [null, undefined].includes(modelValue.value)) {
    return value
  } else {
    // 檢查是否為小數
    if (/^\d+\.\d+$/.test(`${value}`)) {
      const [integerPart, decimalPart] = `${value}`.split('.')
      // 整數部分加上千分位符號，保留小數部分
      return `${integerPart.replace(/\B(?=(\d{3})+(?!\d))/g, ',')}.${decimalPart}`
    } else if (/^0\.\d+$/.test(`${value}`)) {
      // 如果是純小數則保持原樣
      return value
    } else {
      // 整數部分加上千分位符號
      return `${value}`.replace(/\B(?=(\d{3})+(?!\d))/g, ',')
    }
  }
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
      <span v-if="required" class="text-sm font-light text-red-400">*</span>
    </p>
    <div class="relative">
      <!-- 給原生 form 表單 formData 使用的 input 欄位 -->
      <input
        class="absolute inset-x-0 bottom-0 m-auto opacity-0"
        :name="name"
        :value="modelValue"
        :required="required"
        tabindex="-1"
      />
      <AConfigProvider :theme="antdConfigTheme">
        <AInputNumber
          :value="modelValue"
          :name="name"
          :id="name"
          @change="$emit('update:modelValue', $event)"
          :formatter="formattedValue"
          :class="['custom-input', { 'custom-validate-input': customValidate }]"
          :required="required"
          :autocomplete="'off'"
          inputmode="numeric"
          v-bind="$attrs"
        />
      </AConfigProvider>
      <span v-if="unit" class="absolute inset-y-0 right-10 m-auto h-fit text-gray-400">
        {{ unit }}
      </span>
      <p v-if="customValidate" class="custom-validate-message">
        {{ customValidateText }}
      </p>
    </div>
  </label>
</template>
<style lang="scss" scoped>
:deep(.ant-input-number-input) {
  height: auto;
  padding: 0;
}
</style>

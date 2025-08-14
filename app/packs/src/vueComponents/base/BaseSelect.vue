<script setup>
import { toRefs, computed } from 'vue'
/* eslint-disable no-unused-vars */
import {
  Select as ASelect,
  SelectOption as ASelectOption,
  ConfigProvider as AConfigProvider
} from 'ant-design-vue'
import zh_TW from 'ant-design-vue/es/locale/zh_TW'

const props = defineProps({
  label: {
    type: String
  },
  name: {
    type: String
  },
  required: {
    type: Boolean
  },
  multiple: {
    type: Boolean,
    default: false
  },
  minimumResultsForSearch: {
    type: Number,
    default: 10
  },
  optionsSelected: {
    type: [String, Number, Array]
  },
  optionList: {
    type: Array,
    default: () => {
      return []
    }
  },
  fieldNames: {
    type: Object,
    default: () => {
      return { value: 'value', label: 'label' }
    }
  },
  disabled: {
    type: Boolean,
    default: false
  }
})

const {
  label,
  name,
  required,
  multiple,
  minimumResultsForSearch,
  optionsSelected,
  optionList,
  fieldNames,
  disabled
} = toRefs(props)

const filterOption = (input, option) => {
  return option.label.indexOf(input) >= 0
}

const selectMode = computed(() => {
  if (multiple.value) {
    return 'multiple'
  }
  return undefined
})

const matchedOption = computed(() => {
  if (Array.isArray(optionsSelected.value)) {
    return optionsSelected.value
  }
  if (optionsSelected.value === 0) {
    return optionsSelected.value
  }
  if (!optionsSelected.value) {
    return ''
  }
  const matchOption = optionList.value.find((option) => {
    return option[fieldNames.value.value] === optionsSelected.value
  })
  if (matchOption === undefined) {
    return '無該選項'
  }

  return optionsSelected.value
})
</script>
<template>
  <div class="relative">
    <!-- 給原生 form 表單 formData 使用的 input 欄位 -->
    <input
      :name="name"
      :value="matchedOption"
      :required="required"
      class="absolute inset-x-0 bottom-0 m-auto opacity-0"
    />
    <label class="z-10">
      <p v-if="label" class="flex items-baseline gap-1 py-1">
        <span>{{ label }}</span>
        <span v-if="required" class="text-sm font-light text-red-400">*</span>
      </p>
      <div class="w-full">
        <a-config-provider :locale="zh_TW">
          <a-select
            :value="matchedOption"
            :options="optionList"
            :show-search="optionList.length >= minimumResultsForSearch"
            :filter-option="filterOption"
            :field-names="fieldNames"
            :mode="selectMode"
            :disabled="disabled"
            show-arrow
            placeholder="請選擇"
            class="w-full"
            @change="$emit('change', $event)"
            @select="$emit('select', $event)"
            @deselect="$emit('deselect', $event)"
          >
          </a-select>
        </a-config-provider>
      </div>
    </label>
  </div>
</template>
<style lang="scss" scoped>
:deep .ant-select .ant-select-selector {
  min-height: 3rem;
  padding: 0 1rem;
  border-radius: 4px;
  font-size: 1rem;
  line-height: 1.5;

  .ant-select-selection-search-input {
    height: 100%;
  }
  .ant-select-selection-item,
  .ant-select-selection-placeholder {
    display: flex;
    align-items: center;
  }
  .ant-select-selection-item-remove {
    vertical-align: middle;
  }
}
</style>

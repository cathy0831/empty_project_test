<script setup>
import { toRefs, computed } from 'vue'
import { Select as ASelect, ConfigProvider as AConfigProvider } from 'ant-design-vue'
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
  },
  placeholder: {
    type: String
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
  required,
  multiple,
  minimumResultsForSearch,
  optionsSelected,
  optionList,
  fieldNames,
  disabled,
  placeholder,
  noMask
} = toRefs(props)

const filterOption = (input, option) => {
  try {
    return option[fieldNames.value.label].toString().toLowerCase().indexOf(input.toLowerCase()) >= 0
  } catch (error) {
    return false
  }
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
  if (!optionsSelected.value) {
    if (placeholder.value) {
      return undefined
    } else {
      return optionsSelected.value
    }
  }

  const matchOption = optionList.value.find((option) => {
    return option[fieldNames.value.value] === optionsSelected.value
  })
  if (matchOption === undefined) {
    return '無該選項'
  }

  return optionsSelected.value
})

const antdConfigTheme = {
  token: {
    colorPrimary: '#4096ff',
    fontSize: '15px',
    fontFamily: 'Verdana,sans-serif'
  }
}
</script>
<template>
  <div class="relative">
    <!-- 給原生 form 表單 formData 使用的 input 欄位 -->
    <input
      :name="name"
      :value="matchedOption"
      :required="required"
      class="absolute inset-x-0 bottom-0 m-auto opacity-0"
      tabindex="-1"
    />
    <label class="z-10">
      <p v-if="label" class="flex items-baseline gap-1 py-1">
        <span>{{ label }}</span>
        <span v-if="required && !noMask" class="text-sm font-light text-red-400">*</span>
      </p>
      <div class="w-full">
        <AConfigProvider :locale="zh_TW" :theme="antdConfigTheme">
          <ASelect
            :value="matchedOption"
            :options="optionList"
            :showSearch="optionList.length >= minimumResultsForSearch"
            :filterOption="filterOption"
            :fieldNames="fieldNames"
            :mode="selectMode"
            :disabled="disabled"
            showArrow
            :placeholder="placeholder"
            class="w-full"
            @change="$emit('change', $event)"
            @select="$emit('select', $event)"
            @deselect="$emit('deselect', $event)"
          />
        </AConfigProvider>
      </div>
    </label>
  </div>
</template>
<style lang="scss" scoped>
:deep(.ant-select) {
  .ant-select-selector {
    min-height: 3rem;
    padding: 0 0.5rem;
    border-radius: 4px;
    line-height: 1.5;

    .ant-select-selection-search {
      inset-inline-start: 0.5rem;
    }
    .ant-select-selection-search-input {
      height: 100%;
    }
    .ant-select-selection-item,
    .ant-select-selection-placeholder {
      display: flex;
      align-items: center;
    }
    .ant-select-selection-placeholder {
      color: #0000007a;
    }
  }
  .ant-select-arrow {
    margin-top: -0.5rem;
  }
}
</style>
<style lang="scss">
.ant-select-item-option {
  padding: 5px 7px;
}
</style>

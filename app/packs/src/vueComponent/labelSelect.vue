<!--

  <label-select
    v-model=""
    :items=""
    item-value=""
    item-text=""
    label=""
    name=""
    select-class=""
    placeholder=""
    required
    disabled
  ></label-select>

  # 可直接使用 v-model
  # items => 選項Array, item 可以是 object, string, number
  # item-value => 當 item 為 object 時，設定 key 為 option value
  # item-text  => 當 item 為 object 時，設定 key 為 option 文字
  # placeholder => 設定空值時顯示的文字

-->

<template>
  <div
    @mousedown="
      (e) => {
        e.preventDefault()
      }
    "
  >
    <label :for="name" :class="labelClassList" v-if="label !== ''">
      {{ label }}
      <template v-if="required !== undefined && required">
        <span v-if="!noMask" class="text-sm font-light text-red-400"> * </span>
      </template>
    </label>

    <div class="relative w-full">
      <a-select
        ref="labelSelect"
        v-bind="$attrs"
        v-model="innerValue"
        @change="updateValue()"
        :name="name"
        :class="selectClassList"
        :required="required"
        :disabled="disabled"
        :placeholder="placeholder"
        :allowClear="allowClear"
        :defaultValue="undefined"
        :value="undefined"
        :notFoundContent="'無資料'"
        :optionFilterProp="itemText"
        :show-search="items.length > 10"
        :filterOption="filterOption"
        v-on="$listeners"
      >
        <template v-if="itemsValueString">
          <a-select-option v-for="item in items" :value="item" :key="item">{{
            item
          }}</a-select-option>
        </template>
        <template v-else>
          <a-select-option
            v-for="item in items"
            :text="item[itemText]"
            :value="item[itemValue]"
            :key="item[itemValue]"
          >
            {{ item[itemText] }}
          </a-select-option>
        </template>
      </a-select>

      <!-- antd 沒有 required 警示, 用原生input當作必填警示 -->
      <input
        ref="requiredInput"
        v-model="innerValue"
        :name="name"
        class="pointer-events-none absolute bottom-0 left-4 w-1 opacity-0"
        :required="required"
      />
    </div>
  </div>
</template>

<script>
export default {
  props: {
    value: {
      default: () => {
        return undefined
      }
    },
    items: {
      type: Array,
      required: true
    },
    itemValue: {
      type: String
    },
    itemText: {
      type: String
    },
    required: {
      type: Boolean,
      default: () => {
        return false
      }
    },
    disabled: {
      type: [Boolean, String],
      default: undefined
    },
    allowClear: {
      type: [Boolean, String],
      default: undefined
    },
    placeholder: {
      type: String,
      default: () => {
        return '請選擇'
      }
    },
    name: {
      type: String,
      default: () => {
        return ''
      }
    },
    label: {
      type: String,
      default: () => {
        return ''
      }
    },
    selectClass: {
      type: String,
      default: () => {
        return ''
      }
    },
    labelClass: {
      type: String,
      default: () => {
        return ''
      }
    },
    noMask: {
      type: [Boolean, String],
      default: false
    }
  },
  model: {
    prop: 'value',
    event: 'update'
  },
  data () {
    return {
      selectClassList: '',
      labelClassList: 'block pt-5 pb-3',
      innerValue: this.value,
      itemsValueString: false
    }
  },
  watch: {
    value: function (newVal) {
      let setVal = newVal
      if ([null, ''].includes(newVal)) {
        setVal = undefined
      }
      this.innerValue = setVal
    },
    items: function (newVal) {
      if (newVal.length !== 0) {
        if (newVal[0][this.itemValue] === undefined) {
          this.itemsValueString = true
        }
      }
    }
  },
  methods: {
    updateValue () {
      this.$emit('update', this.innerValue)
    },
    filterOption (inputValue, option) {
      return (
        option.data.attrs.text
          .toLowerCase()
          .indexOf(inputValue.toLowerCase()) >= 0
      )
    }
  },
  mounted () {
    if ([null, ''].includes(this.value)) {
      this.innerValue = undefined
    }

    if (this.selectClass !== undefined) {
      this.selectClassList += ' ' + this.selectClass
    }

    if (this.labelClass !== undefined) {
      this.labelClassList += ' ' + this.labelClass
    }

    if (this.items.length !== 0) {
      if (this.items[0][this.itemValue] === undefined) {
        this.itemsValueString = true
      }
    }
  }
}
</script>
<style lang="scss">
/* a-select */
:root {
  --select-border-color: #cbd5e1;
  --option-text-color: #595959;
  --option-background: #dce8f7;
  --focus-shadow: 0 0 0 1px #70abf3;
}

.ant-select {
  font-size: 1rem;
  width: 100%;
  .ant-select-selection__placeholder {
    color: var(--option-text-color);
  }
  .ant-select-selection--single {
    height: auto;
    padding: 0.5rem 0;
  }
  .ant-select-selection--multiple {
    height: auto;
    padding: 0.5rem 0;
    .ant-select-selection__rendered {
      margin-bottom: 0;
    }
    .ant-select-selection__choice__remove {
      font-size: 0.95rem;
    }
  }
  .ant-select-selection {
    border: 1px solid;
    border-color: var(--select-border-color);
    color: var(--option-text-color);
    &:focus {
      box-shadow: var(--focus-shadow) !important;
    }
    &:hover {
      border-color: var(--select-border-color);
    }
  }
}

/* a-select focus */
.ant-select-focused .ant-select-selection,
.ant-select-selection:focus,
.ant-select-selection:active {
  box-shadow: var(--focus-shadow) !important;
}

.ant-select-open .ant-select-selection {
  box-shadow: var(--focus-shadow) !important;
}

/* a-select-option */
.ant-select-dropdown-menu {
  .ant-select-dropdown-menu-item {
    font-size: 1rem;
    padding: 0.75rem 0.7rem;
    &:hover:not(.ant-select-dropdown-menu-item-disabled) {
      background-color: var(--option-background);
    }
  }

  .ant-select-dropdown-menu-item-active:not(.ant-select-dropdown-menu-item-disabled) {
    background-color: var(--option-background);
  }
}

.ant-select-selection__clear {
  right: 15px;
  margin-top: -9px;
  .anticon-close-circle {
    font-size: 1.2rem;
  }
}
</style>

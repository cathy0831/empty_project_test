<!--

  <label-input
    v-model=""
    type=""
    label=""
    name=""
    input-class=""
    placeholder=""
    required
  ></label-input>

  # 可直接使用 v-model
  # placeholder => 設定空值時顯示的文字

-->

<template>
  <div class="">
    <label :for="name" :class="labelClassList" v-if="label !== ''">
      {{ label }}
      <template v-if="required !== undefined && required">
        <span v-if="!noMask" class="text-sm font-light text-red-400"> * </span>
      </template>
    </label>
    <input
      ref="input"
      v-bind="$attrs"
      v-model="innerValue"
      @input="updateValue"
      :name="name"
      :class="inputClassList"
      :required="required"
      :disabled="disabled"
      @keydown.enter.prevent
    />
  </div>
</template>

<script>
export default {
  props: {
    value: {
      default: null
    },
    required: {
      type: Boolean,
      default: false
    },
    disabled: {
      type: [Boolean, String],
      default: undefined
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
    inputClass: {
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
  watch: {
    value: function (newVal) {
      this.innerValue = newVal
    }
  },
  model: {
    prop: 'value',
    event: 'update'
  },
  data () {
    return {
      inputClassList: 'border',
      labelClassList: 'block pt-5 pb-3',
      innerValue: this.value
    }
  },
  methods: {
    updateValue () {
      this.$emit('update', this.innerValue)
    }
  },
  mounted () {
    if (this.inputClass !== undefined) {
      this.inputClassList += ' ' + this.inputClass
    }

    if (this.labelClass !== undefined) {
      this.labelClassList += ' ' + this.labelClass
    }
  }
}
</script>

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
  }
})

const { label, name, modelValue } = toRefs(props)
</script>
<template>
  <label>
    <p v-if="label" class="flex items-baseline gap-1 py-1 text-lg font-bold">
      <span>{{ label }}</span>
      <span v-if="required" class="text-sm font-light text-red-400">*</span>
    </p>
    <div>
      <input
        type="date"
        :name="name"
        :value="modelValue"
        @input="$emit('update:modelValue', $event.target.value)"
        @keydown.enter.prevent
        class="input w-full border border-gray-300 text-lg"
        :required="required"
        v-bind="$attrs"
      />
    </div>
  </label>
</template>
<style lang="scss" scoped>
input[type='date'][disabled] {
  color: #212529;
}
</style>

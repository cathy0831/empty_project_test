<script setup>
import { toRefs } from 'vue'
import { Modal as AModal } from 'ant-design-vue'
const props = defineProps({
  dialogHelper: {
    type: Object,
    default: () => {
      return {}
    }
  }
})
const { dialogHelper } = toRefs(props)
</script>
<template>
  <a-modal
    :open="dialogHelper.isDialogOpen"
    :title="dialogHelper.dialogTitle"
    :maskClosable="true"
    :destroyOnClose="true"
    :footer="null"
    @cancel="$emit('closeDialog')"
  >
    <slot></slot>
  </a-modal>
</template>
<style lang="scss" scoped></style>

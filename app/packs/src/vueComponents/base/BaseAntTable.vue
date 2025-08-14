<script setup>
import { toRefs } from 'vue'
import { Table as ATable } from 'ant-design-vue'

const props = defineProps({
  tableDataList: {
    type: Array,
    default: () => [],
    required: true
  },
  tableHeaderList: {
    type: Array,
    default: () => [],
    required: true
  }
})
const { tableDataList, tableHeaderList } = toRefs(props)

const customSorterLocale = {
  triggerAsc: '點擊升序',
  triggerDesc: '點擊降序',
  cancelSort: '取消排序'
}
</script>
<template>
  <a-table :columns="tableHeaderList" :data-source="tableDataList" :locale="customSorterLocale">
  </a-table>
</template>
<style lang="scss" scoped></style>

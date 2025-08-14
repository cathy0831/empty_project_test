<script setup>
import { toRefs } from 'vue'
import { SearchOutlined } from '@ant-design/icons-vue'

const props = defineProps({
  searchBaseRoute: {
    type: String,
    required: true
  }
})

const { searchBaseRoute } = toRefs(props)
</script>
<template>
  <div class="relative h-fit basis-[250px] rounded-sm border-2 md:w-full">
    <p class="absolute left-1 top-[-0.8rem] mb-1 bg-white px-2 font-bold">搜尋條件</p>
    <form class="min-w-[248px] p-4" :action="searchBaseRoute" accept-charset="UTF-8" method="get">
      <div>
        <div class="mb-4">
          <slot></slot>
        </div>
        <div class="flex justify-between gap-2">
          <a :href="searchBaseRoute" class="custom-cancel-button flex-1 text-center"> 清空 </a>
          <button
            type="submit"
            class="custom-primary-button flex flex-1 items-center justify-center gap-x-2"
          >
            <SearchOutlined />
            查詢
          </button>
        </div>
      </div>
    </form>
  </div>
</template>
<style lang="scss" scoped></style>

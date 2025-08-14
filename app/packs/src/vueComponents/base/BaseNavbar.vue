<script setup>
import { toRefs } from 'vue'

const props = defineProps({
  items: {
    type: Array,
    default: () => {
      return []
      // [{
      //   name: "",
      //   url: "",
      //   controllers: [],
      //   perm: true,
      // }]
    }
  },
  activeClass: {
    type: String,
    default: 'p-4 border-b-[3px] border-tertiary text-system-text-system-gray-5'
  },
  inactiveClass: {
    type: String,
    default: 'p-4 text-system-gray-3 hover:border-b-[3px] hover:border-tertiary/50'
  }
})

const { items, activeClass, inactiveClass } = toRefs(props)

const itemClass = (item) => {
  if (item.controllers.includes(document.body.dataset.controller)) {
    return activeClass.value
  } else {
    return inactiveClass.value
  }
}
</script>
<template>
  <div class="custom-scrollbar overflow-x-auto overflow-y-hidden shadow-md">
    <div class="flex">
      <a
        v-for="item in items"
        :key="item.name"
        :href="item.url"
        :class="['relative block whitespace-nowrap font-bold', itemClass(item)]"
      >
        {{ item.name }}
      </a>
    </div>
  </div>
</template>
<style lang="scss" scoped>
.custom-scrollbar {
  &::-webkit-scrollbar {
    height: 5px;
  }
  &::-webkit-scrollbar-track {
    background-color: theme('colors.gray.100');
    border-radius: 10px;
    margin: 20px 0;
  }
  &::-webkit-scrollbar-thumb {
    border-radius: 10px;
    background-color: theme('colors.gray.300');
  }
}
</style>

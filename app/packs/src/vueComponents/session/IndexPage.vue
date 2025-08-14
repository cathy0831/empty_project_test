<script setup>
import { toRefs } from 'vue'

const props = defineProps({
  moduleList: {
    type: Array,
    default: () => {
      return []
    }
  }
})
const { moduleList } = toRefs(props)
</script>
<template>
  <div class="container mx-auto flex justify-center">
    <div class="max-w-[768px] px-4">
      <div>
        <div class="item-center flex flex-wrap gap-3">
          <template v-for="moduleItem in moduleList">
            <a
              v-if="moduleItem.perm"
              class="session-button"
              :href="moduleItem.link"
              :key="moduleItem.name"
            >
              <i :class="[moduleItem.icon, 'text-[4rem]']"></i>
              <p class="mt-1 whitespace-nowrap text-2xl">{{ moduleItem.name }}</p>
            </a>
          </template>
        </div>
      </div>
    </div>
  </div>
</template>

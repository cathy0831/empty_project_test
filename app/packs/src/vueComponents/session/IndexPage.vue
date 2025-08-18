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
const enableModuleList = moduleList.value.filter((moduleItem) => moduleItem.perm)
const welcomeText = `歡迎使用${I18n.t('system_name')}`
</script>
<template>
  <div class="container mx-auto flex justify-center">
    <div class="max-w-[904px] px-4 md:max-w-[768px]">
      <div>
        <div class="item-center flex flex-wrap gap-3 md:justify-center">
          <template v-for="moduleItem in enableModuleList">
            <a
              v-if="moduleItem.perm"
              class="session-button"
              :href="moduleItem.link"
              :key="moduleItem.name"
            >
              <i :class="[moduleItem.icon, 'text-[4rem]']"></i>
              <p class="mt-1 whitespace-nowrap text-xl">{{ moduleItem.name }}</p>
            </a>
          </template>
          <h2 v-if="enableModuleList.length === 0" class="mt-[2em] font-bold text-primary">
            {{ welcomeText }}
          </h2>
        </div>
      </div>
    </div>
  </div>
</template>

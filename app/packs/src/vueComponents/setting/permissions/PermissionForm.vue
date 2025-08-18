<script setup>
import { ref, toRefs, onBeforeMount, computed } from 'vue'
import myAxios from '@/src/javascripts/plugins/myAxios.js'
import mySwal from '@/src/javascripts/plugins/mySwal.js'
import BaseTextInput from '@/src/vueComponents/base/BaseTextInput.vue'
import BaseCheckbox from '@/src/vueComponents/base/BaseCheckbox.vue'
import StateRadio from '@/src/vueComponents/base/StateRadio.vue'
import { isNewAction } from '@/src/javascripts/helpers/formHelper.js'
import { visit } from '@hotwired/turbo'

const props = defineProps({
  permission: {
    type: Object
  },
  permissionItems: {
    type: Array,
    default: () => []
  }
})
const { permission, permissionItems } = toRefs(props)
const permissionInfo = ref({})
onBeforeMount(() => {
  permissionInfo.value = { ...permission.value, content: permission.value.content }
  if (isNewAction()) {
    permissionInfo.value = {
      ...permissionInfo.value,
      state: 'enable',
      content: permissionItems.value.reduce((acc, item) => {
        const { module, actions } = item
        acc[module] = {}
        actions.forEach((action) => {
          acc[module][action] = null
        })
        return acc
      }, {})
    }
  }
})

const i18nPermName = (permKey) => {
  return I18n.t(`perm_module.${permKey}`)
}

const i18nPermActionName = (actionKey) => {
  return I18n.t(`perm_action.${actionKey}`)
}

const checkAllAction = (permKey) => {
  const moduleActionObj = permissionInfo.value.content[permKey]
  const isAllChecked = Object.values(moduleActionObj).every((actionValue) => actionValue === '1')
  Object.keys(moduleActionObj).forEach((actionKey) => {
    moduleActionObj[actionKey] = isAllChecked ? '0' : '1'
  })
}

const controlSearchAction = ({ checked, value }, permKey, actionKey) => {
  const current = permissionInfo.value.content[permKey]
  const newValue = checked ? value : null
  current[actionKey] = newValue

  // 以下是互相連動邏輯
  if (actionKey === 'edit' && newValue === '1') {
    // 勾選 edit 時，自動同步勾選 search
    current.search = '1'
  }

  if (actionKey === 'search') {
    if (newValue !== '1' && current.edit === '1') {
      // 取消 search 時，若 edit 也已經勾選，則一併取消 edit
      current.edit = null
    }
  }
}

const baseUrl = '/setting/permissions'
const actionHelper = computed(() => {
  if (isNewAction()) {
    return {
      method: 'post',
      url: baseUrl
    }
  } else {
    return {
      method: 'patch',
      url: `${baseUrl}/${permissionInfo.value.id}`
    }
  }
})

const onSubmitForm = async (event) => {
  if (!event.target.reportValidity()) return false

  mySwal.simpleLoading()
  const permissionData = {
    state: permissionInfo.value.state,
    name: permissionInfo.value.name,
    content: JSON.stringify(permissionInfo.value.content)
  }

  try {
    const response = await myAxios({
      method: actionHelper.value.method,
      url: actionHelper.value.url,
      data: permissionData
    })

    if (response.status === 0) {
      visit(baseUrl)
    } else if (response.status === 1) {
      visit('/setting')
    } else if (response.status === 2) {
      visit('/')
    } else {
      mySwal.error({
        title: response.message,
        text: response.error
      })
    }
  } catch (error) {
    console.error('Error:', error)
  }
}
</script>

<template>
  <form @submit.prevent="onSubmitForm" class="leave-need-confirm" autocomplete="off">
    <div class="mb-4 grid grid-cols-2 gap-x-4 gap-y-0 md:grid-cols-1">
      <StateRadio v-model="permissionInfo.state" />
      <BaseTextInput :label="'名稱'" :name="'name'" v-model="permissionInfo.name" required />
    </div>
    <div
      v-if="permissionInfo.content"
      class="mb-4 grid grid-cols-4 rounded-md border border-gray-200 xl:grid-cols-2"
    >
      <div
        v-for="permItem in permissionItems"
        :key="permItem.module"
        class="rounded-none border border-l-0 border-t-0 border-gray-200 p-4"
      >
        <label class="block pb-3 font-bold">
          <span @click="checkAllAction(permItem.module)">
            {{ i18nPermName(permItem.module) }}
          </span>
        </label>
        <div class="flex flex-wrap gap-4">
          <div v-for="actionKey in permItem.actions" :key="`${permItem.module}_${actionKey}`">
            <BaseCheckbox
              :name="`content[${permItem.module}][${actionKey}]`"
              :value="'1'"
              :label="i18nPermActionName(actionKey)"
              :modelValue="permissionInfo.content[permItem.module][actionKey]"
              @update:modelValue="controlSearchAction($event, permItem.module, actionKey)"
            />
          </div>
        </div>
      </div>
    </div>
    <div class="custom-button-bar">
      <a :href="baseUrl" class="custom-cancel-button">回權限列表</a>
      <button type="submit" class="custom-primary-button">送出</button>
    </div>
  </form>
</template>

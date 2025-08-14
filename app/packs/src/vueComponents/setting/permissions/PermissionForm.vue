<script setup>
import { ref, toRefs, onBeforeMount, computed } from 'vue'
import myAxios from '@/src/javascripts/plugins/myAxios.js'
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
  permissionInfo.value = { ...permission.value }
  if (isNewAction()) {
    permissionInfo.value = {
      ...permissionInfo.value,
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

const i18nPermName = (permKey) => {
  return I18n.t(`perm_module.${permKey}`)
}

const i18nPermActionName = (actionKey) => {
  return I18n.t(`perm_action.${actionKey}`)
}

const checkAllAction = (permKey, permObj) => {
  const isAllChecked = Object.values(permObj).every((actionValue) => actionValue === '1')

  Object.keys(permObj).forEach((actionKey) => {
    permObj[actionKey] = isAllChecked ? null : '1'
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

const onSubmitForm = async (event) => {
  if (!event.target.reportValidity()) return false

  const permissionData = {
    state: permissionInfo.value.state,
    name: permissionInfo.value.name,
    content: permissionInfo.value.content
  }

  try {
    const response = await myAxios({
      method: actionHelper.value.method,
      url: actionHelper.value.url,
      data: permissionData
    })

    if (response.state === 0) {
      visit(baseUrl)
    } else if (response.state === 1) {
      visit('/setting')
    } else if (response.state === 2) {
      visit('/')
    }
  } catch (error) {
    console.error('Error:', error)
  }
}
</script>

<template>
  <form @submit.prevent="onSubmitForm" class="leave-need-confirm" autocomplete="off">
    <div class="mb-4 grid grid-cols-2 gap-x-4 gap-y-0 md:grid-cols-1">
      <state-radio v-model="permissionInfo.state"></state-radio>
      <BaseTextInput
        :label="'名稱'"
        :name="'name'"
        v-model="permissionInfo.name"
        :maxlength="20"
        required
      />
    </div>
    <div
      v-if="permissionInfo.content"
      class="mb-4 grid grid-cols-4 rounded-md border border-gray-200 xl:grid-cols-2"
    >
      <div
        v-for="(permObj, permKey) in permissionInfo.content"
        :key="permKey"
        class="rounded-none border border-l-0 border-t-0 border-gray-200 p-4"
      >
        <label class="block pb-3 font-bold">
          <span @click="checkAllAction(permKey, permObj)">
            {{ i18nPermName(permKey) }}
          </span>
        </label>
        <div class="flex flex-wrap gap-4">
          <div v-for="(actionValue, actionKey) in permObj" :key="`${permKey}_${actionKey}`">
            <BaseCheckbox
              :name="`content[${permKey}][${actionKey}]`"
              :value="'1'"
              :label="i18nPermActionName(actionKey)"
              :modelValue="actionValue"
              @update:modelValue="controlSearchAction($event, permKey, actionKey)"
            />
          </div>
        </div>
      </div>
    </div>
    <div class="custom-button-bar">
      <a href="/setting/permissions" class="custom-cancel-button">回權限列表</a>
      <button type="submit" class="custom-primary-button">送出</button>
    </div>
  </form>
</template>

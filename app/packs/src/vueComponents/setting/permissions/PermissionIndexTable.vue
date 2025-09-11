<script setup>
import { toRefs } from 'vue'
const i18n = I18n

const props = defineProps({
  permissions: {
    type: Array,
    default: () => {
      return []
    }
  },
  permissionItems: {
    type: Array,
    default: () => {
      return []
    }
  },
  editPerm: {
    type: Boolean,
    default: () => {
      return false
    }
  }
})

const { permissions, permissionItems, editPerm } = toRefs(props)

const redirectUrl = (id) => {
  return `/setting/permissions/${id}/edit`
}
</script>
<template>
  <table class="w3-table w3-bordered w3-hoverable mb-4">
    <thead class="md:hidden">
      <tr class="custom-thead">
        <th class="w-28"></th>
        <th class="whitespace-nowrap">狀態</th>
        <th class="whitespace-nowrap">群組名稱</th>
        <th v-for="permissionItem in permissionItems" :key="permissionItem.module" class="w-52">
          {{ i18n.t(`perm_module.${permissionItem.module}`) }}
        </th>
      </tr>
    </thead>
    <tbody class="md:flex md:flex-col">
      <tr v-if="permissions.length === 0">
        <td :colspan="3 + permissionItems.length">無資料</td>
      </tr>
      <tr
        v-for="permission in permissions"
        :key="permission.id"
        :class="['md:grid md:grid-cols-3', { 'bg-gray-300': permission.state === 'disable' }]"
      >
        <td data-title="" class="pl-2 align-baseline md:col-span-3">
          <a v-if="editPerm" :href="redirectUrl(permission.id)" class="custom-secondary-button">
            編輯
          </a>
        </td>
        <td data-title="狀態" class="pt-5 align-top md:col-span-3 md:pt-2">
          {{ i18n.t(`enumerize.defaults.state.${permission.state}`) }}
        </td>
        <td
          data-title="群組名稱"
          class="max-w-40 pt-5 align-top md:col-span-3 md:grid md:max-w-full md:grid-cols-3 md:pt-2 md:align-top"
        >
          {{ permission.name }}
        </td>
        <td
          v-for="permissionItem in permissionItems"
          :key="permissionItem.module"
          :data-title="i18n.t(`perm_module.${permissionItem.module}`)"
          class="pt-5 align-top md:col-span-3 md:grid md:grid-cols-3 md:pt-2"
        >
          <div class="md:col-span-2 md:grid md:grid-cols-2">
            <div v-for="action in permissionItem.actions" :key="action" class="flex gap-x-2">
              <i
                v-if="permission.content[permissionItem.module][action] === '1'"
                class="icon-ok text-green-600"
              ></i>
              <i v-else class="icon-cancel-1 text-red-500"></i>
              {{ i18n.t(`perm_action.${action}`) }}
            </div>
          </div>
        </td>
      </tr>
    </tbody>
  </table>
</template>

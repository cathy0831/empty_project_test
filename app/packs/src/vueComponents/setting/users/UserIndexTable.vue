<script setup>
import { toRefs } from 'vue'
const i18n = I18n

const props = defineProps({
  users: {
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

const { users, editPerm } = toRefs(props)

const redirectUrl = (id) => {
  return `/setting/users/${id}/edit`
}
</script>
<template>
  <table class="w3-table w3-bordered w3-hoverable mb-4">
    <thead class="md:hidden">
      <tr class="custom-thead">
        <th class="w-28"></th>
        <th>狀態</th>
        <th>帳號</th>
        <th>姓名</th>
        <th>權限</th>
      </tr>
    </thead>
    <tbody class="md:flex md:flex-col">
      <tr v-if="users.length === 0">
        <td colspan="5">無資料</td>
      </tr>
      <tr
        v-for="user in users"
        :key="user.id"
        :class="['md:grid md:grid-cols-3', { 'bg-gray-300': user.state === 'disable' }]"
      >
        <td data-title="" class="pl-2 md:col-span-3">
          <a v-if="editPerm" :href="redirectUrl(user.id)" class="custom-secondary-button">編輯</a>
        </td>
        <td data-title="狀態" class="pl-2 md:col-span-3">
          {{ i18n.t(`enumerize.defaults.state.${user.state}`) }}
        </td>
        <td
          data-title="帳號"
          class="max-w-40 md:col-span-3 md:grid md:max-w-full md:grid-cols-3 md:align-top"
        >
          {{ user.account }}
        </td>
        <td
          data-title="姓名"
          class="max-w-40 md:col-span-3 md:grid md:max-w-full md:grid-cols-3 md:align-top"
        >
          {{ user.name }}
        </td>
        <td
          data-title="權限"
          class="max-w-40 md:col-span-3 md:grid md:max-w-full md:grid-cols-3 md:align-top"
        >
          {{ user.permission.name }}
        </td>
      </tr>
    </tbody>
  </table>
</template>

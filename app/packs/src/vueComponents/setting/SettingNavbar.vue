<script setup>
import BaseNavbar from '@/src/vueComponents/base/BaseNavbar.vue'
const items = [
  {
    name: '使用者設定',
    url: '/setting/users',
    controllers: ['setting/users'],
    perm: true
  },
  {
    name: '權限設定',
    url: '/setting/permissions',
    controllers: ['setting/permissions'],
    perm: true
  }
]
</script>
<template>
  <base-navbar :items="items"></base-navbar>
</template>

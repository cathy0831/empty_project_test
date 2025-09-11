<script setup>
import { ref, onBeforeMount } from 'vue'
import BaseTableSearch from '@/src/vueComponents/base/BaseTableSearch.vue'
import BaseTextInput from '@/src/vueComponents/base/BaseTextInput.vue'
import { getUrlParams } from '@/src/javascripts/helpers/formHelper.js'

const search = ref({})

onBeforeMount(() => {
  search.value = getUrlParams()
})
</script>
<template>
  <BaseTableSearch :searchBaseRoute="'/setting/users'">
    <BaseTextInput :type="'text'" :label="'帳號'" :name="'account'" v-model="search.account" />
    <BaseTextInput :type="'text'" :label="'姓名'" :name="'name'" v-model="search.name" />
  </BaseTableSearch>
</template>

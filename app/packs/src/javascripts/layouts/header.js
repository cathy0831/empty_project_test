import { createApp } from 'vue'
import PageHeader from '@/src/vueComponents/layouts/PageHeader.vue'

$(document).on('turbo:load turbo:render', () => {
  const pageHeader = document.querySelector('#page-header')
  if (pageHeader && !pageHeader.__vue_app__) {
    const dataset = pageHeader.dataset
    createApp(PageHeader, {
      ...dataset,
      currentUser: JSON.parse(dataset.currentUser)
    }).mount(pageHeader)
  }
})

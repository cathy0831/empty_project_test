import { createApp } from 'vue'
import BaseAlert from '@/src/vueComponents/base/BaseAlert.vue'

const setFlashAlert = () => {
  const notice = document.getElementById('notice')
  if (notice && !notice.__vue_app__) {
    const dataset = notice.dataset
    createApp(BaseAlert, dataset).mount(notice)
  }
}

export default setFlashAlert

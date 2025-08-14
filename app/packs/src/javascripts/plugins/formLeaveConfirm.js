import mySwal from '@/src/javascripts/plugins/mySwal.js'
import '@hotwired/turbo'

let skipLeavePrompt = false
let needConfirmForm = null

const formLeaveConfirm = () => {
  document.removeEventListener('turbo:before-visit', turboBeforeVisitHandler)
  window.removeEventListener('popstate', popstateHandler)

  needConfirmForm = document.querySelector('form.leave-need-confirm')

  if (!needConfirmForm) return

  needConfirmForm.addEventListener('submit', () => {
    skipLeavePrompt = true
  })

  document.addEventListener('turbo:before-visit', turboBeforeVisitHandler)
  window.addEventListener('popstate', popstateHandler)
}

const turboBeforeVisitHandler = async (event) => {
  if (!skipLeavePrompt && needConfirmForm) {
    event.preventDefault()
    const confirmed = await showLeaveConfirm()
    if (confirmed) {
      // 避免 turbo.visit 再次觸發事件導致循環
      window.location.href = event.detail.url
    }
  }
}

const popstateHandler = async (event) => {
  if (!skipLeavePrompt && needConfirmForm) {
    const confirmed = await showLeaveConfirm()
    if (!confirmed) {
      // 避免真的跳轉：歷史狀態已經變了，但你可以手動跳回原來
      history.forward()
    }
  }
}

const showLeaveConfirm = async () => {
  return await mySwal.confirm({
    title: '表單尚未送出，是否確定離開？',
    confirmButtonText: '確定',
    cancelButtonText: '取消'
  })
}

export default formLeaveConfirm

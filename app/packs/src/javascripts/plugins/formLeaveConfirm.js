import mySwal from '@/src/javascripts/plugins/mySwal.js'
import '@hotwired/turbo'

let skipLeavePrompt = false
let needConfirmForm = null

const resetLeaveConfirmState = () => {
  skipLeavePrompt = false
  needConfirmForm = null
}

const formLeaveConfirm = () => {
  document.addEventListener('turbo:visit', resetLeaveConfirmState, { once: true })
  document.removeEventListener('turbo:before-visit', linkLeaveHandler)
  window.removeEventListener('popstate', popstateHandler)

  needConfirmForm = document.querySelector('form.leave-need-confirm')
  if (!needConfirmForm) return

  /*
    popstate 需要使用 pushState 建立歷史狀態才會被觸發
    將當前頁面的 URL 加入歷史，避免瀏覽器 URL 被更改，導致重新整理畫面時轉跳到其他頁面
  */
  window.history.pushState({}, '', window.location.href)

  needConfirmForm.addEventListener('submit', () => {
    /* 送出事件時，略過詢問 */
    skipLeavePrompt = true
  })

  document.addEventListener('turbo:before-visit', linkLeaveHandler)
  window.addEventListener('popstate', popstateHandler)
}

const linkLeaveHandler = async (event) => {
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
  event.preventDefault()
  if (!skipLeavePrompt && needConfirmForm) {
    const confirmed = await showLeaveConfirm()
    if (confirmed) {
      /* 確認上一頁離開時，略過詢問 */
      skipLeavePrompt = true
      history.go(-1)
    } else {
      /*
        因為使用者按下上一頁的當下，瀏覽器就已經執行歷史往前移動
        如果取消離開，還是留著當前畫面，但歷史已經改變
        所以需要再建立歷史狀態，讓歷史回到現在的狀態，避免下一次按上一頁直接跳太多
      */
      window.history.pushState({}, '', window.location.href)
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

import axios from 'axios'
import mySwal from '@/src/javascripts/plugins/mySwal.js'

const instance = axios.create({})

// 加上 CSRF token（從 meta 標籤抓）
const token = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content')
if (token) {
  instance.defaults.headers.common['X-CSRF-Token'] = token
}

// 加上攔截器（可選）
instance.interceptors.response.use(
  (response) => response.data,
  (error) => {
    if (error.response) {
      switch (error.response.status) {
        case 400:
          mySwal.error({ title: '錯誤', text: error.response.data?.message || '錯誤號碼: 400' })
          break
        case 401:
          mySwal.error({
            title: error.response.data?.message || '認證失敗',
            text: '錯誤號碼: 401'
          })
          break
        case 403:
          mySwal
            .error({
              title: '權限錯誤',
              text: '錯誤號碼: 403',
              timer: 3000
            })
            .then(() => {
              const redirectTo = error.response?.data?.url
              if (redirectTo) {
                window.location.replace(redirectTo)
              }
            })
          break
        case 404:
          mySwal.error({ title: '找不到資源', text: '錯誤號碼: 404' })
          break
        case 500:
          mySwal.error({ title: '伺服器錯誤', text: '錯誤號碼: 500' })
          break
        case 503:
          mySwal.error({ title: '服務不可用', text: '錯誤號碼: 503' })
          break
        default:
          mySwal.error({
            title: '錯誤',
            text: error.response.data?.message || `錯誤號碼: ${error.response.status}`
          })
          break
      }
    } else if (!navigator.onLine) {
      alert('網路出了點問題，請重新連線後重整網頁')
    } else {
      mySwal.error({ title: '未知錯誤', text: error.message })
    }

    return Promise.reject(error) // 繼續丟給 catch
  }
)

export default instance

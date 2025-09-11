const isNewAction = () => {
  const action = document.querySelector('body').getAttribute('data-action')
  return action === 'new'
}

const isEditAction = () => {
  const action = document.querySelector('body').getAttribute('data-action')
  return action === 'edit'
}

const noValue = (value) => {
  return ['', null, undefined].includes(value)
}

const getUrlParams = () => {
  const params = new URLSearchParams(window.location.search)
  const result = {}
  for (const [key, value] of params.entries()) {
    result[key] = value
  }
  return result
}

const downloadFileFromUrl = (url, filename = 'file') => {
  const link = document.createElement('a')
  link.href = url
  link.download = filename || url.split('/').pop()
  link.style.display = 'none'

  document.body.appendChild(link)
  link.click()
  document.body.removeChild(link)
}

const handleLogout = () => {
  try {
    const form = document.createElement('form')
    form.method = 'POST'
    form.action = '/logout'

    const methodInput = document.createElement('input')
    methodInput.type = 'hidden'
    methodInput.name = '_method'
    methodInput.value = 'DELETE'

    const csrfToken = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content')
    if (csrfToken) {
      const csrfInput = document.createElement('input')
      csrfInput.type = 'hidden'
      csrfInput.name = 'authenticity_token'
      csrfInput.value = csrfToken
      form.appendChild(csrfInput)
    }

    form.appendChild(methodInput)
    document.body.appendChild(form)
    form.submit()
  } catch (error) {
    console.error('登出錯誤:', error)
  }
}

export { isNewAction, isEditAction, noValue, getUrlParams, downloadFileFromUrl, handleLogout }

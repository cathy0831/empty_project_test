const isNewAction = () => {
  const action = document.querySelector('body').getAttribute('data-action')
  return action === 'new'
}

export { isNewAction }

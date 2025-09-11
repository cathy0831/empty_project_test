import '@hotwired/turbo'

const pageWatcher = ({ controller, action, handler }) => {
  if (!controller || !action || !handler) {
    console.warn('[PageWatcher] - Missing controller, action, or handler:', {
      controller,
      action,
      handler
    })
    return
  }

  const handleTurboEvent = (event) => {
    const body = document.body
    const windowAction = body.getAttribute('data-action')
    const windowController = body.getAttribute('data-controller')

    const actionMatches =
      (typeof action === 'string' && windowAction === action) ||
      (Array.isArray(action) && action.includes(windowAction))

    if (windowController === controller && actionMatches && typeof handler === 'function') {
      handler(event)
    }
  }

  $(document).on('turbo:load turbo:render', handleTurboEvent)

  if (import.meta.env.DEV) {
    /* 只有在開發模式下需要直接觸發 */
    handleTurboEvent()
  }
}

export default pageWatcher

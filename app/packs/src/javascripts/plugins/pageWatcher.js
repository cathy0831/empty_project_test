import * as Turbo from '@hotwired/turbo'
const pageWatcher = class classPageWatcher {
  constructor(params) {
    if (params.controller && params.action && params.handler) {
      this.watchAndEffect(params)
    } else {
      console.log('[pageWatcher] - undefined controoler, action or handler.', params)
    }
  }

  watchAndEffect = function (params) {
    const _this =
      /* 如果使用 turbo:render 會出現無法使用套件的錯誤 */
      $(document).on('turbo:load', function (turbolinkParams) {
        const windowAction = $('body').attr('data-action')
        const windowController = $('body').attr('data-controller')
        // _this.activation()
        if (
          windowController === params.controller &&
          ((typeof params.action === 'string' && windowAction === params.action) ||
            (Array.isArray(params.action) && params.action.includes(windowAction))) &&
          typeof params.handler === 'function'
        ) {
          params.handler(turbolinkParams)
        }
      })
  }

  activation = function () {
    //   logout()
    //   $('[data-toggle="tooltip"]').tooltip({
    //     placement: 'right'
    //   })
  }
}

export default pageWatcher

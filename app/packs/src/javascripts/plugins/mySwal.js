import swal from 'sweetalert2'

const customStyleClass = 'customSwal'
const customSwal = function () {
  const mixinSwal = swal.mixin({
    title: '',
    text: '',
    customClass: {
      container: customStyleClass
    },
    buttonsStyling: true,
    confirmButtonText: '確認',
    cancelButtonText: '取消',
    reverseButtons: true
  })
  mixinSwal.simpleLoading = function (title = undefined) {
    if (typeof (title) === 'boolean' && !title) {
      mixinSwal.close()
      return false
    }
    let containerClass = title ? `simpleLoading withTitle` : 'simpleLoading'
    containerClass += ` ${customStyleClass}`
    mixinSwal.fire({
      title,
      text: '',
      allowOutsideClick: false,
      customClass: {
        container: containerClass
      },
      didOpen: () => {
        mixinSwal.showLoading()
      }
    })
  }
  mixinSwal.confirm = async function (opt = { title: '', text: '', icon: 'question'}) {
    return await mixinSwal.fire({...opt, ...{
      showCancelButton: true,
      focusCancel: true
    }})
      .then((result) => {
        return result.isConfirmed
      })
  }
  mixinSwal.input = async function (opt) {
    return await mixinSwal.fire({...{
      input: 'text',
      showCancelButton: true
    }, ...opt})
  }
  mixinSwal.error = async function (opt = { title: '', text: ''}) {
    return mixinSwal.fire({...opt, ...{
      icon: 'error'
    }})
  }
  mixinSwal.success = async function (opt = { title: '', text: ''}) {
    return mixinSwal.fire({...opt, ...{
      icon: 'success',
      timer: 5000
    }})
  }
  mixinSwal.toast = function (opt) {
    mixinSwal.fire({...opt, ...{
          toast: true,
          icon: 'success',
          position: 'top-end',
          customClass: {
            container: 'toast'
          },
          showConfirmButton: false,
          timer: 3000,
          timerProgressBar: true,
          didOpen: (toast) => {
            toast.addEventListener('mouseenter', swal.stopTimer)
            toast.addEventListener('mouseleave', swal.resumeTimer)
            toast.addEventListener('click', () => {
              swal.close()
              swal.toggleTimer()
            })
          }
        }})
  }
  mixinSwal.warning = async function (opt = { title: '', text: ''}) {
    return mixinSwal.fire({...opt, ...{
      icon: 'warning'
    }})
  }
  return mixinSwal
}

const mySwal = customSwal()

export default mySwal
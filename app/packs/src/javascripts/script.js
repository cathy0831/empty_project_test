function validPhone (data) {
  const reg = /((?=(09))[0-9]{10})$/
  const status = reg.test(data)
  return status
}

function validIP (data) {
  const reg =
    /^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])$/
  const status = reg.test(data)
  return status
}
/**
 * valiad  email
 */
function valiadEmail (data) {
  const reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+$/
  const status = reg.test(data)
  return status
}
/**
 * valiad  car index
 */
function valiadCarIndex (data) {
  const reg = /^[A-Z0-9]{2,3}\-[0-9]{3,4}$|^[0-9]{3,4}\-[A-Z0-9]{2,3}$/
  const status = reg.test(data)
  return status
}

function hashFnv32a (str, asString, seed) {
  /* jshint bitwise:false */
  let i
  let l
  let hval = seed === undefined ? 0x811c9dc5 : seed

  for (i = 0, l = str.length; i < l; i++) {
    hval ^= str.charCodeAt(i)
    hval += (hval << 1) + (hval << 4) + (hval << 7) + (hval << 8) + (hval << 24)
  }
  if (asString) {
    // Convert to 8 digit hex string
    return ('0000000' + (hval >>> 0).toString(16)).substr(-8)
  }
  return hval >>> 0
}
/* Tab display function */
function tabDisplay (default_tab = 0) {
  $('ul.tabs li').removeClass('active')

  // 預設顯示第一個 Tab
  const _showTab = default_tab
  const $defaultLi = $('ul.tabs li').eq(_showTab).addClass('active')
  $($defaultLi.find('a').attr('href')).show()
  $($defaultLi.find('a').attr('href')).siblings().hide()

  // 當 li 頁籤被點擊時...
  // 若要改成滑鼠移到 li 頁籤就切換時, 把 click 改成 mouseover
  $('ul.tabs li')
    .click(function () {
      // 找出 li 中的超連結 href(#id)
      const $this = $(this)
      const _clickTab = $this.find('a').attr('href')
      // 把目前點擊到的 li 頁籤加上 .active
      // 並把兄弟元素中有 .active 的都移除 class
      $this.addClass('active').siblings('.active').removeClass('active')
      // 淡入相對應的內容並隱藏兄弟元素
      $(_clickTab)
        .stop(false, true)
        .fadeIn(function () {
          $(this).trigger('fadeInComplete')
        })
        .siblings()
        .hide()
      return false
    })
    .find('a')
    .focus(function () {
      this.blur()
    })
}

function indexPad (n, width, z) {
  width = width || 3
  z = z || '0'
  n = n + ''
  return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n
}
export { hashFnv32a, validPhone, validIP, valiadEmail, valiadCarIndex, tabDisplay, indexPad }

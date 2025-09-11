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
 * valid  car index
 */
function validCarIndex (data) {
  const reg = /^[A-Z0-9]{2,3}-[0-9]{3,4}$|^[0-9]{3,4}-[A-Z0-9]{2,3}$/
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

function indexPad (n, width, z) {
  width = width || 3
  z = z || '0'
  n = n + ''
  return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n
}

function numberWithCommas (num) {
  return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
}

export { hashFnv32a, validPhone, validIP, validCarIndex, indexPad, numberWithCommas }

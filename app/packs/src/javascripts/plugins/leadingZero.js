// @ params
// n: number
// length: return string length
export default function (n, length = 2) {
  n = n + ''
  for (let i = n.length; i < length; i++) {
    n = '0' + n
  }
  return n
}
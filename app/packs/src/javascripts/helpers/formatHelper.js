import dayjs from 'dayjs'

const formatNumber = (number) => {
  /*
   * 格式化數字千位數
   * @param number - 數字
   */
  if (!this.hasValue(number)) return ''
  return new Intl.NumberFormat('en', {
    minimumSignificantDigits: 1
  }).format(number)
}

const formatDate = (date, formatString) => {
  /*
   * 格式化日期
   * @param date - 日期
   * @param formatString - 格式化字串格式
   */
  if ([null, '', undefined].includes(date)) return ''
  const formatDateString = formatString || 'YYYY-MM-DD'
  return dayjs(date).format(formatDateString)
}

const formatDateTime = (dateTime, formatString) => {
  /*
   * 格式化日期時間
   * @param dateTime - 日期時間
   * @param formatString - 格式化字串格式
   */
  if ([null, '', undefined].includes(dateTime)) return ''
  const formatDateString = formatString || 'YYYY-MM-DD HH:mm:ss'
  return dayjs(dateTime).format(formatDateString)
}

export { formatNumber, formatDate, formatDateTime }

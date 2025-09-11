import dayjs from 'dayjs'

const formatNumber = (number, emptyText = '') => {
  /*
   * 格式化數字千位數
   * @param number - 數字
   * @param emptyText - 空值時顯示的參數
   */
  if (['', null, undefined].includes(number) || isNaN(number)) return emptyText
  return new Intl.NumberFormat('en', {
    minimumSignificantDigits: 1
  }).format(number)
}

const formatDate = (date, emptyText = '', formatString = 'YYYY-MM-DD') => {
  /*
   * 格式化日期
   * @param date - 日期
   * @param emptyText - 空值時顯示的參數
   * @param formatString - 格式化字串格式
   */
  if ([null, '', undefined].includes(date)) return emptyText
  return dayjs(date).format(formatString)
}

const formatTime = (time, emptyText = '', formatString = 'HH:mm') => {
  /*
   * 格式化日期時間
   * @param time - 時間
   * @param emptyText - 空值時顯示的參數
   * @param formatString - 格式化字串格式
   */
  if ([null, '', undefined].includes(time)) return emptyText
  return dayjs(time).format(formatString)
}

const formatDateTime = (dateTime, emptyText = '', formatString = 'YYYY-MM-DD HH:mm:ss') => {
  /*
   * 格式化日期時間
   * @param dateTime - 日期時間
   * @param emptyText - 空值時顯示的參數
   * @param formatString - 格式化字串格式
   */
  if ([null, '', undefined].includes(dateTime)) return emptyText
  return dayjs(dateTime).format(formatString)
}

export { formatNumber, formatDate, formatTime, formatDateTime }

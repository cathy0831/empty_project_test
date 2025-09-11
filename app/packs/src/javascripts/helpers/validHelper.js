import { formatDate } from '@/src/javascripts/helpers/formatHelper.js'
import dayjs from 'dayjs'

const baseDateRangeLimit = (
  originDateRange = { start_date: '', end_date: '' },
  dateKeyword = { startDate: 'start_date', endDate: 'end_date' }
) => {
  const dateRange = {
    startDate: originDateRange[dateKeyword.startDate],
    endDate: originDateRange[dateKeyword.endDate]
  }

  return {
    startDateMax: formatDate(dateRange.endDate),
    endDateMin: formatDate(dateRange.startDate)
  }
}

const historyDateRangeLimit = (
  originDateRange = { start_date: '', end_date: '' },
  dateKeyword = { startDate: 'start_date', endDate: 'end_date' }
) => {
  const todayDate = formatDate(dayjs())
  const limitDateRange = baseDateRangeLimit(originDateRange, dateKeyword)
  return {
    startDateMax: limitDateRange.startDateMax || todayDate,
    endDateMin: limitDateRange.endDateMin,
    endDateMax: todayDate
  }
}

const createValidFieldNamesObj = (fieldNames) => {
  const validateObj = {}
  fieldNames.forEach((name) => {
    validateObj[name] = {
      errorState: false,
      message: ''
    }
  })
  return validateObj
}

const yupValidate = async (schema, originValidateObj, formData, abortEarly = false) => {
  const fieldNames = Object.keys(originValidateObj)
  const validateObj = createValidFieldNamesObj(fieldNames)

  try {
    await schema.validate(formData, { abortEarly })
    return { isValid: true, validateObj, testInner: {} }
  } catch (err) {
    const testInner = {}
    err.inner?.forEach((errInner) => {
      if (errInner.path) {
        validateObj[errInner.path] = {
          errorState: true,
          message: errInner.message
        }
      } else {
        const key = errInner.type || 'global'
        testInner[key] = { errorState: true, message: errInner.message }
      }
    })

    return { isValid: false, validateObj, testInner }
  }
}

const yupFieldNameValidate = async (schema, formData, fieldName, abortEarly = true) => {
  const validateItem = {
    errorState: false,
    message: ''
  }
  try {
    await schema.validateAt(fieldName, formData, { abortEarly })
    return validateItem
  } catch (err) {
    return {
      errorState: true,
      message: err.message
    }
  }
}

const reportCustomValidity = (validateObj) => {
  return !Object.values(validateObj).some((field) => field.errorState)
}

export {
  baseDateRangeLimit,
  historyDateRangeLimit,
  createValidFieldNamesObj,
  yupValidate,
  yupFieldNameValidate,
  reportCustomValidity
}

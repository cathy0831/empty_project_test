import * as yup from 'yup'

const combineSchemas = (...schemas) => {
  return schemas.reduce((acc, schema) => acc.concat(schema))
}

const onlyAlphanumericSchema = yup
  .string()
  .trim()
  .notRequired()
  .test('matchesForm', I18n.t('validate_error.only_alphanumeric'), (value) => {
    if (!value) return true
    return /^[a-zA-Z0-9]+$/.test(value)
  })

const emailSchema = yup
  .string()
  .trim()
  .notRequired()
  .test('validEmail', I18n.t('validate_error.invalid_email'), (value) => {
    if (!value) return true
    return /^\w+((-\w+)|(\.\w+))*@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+$/.test(value)
  })

const minLengthTextSchema = (num) => {
  return yup
    .string()
    .trim()
    .notRequired()
    .test('minLengthText', I18n.t('validate_error.min_length_text', { num }), (value) => {
      if (!value) return true
      return value.length >= num
    })
}

const mustBeDigitsLengthSchema = (num) => {
  const regex = new RegExp(`^\\d{${num}}$`)
  return yup
    .string()
    .trim()
    .notRequired()
    .matches(regex, I18n.t('validate_error.must_be_digits', { num }))
}

const positiveDecimalLimitSchema = (num) => {
  const regex = new RegExp(`^-?\\d+(\\.\\d{1,${num}})?$`)
  return yup
    .number()
    .notRequired()
    .positive('請輸入大於 0 的數字')
    .test('decimalLimit', I18n.t('validate_error.decimal_limit', { num }), (value) => {
      if (!value) return true
      return regex.test(value.toString())
    })
}

const passwordSchema = combineSchemas(onlyAlphanumericSchema, minLengthTextSchema(4))

export {
  combineSchemas,
  onlyAlphanumericSchema,
  emailSchema,
  minLengthTextSchema,
  mustBeDigitsLengthSchema,
  positiveDecimalLimitSchema,
  passwordSchema
}

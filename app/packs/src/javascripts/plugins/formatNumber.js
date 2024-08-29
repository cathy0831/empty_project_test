const mixinFormatNumber = {
  methods: {
    formatNumber (number, empty = '') {
      if ([null, '', undefined, 'Infinity'].includes(number)) return empty
      return new Intl.NumberFormat('en', {
        minimumSignificantDigits: 1
      }).format(number)
    }
  }
}

export default mixinFormatNumber

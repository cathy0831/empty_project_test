<template>
  <div></div>
</template>

<script>
import mySwal from '@/src/javascripts/plugins/mySwal'
export default {
  props: {
    title: {
      type: String,
      required: true
    },
    text: {
      type: String,
      required: false
    },
    icon: {
      type: String,
      default: 'success'
    },
    type: {
      type: String,
      default: 'toast'
    }
  },
  mounted: function () {
    if (mySwal[this.type] !== undefined) {
      mySwal[this.type]({
        icon: this.icon,
        title: this.title,
        text: this.text,
        customClass: 'vue-swal-custom-class'
      })
    }
  },
  destroyed: function () {}
}
</script>

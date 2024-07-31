import Vue from 'vue'

const customVue = Vue.extend({
  beforeMount: function() {
    if (this !== this.$root) return;

    this.__TurbolinksAdapterOriginalOuterHTML__ = this.$el.outerHTML;
    var _this = this;
    document.addEventListener("turbo:before-cache", function teardown() {
      _this.$destroy();
      document.removeEventListener("turbo:before-cache", teardown);
    });
  },
  mounted: function () {
    this.$el.hidden = false
    console.log(this.$el.style)
    // setInterval(() => {
      // this.$el.style.opacity = 1
    // }, 50)
  },
  destroyed: function() {
    if (!this.__TurbolinksAdapterOriginalOuterHTML__) return;

    this.$el.outerHTML = this.__TurbolinksAdapterOriginalOuterHTML__;
    delete this.__TurbolinksAdapterOriginalOuterHTML__;
  }
})

class myVue extends Vue{
  constructor (vueOpt) {
    const $el = vueOpt.el
    if ($el == null) {
      return
    }
    $el.hidden = true
    $el.style.opacity = 0
    $el.style.transition = '.3s ease'
    return new customVue(vueOpt)
  }
}


export default myVue
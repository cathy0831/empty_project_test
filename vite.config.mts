import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import vue from '@vitejs/plugin-vue';
import inject from '@rollup/plugin-inject'

export default defineConfig({
  plugins: [
    inject({   // => that should be first under plugins array
      $: 'jquery',
      jQuery: 'jquery',
    }),
    RubyPlugin(),
    vue()
  ],
  optimizeDeps: {
    include: ["@ant-design/icons-vue"],
  },
  build: {
    commonjsOptions: { transformMixedEsModules: true }
  },
  resolve: {
    extensions: [".mjs", ".js", ".ts", ".jsx", ".tsx", ".json", ".vue", ".sass", ".scss", ".css", ".png", ".svg"],
  }
})
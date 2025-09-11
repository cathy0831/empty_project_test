import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import vue from '@vitejs/plugin-vue';
import inject from '@rollup/plugin-inject'

export default defineConfig({
  plugins: [
    inject({   // => that should be first under plugins array
      $: 'jquery',
      jQuery: 'jquery',
      include: ['**/*.js', '**/*.ts']
    }),
    RubyPlugin(),
    vue()
  ],
  optimizeDeps: {
    include: ["@ant-design/icons-vue"],
  },
  css: {
    preprocessorOptions: {
      scss: {
        api: 'modern-compiler' // or "modern"
      }
    }
  },
  build: {
    commonjsOptions: {
      transformMixedEsModules: true
    },
    rollupOptions: {
      output: {
        manualChunks: {
          vue: ['vue'],
          antd: ['ant-design-vue']
        }
      }
    },
  },
  resolve: {
    alias: {
      'vue': 'vue/dist/vue.esm-bundler.js'
    },
    extensions: [".mjs", ".js", ".ts", ".jsx", ".tsx", ".json", ".vue", ".sass", ".scss", ".css", ".png", ".svg"],
  }
})
import globals from 'globals'
import pluginJs from '@eslint/js'
import pluginVue from 'eslint-plugin-vue'
import standard from 'eslint-config-standard'
import pluginN from 'eslint-plugin-n'
import pluginPromise from 'eslint-plugin-promise'
import pluginImport from 'eslint-plugin-import'
import pluginTailwindcss from 'eslint-plugin-tailwindcss'

export default [
  { files: ['**/*.{js,mjs,cjs,vue}'] },
  {
    languageOptions: {
      globals: {
        ...globals.browser,
        $: 'readonly',
        Turbo: 'readonly',
        I18n: 'readonly',
        i18n_locale: 'readonly',
        i18n_translations: 'readonly'
      }
    }
  },
  pluginJs.configs.recommended,
  ...pluginVue.configs['flat/essential'],
  ...pluginTailwindcss.configs['flat/recommended'],
  {
    plugins: {
      n: pluginN,
      import: pluginImport,
      promise: pluginPromise
    },
    rules: {
      ...standard.rules,
      // 禁止使用未宣告的變數（如直接使用未定義的變數會報錯）
      'no-undef': 'error',
      // 如果變數沒有重新賦值，強制使用 const 而不是 let
      'prefer-const': 'error',
      // 強制使用 === 或 !==，禁止使用 == 或 !=
      eqeqeq: ['error', 'always'],
      // 警告 console 的使用（允許 console.warn 和 console.error）
      'no-console': ['warn', { allow: ['warn', 'error'] }],
      // 禁止使用 var（要求使用 let 或 const）
      'no-var': 'error',
      'tailwindcss/no-custom-classname': 'off',
      camelcase: 'off'
    }
  }
]

import eslint from '@eslint/js'
import vue from 'eslint-plugin-vue'
import typescriptEslint from '@vue/eslint-config-typescript'

export default [
  { ignores: ['dist/**', 'coverage/**'] },
  eslint.configs.recommended,
  ...vue.configs['flat/recommended'],
  ...typescriptEslint(),
  {
    rules: {
      'vue/multi-word-component-names': 'off',
      'vue/attributes-order': 'off',
      'vue/max-attributes-per-line': 'off',
      'vue/singleline-html-element-content-newline': 'off',
      'vue/html-self-closing': 'off',
    },
  },
]

// Safari 不支持 content_scripts 的 `world: 'MAIN'`。构建时把已生成的页面脚本源码嵌入内容脚本，
// 由内容脚本在 document_start 同步插入内联 <script>，与其他浏览器的注入时机保持一致。
// 因此 Safari 构建需先执行 build:inject，再执行 build:js。
import { existsSync, readFileSync } from 'node:fs'

import type { Plugin } from 'vite'

import { isSafari, r } from './utils'

const SAFARI_INJECT_SOURCE_GLOBAL = '__BEWLYCAT_SAFARI_INJECT_SOURCE__'

export function embedSafariInjectSource(): Plugin {
  return {
    name: 'embed-safari-inject-source',
    apply: 'build',
    enforce: 'post',
    generateBundle(_options, bundle) {
      if (!isSafari)
        return

      const injectPath = r('extension-safari/dist/contentScripts/inject.global.js')
      if (!existsSync(injectPath)) {
        this.error(`Unable to embed Safari inject script: ${injectPath} was not built. Run build:inject before build:js.`)
        return
      }

      const entryChunk = Object.values(bundle).find(
        output => output.type === 'chunk' && output.fileName === 'index.global.js',
      )
      if (!entryChunk || entryChunk.type !== 'chunk') {
        this.error('Unable to embed Safari inject script: index.global.js was not emitted.')
        return
      }

      const source = readFileSync(injectPath, 'utf8')
      entryChunk.code = `globalThis.${SAFARI_INJECT_SOURCE_GLOBAL}=${JSON.stringify(source)};\n${entryChunk.code}`
    },
  }
}

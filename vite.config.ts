import { resolve } from 'path'
import { defineConfig } from 'vite'
import { svelte } from '@sveltejs/vite-plugin-svelte'
import { viteStaticCopy } from 'vite-plugin-static-copy'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    svelte(),
    viteStaticCopy({
      targets: [
        {
          src: 'package-nodecg.json',
          dest: '.',
          rename: 'package.json',
        },
      ],
    }),
  ],
  base: `/bundles/${process.env['LAYOUTS_NAME']}/`,
  build: {
    rollupOptions: {
      input: {
        'graphics/index': resolve(__dirname, 'graphics/index.html'),
        'dashboard/count-up': resolve(__dirname, 'dashboard/count-up.html'),
      },
    },
    emptyOutDir: true,
  },
  resolve: {
    alias: {
      '~': resolve(__dirname, 'src'),
    },
  },
})

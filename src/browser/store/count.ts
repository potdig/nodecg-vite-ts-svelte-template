import { readable, type Readable } from 'svelte/store'

const count: Readable<number> = readable(0, set => {
  window.nodecg.Replicant('count').on('change', value => {
    set(value)
  })
})

export { count }

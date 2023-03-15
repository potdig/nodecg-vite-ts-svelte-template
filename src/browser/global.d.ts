import type { NodeCG } from './nodecg'

declare global {
  interface Window {
    nodecg: NodeCG
  }
}

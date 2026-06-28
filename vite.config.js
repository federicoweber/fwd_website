import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// Served from the root of federicoweber.github.io (user page + custom domain),
// so the base path is '/'.
export default defineConfig({
  base: '/',
  plugins: [react()],
})

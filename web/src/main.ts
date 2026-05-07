/* main.ts — Vue application entry point: initialises Pinia, mounts the root App component, and syncs the stored theme before first paint. */

import { createApp } from 'vue'
import { createPinia } from 'pinia'
import './style.css'
import App from './App.vue'

;(function syncStoredTheme(): void {
  const raw = localStorage.getItem('hgs-theme')
  if (raw === 'dark' || raw === 'sepia' || raw === 'light') {
    document.documentElement.dataset.theme = raw
  }
})()

const app = createApp(App)

app.use(createPinia())
app.mount('#app')

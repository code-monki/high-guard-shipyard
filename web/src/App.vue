<script setup lang="ts">
/* App.vue — Root application shell: identity strip, sidebar navigation, status meters, panel routing, theme control, and file import/export. */
import { onMounted, ref, watch, computed } from 'vue'
import { storeToRefs } from 'pinia'
import { useShipStore } from './stores/ship'
import PanelHull from './components/PanelHull.vue'
import PanelEngineering from './components/PanelEngineering.vue'
import PanelFuel from './components/PanelFuel.vue'
import PanelAvionics from './components/PanelAvionics.vue'
import PanelWeapons from './components/PanelWeapons.vue'
import PanelScreens from './components/PanelScreens.vue'
import PanelAccommodations from './components/PanelAccommodations.vue'
import PanelCraft from './components/PanelCraft.vue'
import PanelUserDefined from './components/PanelUserDefined.vue'
import PanelOptions from './components/PanelOptions.vue'
import PanelResults from './components/PanelResults.vue'

const shipStore = useShipStore()
const {
  design,
  usedTonnage,
  usedBudget,
  totalEpOutput,
  totalEpDemand,
  remainingTonnage,
  remainingBudget,
  remainingEp,
  validationIssues,
} = storeToRefs(shipStore)

// ── Theme ──────────────────────────────────────────────────────────────────
const THEME_KEY = 'hgs-theme'
type ThemeId = 'light' | 'dark' | 'sepia'
const themeId = ref<ThemeId>('light')
onMounted(() => {
  const raw = localStorage.getItem(THEME_KEY)
  if (raw === 'dark' || raw === 'sepia' || raw === 'light') themeId.value = raw
  document.documentElement.dataset.theme = themeId.value
})
watch(themeId, (id) => {
  localStorage.setItem(THEME_KEY, id)
  document.documentElement.dataset.theme = id
})

// ── File I/O ───────────────────────────────────────────────────────────────
const filePicker = ref<HTMLInputElement | null>(null)
const ioMessage = ref('')

const openImportDialog = (): void => {
  ioMessage.value = ''
  filePicker.value?.click()
}

const onImportFile = async (event: Event): Promise<void> => {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0]
  if (!file) return
  try {
    const text = await file.text()
    shipStore.importHgsText(text)
    ioMessage.value = `Imported ${file.name}`
  } catch (error) {
    ioMessage.value = error instanceof Error ? `Import failed: ${error.message}` : 'Import failed'
  } finally {
    input.value = ''
  }
}

const exportHgs = (): void => {
  try {
    const text = shipStore.exportHgsText()
    const blob = new Blob([text], { type: 'text/plain;charset=utf-8' })
    const url = URL.createObjectURL(blob)
    const anchor = document.createElement('a')
    const base = design.value.shipClass || design.value.shipName || 'ship-design'
    const safe = base.replace(/[^a-z0-9-_]+/gi, '_').toLowerCase()
    anchor.href = url
    anchor.download = `${safe}.hgs`
    document.body.appendChild(anchor)
    anchor.click()
    document.body.removeChild(anchor)
    URL.revokeObjectURL(url)
    ioMessage.value = `Exported ${anchor.download}`
  } catch (error) {
    ioMessage.value = error instanceof Error ? `Export failed: ${error.message}` : 'Export failed'
  }
}

const printSummary = (): void => window.print()

// ── Navigation ─────────────────────────────────────────────────────────────
type PanelId = 'hull' | 'engineering' | 'fuel' | 'avionics' | 'weapons' | 'screens' | 'accommodations' | 'craft' | 'userdef' | 'options' | 'results'
const activePanel = ref<PanelId>('hull')

const navItems: { id: PanelId; label: string }[] = [
  { id: 'hull',           label: 'Hull' },
  { id: 'engineering',    label: 'Engineering' },
  { id: 'fuel',           label: 'Fuel' },
  { id: 'avionics',       label: 'Electronics' },
  { id: 'weapons',        label: 'Weapons' },
  { id: 'screens',        label: 'Defenses' },
  { id: 'accommodations', label: 'Accommodations' },
  { id: 'craft',          label: 'Craft' },
  { id: 'userdef',        label: 'User Defined' },
  { id: 'options',        label: 'Options' },
  { id: 'results',        label: 'Results' },
]

// ── Status bar helpers ─────────────────────────────────────────────────────
const tonnagePct = computed(() => design.value.tonnage > 0 ? Math.min(100, (usedTonnage.value / design.value.tonnage) * 100) : 0)
const budgetPct  = computed(() => design.value.budgetMcr > 0 ? Math.min(100, (usedBudget.value / design.value.budgetMcr) * 100) : 0)
const epPct      = computed(() => totalEpOutput.value > 0 ? Math.min(100, (totalEpDemand.value / totalEpOutput.value) * 100) : 0)

const statusClass = (remaining: number): string =>
  remaining < 0 ? 'status-over' : remaining === 0 ? 'status-exact' : 'status-ok'

// ── Dialogs ────────────────────────────────────────────────────────────────
const helpDialog   = ref<HTMLDialogElement | null>(null)
const aboutDialog  = ref<HTMLDialogElement | null>(null)
const issuesDialog = ref<HTMLDialogElement | null>(null)
const openHelp   = (): void => helpDialog.value?.showModal()
const openAbout  = (): void => aboutDialog.value?.showModal()
const openIssues = (): void => issuesDialog.value?.showModal()

/**
 * Maps a validation issue code number to the PanelId where the user can fix it.
 * @param code - Numeric issue code from `ValidationIssue.code`.
 */
const panelForCode = (code: number): PanelId => {
  if (code === 1 || code === 6 || code === 7) return 'hull'
  if (code === 2) return 'hull'
  if (code === 5 || (code >= 8 && code <= 26)) return 'engineering'
  if (code >= 27 && code <= 32) return 'fuel'
  if ((code >= 33 && code <= 50) || code === 107 || code === 108 || (code >= 2001 && code <= 2004)) return 'avionics'
  if (code >= 51 && code <= 89) return 'weapons'
  if (code >= 90 && code <= 95) return 'screens'
  if (code >= 96 && code <= 106) return 'accommodations'
  return 'results'
}

/** Navigates to the panel responsible for the given validation issue code and closes the issues dialog. */
const navigateToIssue = (code: number): void => {
  activePanel.value = panelForCode(code)
  issuesDialog.value?.close()
}

// ── Nav keyboard support (↑ / ↓ arrows) ───────────────────────────────────
const navEl = ref<HTMLElement | null>(null)

/**
 * Handles ArrowUp/ArrowDown keydown events on sidebar nav buttons to move focus between panels.
 * @param event - The keyboard event from the nav button.
 * @param id - The PanelId of the button that received the event.
 */
const onNavKeydown = (event: KeyboardEvent, id: PanelId): void => {
  const idx = navItems.findIndex(item => item.id === id)
  let next = -1
  if (event.key === 'ArrowDown') { event.preventDefault(); next = (idx + 1) % navItems.length }
  if (event.key === 'ArrowUp')   { event.preventDefault(); next = (idx - 1 + navItems.length) % navItems.length }
  if (next < 0) return
  activePanel.value = navItems[next].id
  const buttons = navEl.value?.querySelectorAll<HTMLButtonElement>('.nav-link')
  buttons?.[next]?.focus()
}
</script>

<template>
  <a href="#panel-area" class="skip-link">Skip to panel</a>

  <div class="app-shell">
    <!-- ── Header ── -->
    <header class="app-header no-print">
      <div class="app-title">
        <p class="kicker">Classic Traveller High Guard Shipyard</p>
        <h1>Ship Designer</h1>
      </div>
      <div class="header-actions">
        <div class="theme-control" role="group" aria-label="Theme">
          <span class="theme-label">Theme</span>
          <div class="theme-segmented">
            <button type="button" class="theme-btn" :class="{ active: themeId === 'light' }" @click="themeId = 'light'">Light</button>
            <button type="button" class="theme-btn" :class="{ active: themeId === 'dark'  }" @click="themeId = 'dark'">Dark</button>
            <button type="button" class="theme-btn" :class="{ active: themeId === 'sepia' }" @click="themeId = 'sepia'">Sepia</button>
          </div>
        </div>
        <input ref="filePicker" type="file" accept=".hgs,text/plain" class="hidden-file"
          aria-hidden="true" tabindex="-1" @change="onImportFile" />
        <button type="button" class="btn-ghost" @click="openImportDialog">Import .hgs</button>
        <button type="button" class="btn-ghost" @click="exportHgs">Export .hgs</button>
        <button type="button" class="btn-ghost" @click="printSummary">Print</button>
        <button type="button" class="btn-ghost" @click="shipStore.resetDesign()">Reset</button>
        <button type="button" class="btn-ghost" @click="openHelp">Help</button>
        <button type="button" class="btn-ghost" @click="openAbout">About</button>
      </div>
    </header>

    <!-- ── Identity strip ── -->
    <section class="identity-strip" aria-label="Ship identity">
      <label class="id-field id-field--wide">
        <span>Ship Name</span>
        <input v-model="design.shipName" />
      </label>
      <label class="id-field id-field--wide">
        <span>Class</span>
        <input v-model="design.shipClass" />
      </label>
      <label class="id-field">
        <span>Hull Code</span>
        <input v-model="design.hullCode" />
      </label>
      <label class="id-field id-field--narrow">
        <span>TL</span>
        <input v-model.number="design.techLevel" type="number" min="0" />
      </label>
      <label class="id-field">
        <span>Design System</span>
        <select v-model.number="design.designSystem">
          <option :value="1">High Guard</option>
          <option :value="0">T20/General</option>
        </select>
      </label>
      <label class="id-field">
        <span>Race Profile</span>
        <select v-model.number="design.race">
          <option :value="1">Human standard</option>
          <option :value="0">Alternative</option>
        </select>
      </label>
      <label class="id-field id-field--narrow">
        <span>Tonnage</span>
        <input v-model.number="design.tonnage" type="number" min="0" step="10" />
      </label>
      <label class="id-field id-field--narrow">
        <span>Budget (MCr)</span>
        <input v-model.number="design.budgetMcr" type="number" min="0" step="10" />
      </label>
      <label class="id-field">
        <span>Refit Mode</span>
        <select v-model="design.isRefitted">
          <option :value="false">No</option>
          <option :value="true">Yes</option>
        </select>
      </label>
      <template v-if="design.isRefitted">
        <label class="id-field id-field--narrow">
          <span>Refit TL</span>
          <input v-model.number="design.refitTechLevel" type="number" min="0" />
        </label>
        <label class="id-field id-field--narrow">
          <span>Refit Budget</span>
          <input v-model.number="design.refitBudgetMcr" type="number" min="0" step="10" />
        </label>
      </template>
      <p v-if="ioMessage" class="io-message" role="status" aria-live="polite">{{ ioMessage }}</p>
    </section>

    <!-- ── Workspace (sidebar + panel) ── -->
    <div class="workspace">
      <!-- Sidebar -->
      <aside class="sidebar no-print" aria-label="Design navigation">
        <!-- Status meters -->
        <div class="status-meters">
          <div class="status-meter">
            <div class="status-meter-header">
              <span class="status-meter-label">Tonnage</span>
              <span class="status-meter-value" :class="statusClass(remainingTonnage)">
                {{ remainingTonnage >= 0 ? remainingTonnage + ' rem' : Math.abs(remainingTonnage) + ' over' }}
              </span>
            </div>
            <div class="status-bar-track">
              <div class="status-bar-fill" :class="statusClass(remainingTonnage)"
                :style="{ width: tonnagePct + '%' }"></div>
            </div>
            <p class="status-meter-detail">{{ usedTonnage }} / {{ design.tonnage }}t</p>
          </div>

          <div class="status-meter">
            <div class="status-meter-header">
              <span class="status-meter-label">Budget</span>
              <span class="status-meter-value" :class="statusClass(remainingBudget)">
                {{ remainingBudget >= 0 ? remainingBudget + ' rem' : Math.abs(remainingBudget) + ' over' }}
              </span>
            </div>
            <div class="status-bar-track">
              <div class="status-bar-fill" :class="statusClass(remainingBudget)"
                :style="{ width: budgetPct + '%' }"></div>
            </div>
            <p class="status-meter-detail">{{ usedBudget }} / {{ design.budgetMcr }} MCr</p>
          </div>

          <div class="status-meter">
            <div class="status-meter-header">
              <span class="status-meter-label">Energy</span>
              <span class="status-meter-value" :class="statusClass(remainingEp)">
                {{ remainingEp >= 0 ? remainingEp + ' rem' : Math.abs(remainingEp) + ' deficit' }}
              </span>
            </div>
            <div class="status-bar-track">
              <div class="status-bar-fill" :class="statusClass(remainingEp)"
                :style="{ width: epPct + '%' }"></div>
            </div>
            <p class="status-meter-detail">{{ totalEpDemand }} demand / {{ totalEpOutput }} output</p>
          </div>

          <button v-if="validationIssues.length > 0" type="button" class="status-issues" @click="openIssues()" aria-haspopup="dialog">
            <span class="status-issues-count">{{ validationIssues.length }} issue{{ validationIssues.length > 1 ? 's' : '' }}</span>
            <span class="status-issues-hint">click to review</span>
          </button>
        </div>

        <!-- Nav links -->
        <nav ref="navEl" class="panel-nav" aria-label="System panels">
          <button
            v-for="item in navItems"
            :key="item.id"
            type="button"
            class="nav-link"
            :class="{ active: activePanel === item.id }"
            @click="activePanel = item.id"
            @keydown="onNavKeydown($event, item.id)"
          >
            {{ item.label }}
          </button>
        </nav>
      </aside>

      <!-- Panel area -->
      <main id="panel-area" class="panel-area" tabindex="-1">
        <PanelHull          v-if="activePanel === 'hull'" />
        <PanelEngineering   v-if="activePanel === 'engineering'" />
        <PanelFuel          v-if="activePanel === 'fuel'" />
        <PanelAvionics      v-if="activePanel === 'avionics'" />
        <PanelWeapons       v-if="activePanel === 'weapons'" />
        <PanelScreens       v-if="activePanel === 'screens'" />
        <PanelAccommodations v-if="activePanel === 'accommodations'" />
        <PanelCraft         v-if="activePanel === 'craft'" />
        <PanelUserDefined   v-if="activePanel === 'userdef'" />
        <PanelOptions       v-if="activePanel === 'options'" />
        <PanelResults       v-if="activePanel === 'results'" />
      </main>
    </div>

    <footer class="app-footer no-print">
      <p>Original desktop application: High Guard Shipyard v2.x by Andrea Vallance (source provided by Nicole Susans). Traveller and High Guard are trademarks of their respective owners. Non-commercial port.</p>
    </footer>

    <!-- ── Help dialog ── -->
    <dialog ref="helpDialog" class="app-dialog" aria-labelledby="help-title">
      <div class="dialog-header">
        <h2 id="help-title">Help</h2>
        <button type="button" class="dialog-close" aria-label="Close" @click="helpDialog?.close()">✕</button>
      </div>
      <div class="dialog-body">

        <h3>Getting started</h3>
        <p>Fill in the <strong>identity strip</strong> at the top of the page — ship name, class, hull code, tech level, tonnage cap, and budget. These fields drive all calculations and are always visible.</p>
        <p>Use the <strong>sidebar navigation</strong> to move between component systems. Every change writes immediately to the design; the status bars update in real time.</p>

        <h3>Status bars</h3>
        <dl class="help-dl">
          <dt>Green</dt><dd>Resources remaining — design is within limits.</dd>
          <dt>Amber</dt><dd>Exactly at the limit — no headroom.</dd>
          <dt>Red</dt><dd>Over budget or overloaded — see Results for details.</dd>
        </dl>

        <h3>File operations</h3>
        <dl class="help-dl">
          <dt>Import .hgs</dt><dd>Load a design file saved by the original High Guard Shipyard desktop application or a previous export from this tool.</dd>
          <dt>Export .hgs</dt><dd>Save the current design in the legacy .hgs text format, compatible with the desktop application.</dd>
          <dt>Print</dt><dd>Print a full-page summary. Use <em>Print this card</em> on the Results panel to print only the compact summary card.</dd>
        </dl>

        <h3>Keyboard shortcuts</h3>
        <table class="help-table">
          <thead><tr><th>Key</th><th>Action</th></tr></thead>
          <tbody>
            <tr><td>↑ / ↓</td><td>Move between panels when a sidebar nav link has focus</td></tr>
            <tr><td>Tab / Shift+Tab</td><td>Move between fields within a panel</td></tr>
            <tr><td>Escape</td><td>Close this dialog</td></tr>
          </tbody>
        </table>

      </div>
    </dialog>

    <!-- ── Issues dialog ── -->
    <dialog ref="issuesDialog" class="app-dialog" aria-labelledby="issues-title">
      <div class="dialog-header">
        <h2 id="issues-title">Design Issues</h2>
        <button type="button" class="dialog-close" aria-label="Close" @click="issuesDialog?.close()">✕</button>
      </div>
      <div class="dialog-body">
        <p class="issues-dialog-intro">Click a panel name to navigate directly to the relevant section.</p>
        <ul class="issues-dialog-list">
          <li v-for="issue in validationIssues" :key="issue.code" class="issues-dialog-item">
            <span class="issues-dialog-msg">[{{ issue.code }}] {{ issue.message }}</span>
            <button type="button" class="issues-dialog-nav" @click="navigateToIssue(issue.code)">
              {{ navItems.find(n => n.id === panelForCode(issue.code))?.label ?? 'Results' }} →
            </button>
          </li>
        </ul>
      </div>
    </dialog>

    <!-- ── About dialog ── -->
    <dialog ref="aboutDialog" class="app-dialog" aria-labelledby="about-title">
      <div class="dialog-header">
        <h2 id="about-title">About High Guard Shipyard</h2>
        <button type="button" class="dialog-close" aria-label="Close" @click="aboutDialog?.close()">✕</button>
      </div>
      <div class="dialog-body">

        <p class="about-lead">High Guard Shipyard is a ship design tool for <em>Classic Traveller</em>, implementing the rules from the <em>High Guard</em> supplement.</p>

        <h3>Original application</h3>
        <p>The original <strong>High Guard Shipyard</strong> desktop application (v2.x) was written by <strong>Andrea Vallance</strong>. It remains the authoritative reference for the calculations implemented here.</p>

        <h3>A special thank you</h3>
        <p><strong>Nicole Susans</strong> generously provided the original Pascal source code and granted permission for this web recreation to be built from it. This project would not exist without her kindness. Thank you, Nicole.</p>
        <!-- Additional acknowledgement verbiage to be added here -->

        <h3>Source &amp; licence</h3>
        <p>The source code for this web port is available on GitHub:<br>
          <a class="about-link" href="https://github.com/CodeMonki/high-guard-shipyard" target="_blank" rel="noopener">github.com/CodeMonki/high-guard-shipyard</a>
        </p>
        <p class="about-legal">Traveller is a registered trademark of Far Future Enterprises. High Guard is published under licence. This tool is a non-commercial fan project and is not affiliated with or endorsed by Far Future Enterprises.</p>

      </div>
    </dialog>

  </div>
</template>

<script setup lang="ts">
/* PanelResults — displays per-module totals, a printable summary card, and the full validation issue list. */
import { storeToRefs } from 'pinia'
import { useShipStore } from '../stores/ship'
import { format } from '../utils'

const shipStore = useShipStore()
const {
  modules,
  usedTonnage,
  usedBudget,
  totalEpOutput,
  totalEpDemand,
  validationIssues,
  design,
} = storeToRefs(shipStore)

const printSummaryOnly = (): void => {
  const cls = 'print-summary-only'
  const cleanup = (): void => {
    document.body.classList.remove(cls)
    window.removeEventListener('afterprint', cleanup)
  }
  document.body.classList.add(cls)
  window.addEventListener('afterprint', cleanup)
  window.print()
  window.setTimeout(cleanup, 1500)
}
</script>

<template>
  <div class="panel">
    <h2 class="panel-title">Results &amp; Validation</h2>

    <!-- Module totals table -->
    <div class="form-section">
      <div class="form-section-title">Module totals</div>
      <div class="results-table" role="table" aria-label="Calculated module totals">
        <div class="results-row results-head" role="row">
          <span role="columnheader">Module</span>
          <span role="columnheader" class="num">Tons</span>
          <span role="columnheader" class="num">Cost (MCr)</span>
          <span role="columnheader" class="num">EP out</span>
          <span role="columnheader" class="num">EP demand</span>
        </div>
        <div
          v-for="m in modules"
          :key="m.type"
          class="results-row"
          role="row"
        >
          <span role="cell">{{ m.name }}</span>
          <span role="cell" class="num">{{ format(m.tonnage) }}</span>
          <span role="cell" class="num">{{ format(m.costMcr) }}</span>
          <span role="cell" class="num">{{ format(m.epOutput ?? 0) }}</span>
          <span role="cell" class="num">{{ format(m.epDemand ?? 0) }}</span>
        </div>
      </div>
    </div>

    <!-- Print summary card -->
    <div class="form-section print-summary-card">
      <div class="summary-title-row">
        <span class="form-section-title">Print summary</span>
        <button type="button" class="btn-ghost no-print" @click="printSummaryOnly">Print this card</button>
      </div>
      <div class="summary-grid">
        <p><strong>Name:</strong> {{ design.shipName }}</p>
        <p><strong>Class:</strong> {{ design.shipClass }}</p>
        <p><strong>Hull:</strong> {{ design.hullCode }}</p>
        <p><strong>TL:</strong> {{ design.techLevel }}</p>
        <p><strong>Tonnage:</strong> {{ format(usedTonnage) }} / {{ format(design.tonnage) }}</p>
        <p><strong>Budget:</strong> {{ format(usedBudget) }} / {{ format(design.budgetMcr) }} MCr</p>
        <p><strong>EP:</strong> {{ format(totalEpOutput) }} out / {{ format(totalEpDemand) }} demand</p>
      </div>
      <ul class="summary-lines">
        <li v-for="m in modules" :key="`s-${m.type}`">
          {{ m.name }}: {{ format(m.tonnage) }}t · {{ format(m.costMcr) }} MCr · EP {{ format(m.epOutput ?? 0) }}/{{ format(m.epDemand ?? 0) }}
        </li>
      </ul>
      <p v-if="validationIssues.length === 0" style="font-size:0.875rem; color: var(--color-ok)">No issues detected.</p>
      <ul v-else class="issues-list">
        <li v-for="issue in validationIssues" :key="`s-${issue.code}`">[{{ issue.code }}] {{ issue.message }}</li>
      </ul>
    </div>

    <!-- Validation -->
    <div class="notes-area no-print">
      <h3>Design Validation</h3>
      <p v-if="validationIssues.length === 0" style="font-size:0.875rem; color: var(--color-ok)">No rule violations detected.</p>
      <ul v-else class="issues-list">
        <li v-for="issue in validationIssues" :key="`v-${issue.code}`">[{{ issue.code }}] {{ issue.message }}</li>
      </ul>
    </div>
  </div>
</template>

<style scoped>
.summary-title-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 0.75rem;
}

.summary-lines {
  margin: 0.5rem 0 0;
  padding-left: 1.2rem;
  columns: 2;
  column-gap: 1.5rem;
  font-size: 0.85rem;
}

.summary-lines li { break-inside: avoid; margin-bottom: 0.15rem; }
</style>

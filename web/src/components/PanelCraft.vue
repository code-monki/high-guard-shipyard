<script setup lang="ts">
/* PanelCraft — craft facilities inputs: carried small craft and vehicles, fighter squadrons, and launch catapults. */
import { storeToRefs } from 'pinia'
import { useShipStore } from '../stores/ship'

const { craftInputs } = storeToRefs(useShipStore())
</script>

<template>
  <div class="panel">
    <h2 class="panel-title">Craft Facilities</h2>

    <div class="form-section">
      <div class="craft-table">
        <div></div>
        <div class="c-head">Qty</div>
        <div class="c-head">Tons</div>
        <div class="c-head">Crew</div>
        <div class="c-head">Vehicle</div>

        <template v-for="(item, i) in craftInputs.items" :key="i">
          <div class="c-label">Craft {{ i + 1 }}</div>
          <input v-model.number="item.num"     type="number" min="0" />
          <input v-model.number="item.tonnage" type="number" min="0" step="0.1" />
          <input v-model.number="item.crew"    type="number" min="0" />
          <select v-model.number="item.vehicle">
            <option :value="0">No</option>
            <option :value="1">Yes</option>
          </select>
        </template>
      </div>
    </div>

    <div class="form-section">
      <div class="form-section-title">Launch facilities &amp; squadrons</div>
      <div class="field-row">
        <label class="field"><span class="field-label">Fighter squadrons</span>
          <input v-model.number="craftInputs.ftrSqd" type="number" min="0" /></label>
      </div>
      <div class="field-row">
        <label class="field"><span class="field-label">Launcher 1 count</span>
          <input v-model.number="craftInputs.lf1Num" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Launcher 1 size (t)</span>
          <input v-model.number="craftInputs.lf1Size" type="number" min="0" step="0.1" /></label>
        <label class="field"><span class="field-label">Launcher 2 count</span>
          <input v-model.number="craftInputs.lf2Num" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Launcher 2 size (t)</span>
          <input v-model.number="craftInputs.lf2Size" type="number" min="0" step="0.1" /></label>
      </div>
    </div>
  </div>
</template>

<style scoped>
.craft-table {
  display: grid;
  grid-template-columns: max-content repeat(4, max-content);
  gap: 0.3rem 0.6rem;
  align-items: center;
}

.c-head {
  font-size: 0.72rem;
  font-weight: 800;
  letter-spacing: 0.05em;
  text-transform: uppercase;
  color: var(--color-text-muted);
  text-align: center;
  padding-bottom: 0.2rem;
  border-bottom: 1px solid var(--color-border-subtle);
}

.c-label {
  font-size: 0.82rem;
  font-weight: 600;
  color: var(--color-text-secondary);
  white-space: nowrap;
  padding-right: 0.4rem;
}

.craft-table input { width: 4.5rem; }
.craft-table select { width: 5rem; }
</style>

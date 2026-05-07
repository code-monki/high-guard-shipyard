<script setup lang="ts">
import { storeToRefs } from 'pinia'
import { useShipStore } from '../stores/ship'

const { screenInputs } = storeToRefs(useShipStore())
</script>

<template>
  <div class="panel">
    <h2 class="panel-title">Defenses</h2>

    <div class="form-section">
      <div class="screens-table">
        <div></div>
        <div class="s-head">Main factor</div>
        <div class="s-head">Backup factor</div>
        <div class="s-head">Backup qty</div>

        <div class="s-label">Nuclear Damper</div>
        <input v-model.number="screenInputs.nucDamp"       type="number" min="0" max="9" />
        <input v-model.number="screenInputs.bakNucDamp"    type="number" min="0" max="9" />
        <input v-model.number="screenInputs.bakNucDampNum" type="number" min="0" />

        <div class="s-label">Meson Screen</div>
        <input v-model.number="screenInputs.mesScrn"       type="number" min="0" max="9" />
        <input v-model.number="screenInputs.bakMesScrn"    type="number" min="0" max="9" />
        <input v-model.number="screenInputs.bakMesScrnNum" type="number" min="0" />

        <div class="s-label">Black Globe</div>
        <input v-model.number="screenInputs.blkGlb"       type="number" min="0" max="9" />
        <input v-model.number="screenInputs.bakBlkGlb"    type="number" min="0" max="9" />
        <input v-model.number="screenInputs.bakBlkGlbNum" type="number" min="0" />
      </div>

      <div class="field-row" style="margin-top:0.6rem">
        <label class="field">
          <span class="field-label">Extra capacitors (t)</span>
          <input v-model.number="screenInputs.extraCaps" type="number" min="0" step="0.1" />
        </label>
      </div>
    </div>
  </div>
</template>

<style scoped>
.screens-table {
  display: grid;
  grid-template-columns: max-content repeat(3, max-content);
  gap: 0.35rem 0.75rem;
  align-items: center;
}

.s-head {
  font-size: 0.72rem;
  font-weight: 800;
  letter-spacing: 0.05em;
  text-transform: uppercase;
  color: var(--color-text-muted);
  text-align: center;
  padding-bottom: 0.2rem;
  border-bottom: 1px solid var(--color-border-subtle);
}

.s-label {
  font-size: 0.85rem;
  font-weight: 600;
  color: var(--color-text-secondary);
  white-space: nowrap;
  padding-right: 0.5rem;
}

.screens-table input { width: 4.5rem; }
</style>

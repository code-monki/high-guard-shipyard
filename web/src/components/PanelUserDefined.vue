<script setup lang="ts">
/* PanelUserDefined — user-defined component inputs: up to 8 custom items with tonnage, crew, EP, cost, and hardpoints. */
import { storeToRefs } from 'pinia'
import { useShipStore } from '../stores/ship'

const { userDefInputs } = storeToRefs(useShipStore())
</script>

<template>
  <div class="panel">
    <h2 class="panel-title">User Defined Components</h2>

    <div class="form-section">
      <div class="ud-table">
        <div></div>
        <div class="ud-head">Qty</div>
        <div class="ud-head">Size (t)</div>
        <div class="ud-head">Crew</div>
        <div class="ud-head">EP</div>
        <div class="ud-head">Cost (MCr)</div>
        <div class="ud-head">HP</div>

        <template v-for="(item, i) in userDefInputs.items" :key="i">
          <div class="ud-label">UD{{ i + 1 }}</div>
          <input v-model.number="item.num"  type="number" min="0" />
          <input v-model.number="item.size" type="number" min="0" step="0.1" />
          <input v-model.number="item.crew" type="number" min="0" />
          <input v-model.number="item.ep"   type="number" step="0.1" />
          <input v-model.number="item.cost" type="number" min="0" step="0.1" />
          <input v-model.number="item.hp"   type="number" min="0" />
        </template>
      </div>
    </div>
  </div>
</template>

<style scoped>
.ud-table {
  display: grid;
  grid-template-columns: max-content repeat(6, max-content);
  gap: 0.3rem 0.6rem;
  align-items: center;
}

.ud-head {
  font-size: 0.72rem;
  font-weight: 800;
  letter-spacing: 0.05em;
  text-transform: uppercase;
  color: var(--color-text-muted);
  text-align: center;
  padding-bottom: 0.2rem;
  border-bottom: 1px solid var(--color-border-subtle);
}

.ud-label {
  font-size: 0.82rem;
  font-weight: 600;
  color: var(--color-text-secondary);
  white-space: nowrap;
  padding-right: 0.4rem;
}

.ud-table input { width: 4.5rem; }
</style>

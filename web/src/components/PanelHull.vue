<script setup lang="ts">
/* PanelHull — hull configuration inputs: hull type, armour, streamlining, airframe, and extra structure. */
import { storeToRefs } from 'pinia'
import { useShipStore } from '../stores/ship'

const { hullInputs } = storeToRefs(useShipStore())
</script>

<template>
  <div class="panel">
    <h2 class="panel-title">Hull</h2>
    <div class="form-section">
      <div class="field-row">
        <label class="field">
          <span class="field-label">Configuration</span>
          <input v-model.number="hullInputs.config" type="number" min="1" max="9" />
        </label>
        <label class="field">
          <span class="field-label">Armour</span>
          <input v-model.number="hullInputs.armour" type="number" min="0" />
        </label>
        <label class="field">
          <span class="field-label">Streamlining</span>
          <select v-model.number="hullInputs.streamLining" class="select-narrow">
            <option :value="0">No</option>
            <option :value="1">Yes</option>
          </select>
        </label>
        <label class="field">
          <span class="field-label">Airframe</span>
          <select v-model.number="hullInputs.airframe" class="select-narrow">
            <option :value="0">No</option>
            <option :value="1">Yes</option>
          </select>
        </label>
        <label class="field">
          <span class="field-label">Extra Structure (t)</span>
          <input v-model.number="hullInputs.structure" type="number" min="0" step="0.1" />
        </label>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { storeToRefs } from 'pinia'
import { useShipStore } from '../stores/ship'

const { legacyOptionsInputs, engineInputs } = storeToRefs(useShipStore())
</script>

<template>
  <div class="panel">
    <h2 class="panel-title">Options</h2>

    <div class="form-section">
      <div class="form-section-title">Design rules</div>
      <div class="field-row">
        <label class="field">
          <span class="field-label">Charge hardpoints (turret mounts)</span>
          <select v-model="legacyOptionsInputs.chargeForHardpoints" class="select-narrow">
            <option :value="false">No</option>
            <option :value="true">Yes</option>
          </select>
        </label>
        <label class="field">
          <span class="field-label">Auto-calc accommodations</span>
          <select v-model="legacyOptionsInputs.autoCalcAccom" class="select-narrow">
            <option :value="false">No</option>
            <option :value="true">Yes</option>
          </select>
        </label>
      </div>
      <div class="field-row">
        <label class="field">
          <span class="field-label">MilStd jump (×10 cost)</span>
          <select v-model="engineInputs.milStdJump" class="select-narrow">
            <option :value="false">No</option>
            <option :value="true">Yes</option>
          </select>
        </label>
        <label class="field">
          <span class="field-label">Optimize power tons (stored)</span>
          <select v-model="legacyOptionsInputs.optPowerTon" class="select-narrow">
            <option :value="false">No</option>
            <option :value="true">Yes</option>
          </select>
        </label>
        <label class="field">
          <span class="field-label">MilStd modifier (stored)</span>
          <input v-model.number="legacyOptionsInputs.milStdMod" type="number" step="0.0001" class="input-wide" />
        </label>
      </div>
    </div>
  </div>
</template>

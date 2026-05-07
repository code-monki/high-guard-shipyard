<script setup lang="ts">
/* PanelFuel — fuel inputs: power plant and jump fuel quantities, liquid-hydrogen tanks, scoops, and purification. */
import { storeToRefs } from 'pinia'
import { useShipStore } from '../stores/ship'

const { fuelInputs } = storeToRefs(useShipStore())
</script>

<template>
  <div class="panel">
    <h2 class="panel-title">Fuel</h2>

    <div class="form-section">
      <div class="form-section-title">Standard fuel</div>
      <div class="field-row">
        <label class="field">
          <span class="field-label">P-Plant fuel (weeks)</span>
          <input v-model.number="fuelInputs.pFuel" type="number" min="0" />
        </label>
        <label class="field">
          <span class="field-label">J-fuel (jumps)</span>
          <input v-model.number="fuelInputs.jFuel" type="number" min="0" />
        </label>
        <label class="field">
          <span class="field-label">Extra fuel (t)</span>
          <input v-model.number="fuelInputs.extraFuel" type="number" min="0" />
        </label>
      </div>
      <div class="field-row">
        <label class="field">
          <span class="field-label">Base P-fuel</span>
          <input v-model.number="fuelInputs.basePFuel" type="number" min="0" />
        </label>
        <label class="field">
          <span class="field-label">Base J-fuel</span>
          <input v-model.number="fuelInputs.baseJFuel" type="number" min="0" />
        </label>
        <label class="field">
          <span class="field-label">Base extra fuel (t)</span>
          <input v-model.number="fuelInputs.baseEFuel" type="number" min="0" step="0.1" />
        </label>
      </div>
    </div>

    <div class="form-section">
      <div class="form-section-title">Drop tanks / LHyd</div>
      <div class="field-row">
        <label class="field">
          <span class="field-label">LHyd P-fuel (weeks)</span>
          <input v-model.number="fuelInputs.lhydPFuel" type="number" min="0" />
        </label>
        <label class="field">
          <span class="field-label">LHyd J-fuel (jumps)</span>
          <input v-model.number="fuelInputs.lhydJFuel" type="number" min="0" />
        </label>
        <label class="field">
          <span class="field-label">LHyd extra fuel (t)</span>
          <input v-model.number="fuelInputs.lhydExtraFuel" type="number" min="0" step="0.1" />
        </label>
      </div>
    </div>

    <div class="form-section">
      <div class="form-section-title">Scoops &amp; purification</div>
      <div class="field-row">
        <label class="field">
          <span class="field-label">Scoops</span>
          <select v-model.number="fuelInputs.scoops" class="select-narrow">
            <option :value="0">No</option>
            <option :value="1">Yes</option>
          </select>
        </label>
        <label class="field">
          <span class="field-label">Purifier</span>
          <select v-model.number="fuelInputs.purifier" class="select-narrow">
            <option :value="0">No</option>
            <option :value="1">Yes</option>
          </select>
        </label>
        <label class="field">
          <span class="field-label">Purify LHyd</span>
          <select v-model="fuelInputs.purifyLHyd" class="select-narrow">
            <option :value="false">No</option>
            <option :value="true">Yes</option>
          </select>
        </label>
        <label class="field">
          <span class="field-label">Purifier refit?</span>
          <select v-model="fuelInputs.refitPurif" class="select-narrow">
            <option :value="false">No</option>
            <option :value="true">Yes</option>
          </select>
        </label>
        <label class="field">
          <span class="field-label">Purifier refit TL</span>
          <input v-model.number="fuelInputs.refitPurifTech" type="number" min="0" />
        </label>
      </div>
    </div>
  </div>
</template>

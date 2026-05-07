<script setup lang="ts">
/* PanelAvionics — electronics inputs: computers, bridges, flag bridge, flight avionics, sensors, and comms. */
import { storeToRefs } from 'pinia'
import { useShipStore } from '../stores/ship'

const { avionicsInputs } = storeToRefs(useShipStore())
</script>

<template>
  <div class="panel">
    <h2 class="panel-title">Electronics</h2>

    <div class="form-section">
      <div class="form-section-title">Computers</div>
      <div class="avionics-table">
        <div></div>
        <div class="av-head">Main</div>
        <div class="av-head">Backup</div>
        <div class="av-head">Backup qty</div>

        <div class="av-label">Computer index</div>
        <input v-model.number="avionicsInputs.mainComp" type="number" min="0" max="20" />
        <input v-model.number="avionicsInputs.bakComp"  type="number" min="0" max="20" />
        <input v-model.number="avionicsInputs.bakCompNum" type="number" min="0" />
      </div>
    </div>

    <div class="form-section">
      <div class="form-section-title">Bridges</div>
      <div class="avionics-table">
        <div></div>
        <div class="av-head">Main (0=yes)</div>
        <div class="av-head">Backup (0=yes)</div>
        <div class="av-head">Backup qty</div>

        <div class="av-label">Bridge</div>
        <input v-model.number="avionicsInputs.bridge"    type="number" min="0" max="1" />
        <input v-model.number="avionicsInputs.bakBridge" type="number" min="0" max="1" />
        <input v-model.number="avionicsInputs.bakBridgeNum" type="number" min="0" />
      </div>
      <div class="field-row" style="margin-top:0.4rem">
        <label class="field">
          <span class="field-label">Flag bridge</span>
          <select v-model="avionicsInputs.flagBridge" class="select-narrow">
            <option :value="false">No</option>
            <option :value="true">Yes</option>
          </select>
        </label>
        <label class="field">
          <span class="field-label">Flag computer</span>
          <input v-model.number="avionicsInputs.flagComp" type="number" min="0" max="20" />
        </label>
      </div>
    </div>

    <div class="form-section">
      <div class="form-section-title">Sensors &amp; Comms</div>
      <div class="avionics-table">
        <div></div>
        <div class="av-head">Main</div>
        <div class="av-head">Backup</div>
        <div class="av-head">Backup qty</div>

        <div class="av-label">Flight avionics</div>
        <input v-model.number="avionicsInputs.fltAvionics"    type="number" min="0" />
        <input v-model.number="avionicsInputs.bakFltAvionics" type="number" min="0" />
        <input v-model.number="avionicsInputs.bakFltAvionicsNum" type="number" min="0" />

        <div class="av-label">Sensors</div>
        <input v-model.number="avionicsInputs.sensors"    type="number" min="0" />
        <input v-model.number="avionicsInputs.bakSensors" type="number" min="0" />
        <input v-model.number="avionicsInputs.bakSensorsNum" type="number" min="0" />

        <div class="av-label">Comms</div>
        <input v-model.number="avionicsInputs.comms"    type="number" min="0" />
        <input v-model.number="avionicsInputs.bakComms" type="number" min="0" />
        <input v-model.number="avionicsInputs.bakCommsNum" type="number" min="0" />
      </div>
      <div class="field-row" style="margin-top:0.4rem">
        <label class="field">
          <span class="field-label">Comms type (0/1/2)</span>
          <input v-model.number="avionicsInputs.commsType" type="number" min="0" max="2" />
        </label>
      </div>
    </div>
  </div>
</template>

<style scoped>
.avionics-table {
  display: grid;
  grid-template-columns: max-content repeat(3, max-content);
  gap: 0.35rem 0.75rem;
  align-items: center;
}

.av-head {
  font-size: 0.72rem;
  font-weight: 800;
  letter-spacing: 0.05em;
  text-transform: uppercase;
  color: var(--color-text-muted);
  text-align: center;
  padding-bottom: 0.2rem;
  border-bottom: 1px solid var(--color-border-subtle);
}

.av-label {
  font-size: 0.82rem;
  font-weight: 600;
  color: var(--color-text-secondary);
  white-space: nowrap;
  padding-right: 0.5rem;
}

.avionics-table input { width: 4.5rem; }
</style>

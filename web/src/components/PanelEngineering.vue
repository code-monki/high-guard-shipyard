<script setup lang="ts">
import { storeToRefs } from 'pinia'
import { useShipStore } from '../stores/ship'

const { engineInputs } = storeToRefs(useShipStore())
</script>

<template>
  <div class="panel">
    <h2 class="panel-title">Engineering</h2>

    <!-- Drive table: 3 columns (M-Drive, J-Drive, Power Plant) -->
    <div class="form-section">
      <div class="drive-table">
        <!-- Headers -->
        <div></div>
        <div class="drive-col-head">M-Drive</div>
        <div class="drive-col-head">J-Drive</div>
        <div class="drive-col-head">Power Plant</div>

        <!-- Primary -->
        <div class="drive-row-label">Primary</div>
        <input v-model.number="engineInputs.mDrive"  type="number" min="0" />
        <input v-model.number="engineInputs.jDrive"  type="number" min="0" />
        <input v-model.number="engineInputs.pPlant"  type="number" min="0" />

        <!-- Refit -->
        <div class="drive-row-label">Refit?</div>
        <select v-model="engineInputs.mDriveIsRefitted" class="select-narrow">
          <option :value="false">No</option><option :value="true">Yes</option>
        </select>
        <select v-model="engineInputs.jDriveIsRefitted" class="select-narrow">
          <option :value="false">No</option><option :value="true">Yes</option>
        </select>
        <select v-model="engineInputs.pPlantIsRefitted" class="select-narrow">
          <option :value="false">No</option><option :value="true">Yes</option>
        </select>

        <!-- New (refit target) -->
        <div class="drive-row-label">New (refit)</div>
        <input v-model.number="engineInputs.newMDrive" type="number" min="0" />
        <input v-model.number="engineInputs.newJDrive" type="number" min="0" />
        <input v-model.number="engineInputs.newPPlant" type="number" min="0" />

        <!-- Backup -->
        <div class="drive-row-label">Backup</div>
        <input v-model.number="engineInputs.bakMDrive" type="number" min="0" />
        <input v-model.number="engineInputs.bakJDrive" type="number" min="0" />
        <input v-model.number="engineInputs.bakPPlant" type="number" min="0" />

        <!-- Backup count -->
        <div class="drive-row-label">Backup qty</div>
        <input v-model.number="engineInputs.bakMDriveNum" type="number" min="0" />
        <input v-model.number="engineInputs.bakJDriveNum" type="number" min="0" />
        <input v-model.number="engineInputs.bakPPlantNum" type="number" min="0" />

        <!-- Backup refit -->
        <div class="drive-row-label">Backup refit?</div>
        <select v-model="engineInputs.bakMDriveIsRefitted" class="select-narrow">
          <option :value="false">No</option><option :value="true">Yes</option>
        </select>
        <select v-model="engineInputs.bakJDriveIsRefitted" class="select-narrow">
          <option :value="false">No</option><option :value="true">Yes</option>
        </select>
        <select v-model="engineInputs.bakPPlantIsRefitted" class="select-narrow">
          <option :value="false">No</option><option :value="true">Yes</option>
        </select>

        <!-- New backup -->
        <div class="drive-row-label">New backup</div>
        <input v-model.number="engineInputs.bakNewMDrive" type="number" min="0" />
        <input v-model.number="engineInputs.bakNewJDrive" type="number" min="0" />
        <input v-model.number="engineInputs.bakNewPPlant" type="number" min="0" />

        <!-- New backup count -->
        <div class="drive-row-label">New backup qty</div>
        <input v-model.number="engineInputs.bakNewMDriveNum" type="number" min="0" />
        <input v-model.number="engineInputs.bakNewJDriveNum" type="number" min="0" />
        <input v-model.number="engineInputs.bakNewPPlantNum" type="number" min="0" />
      </div>
    </div>

    <!-- J-Drive extras -->
    <div class="form-section">
      <div class="form-section-title">J-Drive options</div>
      <div class="field-row">
        <label class="field">
          <span class="field-label">MilStd jump (×10 cost)</span>
          <select v-model="engineInputs.milStdJump" class="select-narrow">
            <option :value="false">No</option>
            <option :value="true">Yes</option>
          </select>
        </label>
      </div>
    </div>

    <!-- Power Plant extras (refit TL + T20 power tons) -->
    <div class="form-section">
      <div class="form-section-title">Power Plant details</div>
      <div class="field-row">
        <label class="field">
          <span class="field-label">P-Plant refit TL</span>
          <input v-model.number="engineInputs.pPlantRefitTech" type="number" min="0" />
        </label>
        <label class="field">
          <span class="field-label">Backup PP refit TL</span>
          <input v-model.number="engineInputs.bakPPlantRefitTech" type="number" min="0" />
        </label>
      </div>
      <div class="form-section-title" style="margin-top:0.4rem">T20/General power tons</div>
      <div class="field-row">
        <label class="field">
          <span class="field-label">Power tons</span>
          <input v-model.number="engineInputs.powerTons" type="number" min="0" />
        </label>
        <label class="field">
          <span class="field-label">Refit?</span>
          <select v-model="engineInputs.powerTonsIsRefitted" class="select-narrow">
            <option :value="false">No</option><option :value="true">Yes</option>
          </select>
        </label>
        <label class="field">
          <span class="field-label">New power tons</span>
          <input v-model.number="engineInputs.newPowerTons" type="number" min="0" step="0.1" />
        </label>
        <label class="field">
          <span class="field-label">Refit TL</span>
          <input v-model.number="engineInputs.powerTonsRefitTech" type="number" min="0" />
        </label>
      </div>
      <div class="field-row">
        <label class="field">
          <span class="field-label">Backup power tons</span>
          <input v-model.number="engineInputs.bakPowerTons" type="number" min="0" step="0.1" />
        </label>
        <label class="field">
          <span class="field-label">Backup PT count</span>
          <input v-model.number="engineInputs.bakPowerTonsNum" type="number" min="0" />
        </label>
        <label class="field">
          <span class="field-label">Backup PT refit?</span>
          <select v-model="engineInputs.bakPowerTonsIsRefitted" class="select-narrow">
            <option :value="false">No</option><option :value="true">Yes</option>
          </select>
        </label>
        <label class="field">
          <span class="field-label">New backup PT</span>
          <input v-model.number="engineInputs.bakNewPowerTons" type="number" min="0" step="0.1" />
        </label>
        <label class="field">
          <span class="field-label">New backup PT qty</span>
          <input v-model.number="engineInputs.bakNewPowerTonsNum" type="number" min="0" />
        </label>
        <label class="field">
          <span class="field-label">Backup PT refit TL</span>
          <input v-model.number="engineInputs.bakPowerTonsRefitTech" type="number" min="0" />
        </label>
      </div>
      <div class="field-row">
        <label class="field">
          <span class="field-label">Upgrade space (t)</span>
          <input v-model.number="engineInputs.upgradeSpace" type="number" min="0" step="0.1" />
        </label>
      </div>
    </div>
  </div>
</template>

<style scoped>
.drive-table {
  display: grid;
  grid-template-columns: max-content repeat(3, max-content);
  gap: 0.35rem 0.75rem;
  align-items: center;
}

.drive-col-head {
  font-size: 0.72rem;
  font-weight: 800;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  color: var(--color-text-muted);
  text-align: center;
  padding-bottom: 0.2rem;
  border-bottom: 1px solid var(--color-border-subtle);
}

.drive-row-label {
  font-size: 0.82rem;
  font-weight: 600;
  color: var(--color-text-secondary);
  white-space: nowrap;
  padding-right: 0.5rem;
}

.drive-table input,
.drive-table select {
  width: 5rem;
}
</style>

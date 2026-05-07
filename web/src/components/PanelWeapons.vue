<script setup lang="ts">
import { storeToRefs } from 'pinia'
import { useShipStore } from '../stores/ship'

const { weaponInputs } = storeToRefs(useShipStore())
</script>

<template>
  <div class="panel">
    <h2 class="panel-title">Weapons</h2>

    <!-- Spinal -->
    <div class="form-section">
      <div class="form-section-title">Spinal mount</div>
      <div class="field-row">
        <label class="field">
          <span class="field-label">Type (0=none, 1=meson, 2=PA)</span>
          <input v-model.number="weaponInputs.spinalType"  type="number" min="0" max="2" />
        </label>
        <label class="field">
          <span class="field-label">Mount index</span>
          <input v-model.number="weaponInputs.spinalMount" type="number" min="0" max="18" />
        </label>
      </div>
    </div>

    <!-- Big bays (100t) -->
    <div class="form-section">
      <div class="form-section-title">Large bays (100t)</div>
      <div class="field-row">
        <label class="field"><span class="field-label">Empty</span>
          <input v-model.number="weaponInputs.bigEmptyBays"    type="number" min="0" /></label>
        <label class="field"><span class="field-label">Meson</span>
          <input v-model.number="weaponInputs.bigMesonBays"    type="number" min="0" /></label>
        <label class="field"><span class="field-label">PA</span>
          <input v-model.number="weaponInputs.bigPaBays"       type="number" min="0" /></label>
        <label class="field"><span class="field-label">Repulsor</span>
          <input v-model.number="weaponInputs.bigRepulsorBays" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Missile</span>
          <input v-model.number="weaponInputs.bigMissileBays"  type="number" min="0" /></label>
      </div>
    </div>

    <!-- Little bays (50t) -->
    <div class="form-section">
      <div class="form-section-title">Small bays (50t)</div>
      <div class="field-row">
        <label class="field"><span class="field-label">Empty</span>
          <input v-model.number="weaponInputs.littleEmptyBays"    type="number" min="0" /></label>
        <label class="field"><span class="field-label">Meson</span>
          <input v-model.number="weaponInputs.littleMesonBays"    type="number" min="0" /></label>
        <label class="field"><span class="field-label">PA</span>
          <input v-model.number="weaponInputs.littlePaBays"       type="number" min="0" /></label>
        <label class="field"><span class="field-label">Repulsor</span>
          <input v-model.number="weaponInputs.littleRepulsorBays" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Missile</span>
          <input v-model.number="weaponInputs.littleMissileBays"  type="number" min="0" /></label>
        <label class="field"><span class="field-label">Energy</span>
          <input v-model.number="weaponInputs.littleEnergyBays"   type="number" min="0" /></label>
        <label class="field"><span class="field-label">Energy type (0/1)</span>
          <input v-model.number="weaponInputs.littleEnergyType"   type="number" min="0" max="1" /></label>
      </div>
    </div>

    <!-- Turrets -->
    <div class="form-section">
      <div class="form-section-title">Turrets</div>
      <div class="field-row">
        <label class="field">
          <span class="field-label">Mode (0=mixed, 1=standard)</span>
          <input v-model.number="weaponInputs.mixedTurrets" type="number" min="0" max="1" />
        </label>
      </div>

      <!-- Mixed mode fields -->
      <div class="turret-table-mixed">
        <div></div>
        <div class="t-head">Count</div>
        <div class="t-head">Style</div>
        <div class="t-head">Empty</div>
        <div class="t-head">Missiles</div>
        <div class="t-head">Lasers</div>
        <div class="t-head">Energy</div>
        <div class="t-head">Sand</div>

        <div class="t-label">Mixed</div>
        <input v-model.number="weaponInputs.numMixTurrets"     type="number" min="0" />
        <input v-model.number="weaponInputs.mixTurretStyle"    type="number" min="0" max="3" />
        <input v-model.number="weaponInputs.emptyMixTurrets"   type="number" min="0" />
        <input v-model.number="weaponInputs.mixTurretMissiles" type="number" min="0" />
        <input v-model.number="weaponInputs.mixTurretLasers"   type="number" min="0" />
        <input v-model.number="weaponInputs.mixTurretEnergy"   type="number" min="0" />
        <input v-model.number="weaponInputs.mixTurretSand"     type="number" min="0" />
      </div>

      <!-- Standard mode: per-type rows -->
      <div class="turret-table" style="margin-top:0.5rem">
        <div></div>
        <div class="t-head">Count</div>
        <div class="t-head">Batteries</div>
        <div class="t-head">Style</div>
        <div class="t-head">Type</div>

        <div class="t-label">Empty</div>
        <input v-model.number="weaponInputs.emptyTurrets"      type="number" min="0" />
        <div></div>
        <input v-model.number="weaponInputs.emptyTurretStyle"  type="number" min="0" max="3" />
        <div></div>

        <div class="t-label">Missile</div>
        <input v-model.number="weaponInputs.missileTurrets"          type="number" min="0" />
        <input v-model.number="weaponInputs.missileTurretBatteries"  type="number" min="0" />
        <input v-model.number="weaponInputs.missileTurretStyle"      type="number" min="0" max="3" />
        <div></div>

        <div class="t-label">Laser</div>
        <input v-model.number="weaponInputs.laserTurrets"         type="number" min="0" />
        <input v-model.number="weaponInputs.laserTurretBatteries" type="number" min="0" />
        <input v-model.number="weaponInputs.laserTurretStyle"     type="number" min="0" max="3" />
        <input v-model.number="weaponInputs.laserType"            type="number" min="0" max="1" />

        <div class="t-label">Energy</div>
        <input v-model.number="weaponInputs.energyTurrets"         type="number" min="0" />
        <input v-model.number="weaponInputs.energyTurretBatteries" type="number" min="0" />
        <input v-model.number="weaponInputs.energyTurretStyle"     type="number" min="0" max="2" />
        <input v-model.number="weaponInputs.energyType"            type="number" min="0" max="1" />

        <div class="t-label">Sand</div>
        <input v-model.number="weaponInputs.sandTurrets"         type="number" min="0" />
        <input v-model.number="weaponInputs.sandTurretBatteries" type="number" min="0" />
        <input v-model.number="weaponInputs.sandTurretStyle"     type="number" min="0" max="3" />
        <div></div>

        <div class="t-label">PA</div>
        <input v-model.number="weaponInputs.paTurrets"         type="number" min="0" />
        <input v-model.number="weaponInputs.paTurretBatteries" type="number" min="0" />
        <input v-model.number="weaponInputs.paTurretStyle"     type="number" min="0" max="1" />
        <div></div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.turret-table-mixed {
  display: grid;
  grid-template-columns: max-content repeat(7, max-content);
  gap: 0.3rem 0.6rem;
  align-items: center;
}

.turret-table {
  display: grid;
  grid-template-columns: max-content repeat(4, max-content);
  gap: 0.3rem 0.6rem;
  align-items: center;
}

.t-head {
  font-size: 0.7rem;
  font-weight: 800;
  letter-spacing: 0.05em;
  text-transform: uppercase;
  color: var(--color-text-muted);
  text-align: center;
  padding-bottom: 0.2rem;
  border-bottom: 1px solid var(--color-border-subtle);
}

.t-label {
  font-size: 0.82rem;
  font-weight: 600;
  color: var(--color-text-secondary);
  white-space: nowrap;
  padding-right: 0.4rem;
}

.turret-table input { width: 4.5rem; }
.turret-table-mixed input { width: 4.5rem; }
</style>

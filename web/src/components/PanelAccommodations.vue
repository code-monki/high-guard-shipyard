<script setup lang="ts">
/* PanelAccommodations — accommodation inputs: quarters, passengers, cargo, drop capsules, crew, and facilities. */
import { storeToRefs } from 'pinia'
import { useShipStore } from '../stores/ship'

const { accomInputs } = storeToRefs(useShipStore())
</script>

<template>
  <div class="panel">
    <h2 class="panel-title">Accommodations</h2>

    <div class="form-section">
      <div class="form-section-title">Quarters</div>
      <div class="field-row">
        <label class="field"><span class="field-label">Staterooms</span>
          <input v-model.number="accomInputs.stRoom" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Small-craft staterooms</span>
          <input v-model.number="accomInputs.smStRoom" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Couches</span>
          <input v-model.number="accomInputs.couches" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Low berths</span>
          <input v-model.number="accomInputs.lowBerth" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Emergency low berths</span>
          <input v-model.number="accomInputs.emLowBerth" type="number" min="0" /></label>
      </div>
      <div class="field-row">
        <label class="field"><span class="field-label">Double occupancy</span>
          <select v-model.number="accomInputs.dblOccMark" class="select-narrow">
            <option :value="0">No</option><option :value="1">Yes</option>
          </select>
        </label>
        <label class="field"><span class="field-label">Crew rules (0/1)</span>
          <input v-model.number="accomInputs.crewRules" type="number" min="0" max="1" /></label>
        <label class="field"><span class="field-label">Alt crew rules</span>
          <input v-model.number="accomInputs.alternateCrewRules" type="number" min="0" /></label>
      </div>
    </div>

    <div class="form-section">
      <div class="form-section-title">Passengers &amp; cargo</div>
      <div class="field-row">
        <label class="field"><span class="field-label">High passengers</span>
          <input v-model.number="accomInputs.highPass" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Mid passengers</span>
          <input v-model.number="accomInputs.midPass" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Low passengers</span>
          <input v-model.number="accomInputs.lowPass" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Cargo (t)</span>
          <input v-model.number="accomInputs.cargo" type="number" min="0" step="0.1" /></label>
      </div>
    </div>

    <div class="form-section">
      <div class="form-section-title">Drop capsules</div>
      <div class="field-row">
        <label class="field"><span class="field-label">Launchers</span>
          <input v-model.number="accomInputs.dropCaps" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Ready capsules</span>
          <input v-model.number="accomInputs.readyDropCaps" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Stored capsules</span>
          <input v-model.number="accomInputs.storedDropCaps" type="number" min="0" /></label>
      </div>
    </div>

    <div class="form-section">
      <div class="form-section-title">Crew</div>
      <div class="field-row">
        <label class="field"><span class="field-label">Marines</span>
          <input v-model.number="accomInputs.marines" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Ship troops (0=yes)</span>
          <input v-model.number="accomInputs.shpTrpMark" type="number" min="0" max="1" /></label>
        <label class="field"><span class="field-label">Craft crew</span>
          <input v-model.number="accomInputs.craftCrew" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Other crew</span>
          <input v-model.number="accomInputs.otherCrew" type="number" min="0" /></label>
        <label class="field"><span class="field-label">UserDef crew</span>
          <input v-model.number="accomInputs.userDefCrew" type="number" min="0" /></label>
      </div>
      <div class="field-row">
        <label class="field"><span class="field-label">Craft cmd crew</span>
          <input v-model.number="accomInputs.craftCmdCrew" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Accom cmd crew</span>
          <input v-model.number="accomInputs.accomCmdCrew" type="number" min="0" /></label>
        <label class="field"><span class="field-label">UserDef cmd crew</span>
          <input v-model.number="accomInputs.userDefCmdCrew" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Frozen watch %</span>
          <input v-model.number="accomInputs.frozWatch" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Crew sections</span>
          <input v-model.number="accomInputs.numCrewSections" type="number" min="1" /></label>
      </div>
      <div class="field-row">
        <label class="field"><span class="field-label">Book 2 captain</span>
          <select v-model="accomInputs.bk2Captain" class="select-narrow">
            <option :value="false">No</option><option :value="true">Yes</option>
          </select>
        </label>
        <label class="field"><span class="field-label">Flagship</span>
          <select v-model="accomInputs.flagship" class="select-narrow">
            <option :value="false">No</option><option :value="true">Yes</option>
          </select>
        </label>
      </div>
    </div>

    <div class="form-section">
      <div class="form-section-title">Facilities</div>
      <div class="field-row">
        <label class="field"><span class="field-label">Eng shops</span>
          <input v-model.number="accomInputs.engShop" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Vehicle shops</span>
          <input v-model.number="accomInputs.vehicleShop" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Labs</span>
          <input v-model.number="accomInputs.labs" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Sick bays</span>
          <input v-model.number="accomInputs.sickBay" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Auto docs</span>
          <input v-model.number="accomInputs.autoDoc" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Airlocks</span>
          <input v-model.number="accomInputs.airlock" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Freshers</span>
          <input v-model.number="accomInputs.fresher" type="number" min="0" /></label>
        <label class="field"><span class="field-label">Missile mag (t)</span>
          <input v-model.number="accomInputs.missileMag" type="number" min="0" step="0.1" /></label>
      </div>
    </div>
  </div>
</template>

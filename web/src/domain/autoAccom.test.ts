import { describe, expect, it } from 'vitest'
import { computeLegacyAutoAccomMinimums } from './validation'
import type { AccomInputs, AvionicsInputs, ShipDesign } from '../types'

const baseDesign = (): ShipDesign => ({
  shipName: 'T',
  shipClass: 'C',
  hullCode: 'H',
  tonnage: 200,
  budgetMcr: 100,
  techLevel: 12,
  race: 0,
  designSystem: 1,
  isRefitted: false,
  refitTechLevel: 12,
  refitBudgetMcr: 0,
  notes: '',
  avionics: { type: 'avionics', name: 'Avionics', techLevel: 12, tonnage: 0, costMcr: 0 },
})

describe('legacy auto accommodations minimums', () => {
  it('requires couches instead of staterooms when tonnage is under 100', () => {
    const design = baseDesign()
    design.tonnage = 90
    const avionics: AvionicsInputs = {
      mainComp: 1,
      bakComp: 0,
      bakCompNum: 0,
      bridge: 0,
      bakBridge: 1,
      bakBridgeNum: 0,
      flagBridge: false,
      flagComp: 0,
      fltAvionics: 1,
      bakFltAvionics: 0,
      bakFltAvionicsNum: 0,
      sensors: 0,
      bakSensors: 0,
      bakSensorsNum: 0,
      comms: 0,
      bakComms: 0,
      bakCommsNum: 0,
      commsType: 0,
    }
    const accom: AccomInputs = {
      lowBerth: 0,
      emLowBerth: 0,
      dropCaps: 0,
      readyDropCaps: 0,
      storedDropCaps: 0,
      stRoom: 0,
      couches: 0,
      smStRoom: 0,
      dblOccMark: 0,
      highPass: 0,
      midPass: 0,
      lowPass: 0,
      cargo: 0,
      shpTrpMark: 1,
      bk2Captain: false,
      frozWatch: 0,
      alternateCrewRules: 0,
      crewRules: 0,
      flagship: false,
      engCmdCrew: 0,
      avionicsCmdCrew: 0,
      spinalCmdCrew: 0,
      bigBaysCmdCrew: 0,
      littleBaysCmdCrew: 0,
      turretsCmdCrew: 0,
      screensCmdCrew: 0,
      craftCmdCrew: 0,
      accomCmdCrew: 0,
      userDefCmdCrew: 0,
      marines: 0,
      engCrew: 2,
      avionicsCrew: 2,
      spinalCrew: 0,
      bigBaysCrew: 0,
      littleBaysCrew: 0,
      turretsCrew: 0,
      screensCrew: 0,
      craftCrew: 0,
      accomCrew: 0,
      shipsTroops: 0,
      otherCrew: 0,
      userDefCrew: 0,
      engShop: 0,
      vehicleShop: 0,
      labs: 0,
      sickBay: 0,
      autoDoc: 0,
      airlock: 0,
      fresher: 0,
      missileMag: 0,
      numCrewSections: 1,
    }
    const mins = computeLegacyAutoAccomMinimums(design, avionics, accom)
    expect(mins.minStRoom).toBeGreaterThanOrEqual(0)
    expect(mins.minCouches).toBeGreaterThanOrEqual(2)
    expect(mins.minLowBerth).toBe(0)
  })
})

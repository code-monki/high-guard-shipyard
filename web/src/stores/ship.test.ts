import { beforeEach, describe, expect, it } from 'vitest'
import { createPinia, setActivePinia } from 'pinia'
import { useShipStore } from './ship'

const snapshot = (store: ReturnType<typeof useShipStore>) => JSON.parse(JSON.stringify({
  design: store.design,
  hull: store.hullInputs,
  engine: store.engineInputs,
  fuel: store.fuelInputs,
  avionics: store.avionicsInputs,
  weapons: store.weaponInputs,
  screens: store.screenInputs,
  accom: store.accomInputs,
  userDef: store.userDefInputs,
  craft: store.craftInputs,
  legacyOptions: store.legacyOptionsInputs,
}))

describe('ship store defaults', () => {
  beforeEach(() => {
    setActivePinia(createPinia())
  })

  it('restores every input to its initial default after reset', () => {
    const store = useShipStore()
    const initial = snapshot(store)

    store.design.tonnage = 42
    store.hullInputs.armour = 99
    store.engineInputs.pPlant = 1
    store.fuelInputs.pFuel = 0
    store.avionicsInputs.mainComp = 0
    store.weaponInputs.bigMissileBays = 4
    store.screenInputs.extraCaps = 3
    store.accomInputs.frozWatch = 4
    store.userDefInputs.items[0].size = 10
    store.craftInputs.items[0].tonnage = 10
    store.legacyOptionsInputs.milStdMod = 0.5

    store.resetDesign()

    expect(snapshot(store)).toEqual(initial)
  })
})

import { describe, expect, it } from 'vitest'
import {
  computeAccomModule,
  computeAvionicsModule,
  computeBigBaysModule,
  computeCraftModule,
  computeEngineModule,
  computeFuelModule,
  computeHullModule,
  computeLittleBaysModule,
  computeScreensModule,
  computeSpinalModule,
  computeTurretsModule,
  computeUserDefModule,
} from './calculations'
import { validateDesign } from './validation'
import type {
  AccomInputs,
  AvionicsInputs,
  EngineInputs,
  FuelInputs,
  HullInputs,
  ScreenInputs,
  ShipDesign,
  UserDefInputs,
  WeaponInputs,
} from '../types'

const baseDesign = (): ShipDesign => ({
  shipName: 'Test Hull',
  shipClass: 'Test',
  hullCode: 'A00000',
  tonnage: 1000,
  budgetMcr: 10000,
  techLevel: 13,
  race: 1,
  designSystem: 1,
  isRefitted: false,
  refitTechLevel: 13,
  refitBudgetMcr: 0,
  notes: '',
  avionics: { type: 'avionics', name: 'Avionics', techLevel: 13, tonnage: 0, costMcr: 0 },
})

const baseEngine = (): EngineInputs => ({
  mDrive: 2,
  mDriveIsRefitted: false,
  newMDrive: 0,
  bakMDrive: 0,
  bakMDriveIsRefitted: false,
  bakNewMDrive: 0,
  bakMDriveNum: 1,
  bakNewMDriveNum: 1,
  jDrive: 2,
  jDriveIsRefitted: false,
  newJDrive: 0,
  bakJDrive: 0,
  bakJDriveIsRefitted: false,
  bakNewJDrive: 0,
  bakJDriveNum: 1,
  bakNewJDriveNum: 1,
  pPlant: 3,
  pPlantIsRefitted: false,
  newPPlant: 0,
  pPlantRefitTech: 13,
  bakPPlant: 0,
  bakPPlantIsRefitted: false,
  bakNewPPlant: 0,
  bakPPlantRefitTech: 13,
  bakPPlantNum: 1,
  bakNewPPlantNum: 1,
  powerTons: 100,
  powerTonsIsRefitted: false,
  newPowerTons: 0,
  powerTonsRefitTech: 13,
  bakPowerTons: 0,
  bakPowerTonsNum: 1,
  bakPowerTonsIsRefitted: false,
  bakNewPowerTons: 0,
  bakNewPowerTonsNum: 1,
  bakPowerTonsRefitTech: 13,
  upgradeSpace: 0,
  singleEngSpace: false,
  driveUpgradesAllowed: false,
  milStdJump: false,
})

const baseFuel = (): FuelInputs => ({
  pFuel: 28,
  lhydPFuel: 0,
  lhydJFuel: 0,
  jFuel: 1,
  extraFuel: 0,
  lhydExtraFuel: 0,
  scoops: 1,
  purifier: 1,
  purifyLHyd: false,
  refitPurif: false,
  refitPurifTech: 13,
  basePFuel: 0,
  baseJFuel: 0,
  baseEFuel: 0,
})

const baseHull = (): HullInputs => ({
  config: 3,
  armour: 0,
  streamLining: 1,
  airframe: 1,
  structure: 0,
})

const baseAvionics = (): AvionicsInputs => ({
  mainComp: 7,
  bakComp: 0,
  bakCompNum: 0,
  bridge: 0,
  bakBridge: 1,
  bakBridgeNum: 0,
  flagBridge: false,
  flagComp: 0,
  fltAvionics: 2,
  bakFltAvionics: 0,
  bakFltAvionicsNum: 0,
  sensors: 1,
  bakSensors: 0,
  bakSensorsNum: 0,
  comms: 1,
  bakComms: 0,
  bakCommsNum: 0,
  commsType: 0,
})

const baseWeapons = (): WeaponInputs => ({
  spinalType: 0,
  spinalMount: 0,
  bigEmptyBays: 0,
  bigMesonBays: 0,
  bigPaBays: 0,
  bigRepulsorBays: 0,
  bigMissileBays: 0,
  littleEmptyBays: 0,
  littleMesonBays: 0,
  littlePaBays: 0,
  littleRepulsorBays: 0,
  littleMissileBays: 0,
  littleEnergyBays: 0,
  littleEnergyType: 0,
  paTurrets: 0,
  missileTurrets: 0,
  sandTurretBatteries: 0,
  laserTurretBatteries: 0,
  energyTurretBatteries: 0,
  paTurretBatteries: 0,
  missileTurretBatteries: 0,
  emptyTurretStyle: 0,
  missileTurretStyle: 0,
  laserTurretStyle: 0,
  energyTurretStyle: 0,
  sandTurretStyle: 0,
  paTurretStyle: 0,
  mixTurretStyle: 0,
  mixTurretMissiles: 0,
  mixTurretLasers: 0,
  mixTurretEnergy: 0,
  mixTurretSand: 0,
  emptyMixTurrets: 0,
  laserType: 0,
  energyType: 0,
  mixedTurrets: 1,
  numMixTurrets: 0,
  emptyTurrets: 0,
  laserTurrets: 0,
  energyTurrets: 0,
  sandTurrets: 0,
})

const baseScreens = (): ScreenInputs => ({
  nucDamp: 0,
  mesScrn: 0,
  blkGlb: 0,
  bakNucDamp: 0,
  bakMesScrn: 0,
  bakBlkGlb: 0,
  bakNucDampNum: 0,
  bakMesScrnNum: 0,
  bakBlkGlbNum: 0,
  extraCaps: 0,
})

const baseAccom = (): AccomInputs => ({
  lowBerth: 0,
  emLowBerth: 0,
  dropCaps: 0,
  readyDropCaps: 0,
  storedDropCaps: 0,
  stRoom: 40,
  couches: 10,
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
  crewRules: 1,
  flagship: false,
  engCmdCrew: 1,
  avionicsCmdCrew: 1,
  spinalCmdCrew: 0,
  bigBaysCmdCrew: 0,
  littleBaysCmdCrew: 0,
  turretsCmdCrew: 0,
  screensCmdCrew: 0,
  craftCmdCrew: 0,
  accomCmdCrew: 1,
  userDefCmdCrew: 0,
  marines: 0,
  engCrew: 5,
  avionicsCrew: 2,
  spinalCrew: 0,
  bigBaysCrew: 0,
  littleBaysCrew: 0,
  turretsCrew: 0,
  screensCrew: 0,
  craftCrew: 0,
  accomCrew: 1,
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
})

const baseUserDef = (): UserDefInputs => ({ items: Array.from({ length: 8 }, () => ({ num: 0, size: 0, crew: 0, ep: 0, cost: 0, hp: 0, desc: '' })) })
const baseCraft = () => ({
  items: Array.from({ length: 8 }, () => ({ num: 0, tonnage: 0, crew: 0, vehicle: 0, price: 0, desc: '' })),
  ftrSqd: 0,
  lf1Num: 0,
  lf1Size: 0,
  lf2Num: 0,
  lf2Size: 0,
})

const fullDesignOutcome = (args?: {
  design?: Partial<ShipDesign>
  hull?: Partial<HullInputs>
  engine?: Partial<EngineInputs>
  fuel?: Partial<FuelInputs>
  avionics?: Partial<AvionicsInputs>
  weapons?: Partial<WeaponInputs>
  screens?: Partial<ScreenInputs>
  accom?: Partial<AccomInputs>
  userDef?: Partial<UserDefInputs>
}) => {
  const design = { ...baseDesign(), ...(args?.design ?? {}) }
  const hull = { ...baseHull(), ...(args?.hull ?? {}) }
  const engine = { ...baseEngine(), ...(args?.engine ?? {}) }
  const fuel = { ...baseFuel(), ...(args?.fuel ?? {}) }
  const avionics = { ...baseAvionics(), ...(args?.avionics ?? {}) }
  const weapons = { ...baseWeapons(), ...(args?.weapons ?? {}) }
  const screens = { ...baseScreens(), ...(args?.screens ?? {}) }
  const accom = { ...baseAccom(), ...(args?.accom ?? {}) }
  const userDef = { ...baseUserDef(), ...(args?.userDef ?? {}) }
  const craft = baseCraft()

  const modules = [
    computeHullModule(design.tonnage, design.techLevel, hull),
    computeEngineModule(design.tonnage, design.techLevel, design.race, design.designSystem, engine),
    computeFuelModule(design.tonnage, design.techLevel, design.race, design.designSystem, engine, fuel),
    computeAvionicsModule(design.tonnage, design.techLevel, design.race, design.designSystem, avionics),
    computeSpinalModule(design.techLevel, design.race, weapons),
    computeBigBaysModule(design.techLevel, design.race, weapons),
    computeLittleBaysModule(design.techLevel, design.race, weapons),
    computeTurretsModule(design.techLevel, design.race, weapons),
    computeScreensModule(design.tonnage, design.techLevel, screens),
    computeAccomModule(design.techLevel, design.race, accom.crewRules, accom),
    computeUserDefModule(design.techLevel, userDef),
    computeCraftModule(design.techLevel, design.tonnage, hull.config, craft),
  ]
  const usedTonnage = modules.reduce((sum, m) => sum + m.tonnage, 0)
  const usedBudget = modules.reduce((sum, m) => sum + m.costMcr, 0)
  const totalEpOutput = modules.reduce((sum, m) => sum + (m.epOutput ?? 0), 0)
  const totalEpDemand = modules.reduce((sum, m) => sum + (m.epDemand ?? 0), 0)
  const validationCodes = validateDesign(
    design,
    hull,
    engine,
    fuel,
    avionics,
    weapons,
    screens,
    accom,
    userDef,
    {
      remainingTonnage: design.tonnage - usedTonnage,
      remainingBudget: design.budgetMcr - usedBudget,
      remainingEp: totalEpOutput - totalEpDemand,
    },
  )
    .map((i) => i.code)
    .sort((a, b) => a - b)
  return {
    totals: {
      usedTonnage: Number(usedTonnage.toFixed(3)),
      usedBudget: Number(usedBudget.toFixed(3)),
      totalEpOutput: Number(totalEpOutput.toFixed(3)),
      totalEpDemand: Number(totalEpDemand.toFixed(3)),
    },
    validationCodes,
  }
}

describe('parity checkpoints', () => {
  it('uses refitted backup drive counts in engineering tonnage', () => {
    const engine = baseEngine()
    engine.bakMDrive = 2
    engine.bakMDriveNum = 1
    engine.bakMDriveIsRefitted = true
    engine.bakNewMDrive = 2
    engine.bakNewMDriveNum = 3

    const module = computeEngineModule(1000, 13, 1, 1, engine)
    // bak m-drive space = max(1000*((3*2-1)/100),1) * 3 = 50 * 3 = 150
    expect(module.tonnage).toBeGreaterThanOrEqual(150)
  })

  it('uses refitted power tons for T20 fuel calculations', () => {
    const engine = baseEngine()
    engine.powerTons = 100
    engine.powerTonsIsRefitted = true
    engine.newPowerTons = 200
    engine.powerTonsRefitTech = 13
    const fuel = baseFuel()
    fuel.pFuel = 28

    const module = computeFuelModule(1000, 13, 1, 0, engine, fuel)
    // At TL13 human in T20: pFuelSpace = powerTons * weeks / 28
    expect(module.tonnage).toBe(200 + 100) // 200 p-fuel + 100 j-fuel
  })

  it('validates jump computer requirement from effective refitted j-drive', () => {
    const design = baseDesign()
    const engine = baseEngine()
    engine.jDriveIsRefitted = true
    engine.newJDrive = 4

    const avionics = baseAvionics()
    avionics.mainComp = 1 // model/1, should fail for jump 4

    const issues = validateDesign(
      design,
      baseHull(),
      engine,
      baseFuel(),
      avionics,
      baseWeapons(),
      baseScreens(),
      baseAccom(),
      baseUserDef(),
      { remainingTonnage: 0, remainingBudget: 0, remainingEp: 0 },
    )
    expect(issues.some((i) => i.code === 36)).toBe(true)
  })

  it('does not emit over-budget code for refit designs', () => {
    const design = baseDesign()
    design.isRefitted = true
    const issues = validateDesign(
      design,
      baseHull(),
      baseEngine(),
      baseFuel(),
      baseAvionics(),
      baseWeapons(),
      baseScreens(),
      baseAccom(),
      baseUserDef(),
      { remainingTonnage: 0, remainingBudget: -10, remainingEp: 0 },
    )
    expect(issues.some((i) => i.code === 2)).toBe(false)
  })

  it('emits expected legacy validation codes for representative scenarios', () => {
    const scenarios: Array<{
      name: string
      mutate: (args: {
        design: ShipDesign
        engine: EngineInputs
        avionics: AvionicsInputs
        fuel: FuelInputs
        accom: AccomInputs
      }) => void
      expectedCode: number
    }> = [
      {
        name: 'small craft with jump drive',
        mutate: ({ design, engine }) => {
          design.tonnage = 99
          engine.jDrive = 1
        },
        expectedCode: 8,
      },
      {
        name: 'm-drive TL restriction',
        mutate: ({ design, engine }) => {
          design.techLevel = 7
          engine.mDrive = 3
        },
        expectedCode: 9,
      },
      {
        name: 'backup jump TL restriction',
        mutate: ({ design, engine }) => {
          design.techLevel = 10
          engine.bakJDrive = 2
        },
        expectedCode: 20,
      },
      {
        name: 'power plant smaller than m-drive',
        mutate: ({ engine }) => {
          engine.mDrive = 4
          engine.pPlant = 3
        },
        expectedCode: 25,
      },
      {
        name: 'missing computer for jump-capable ship',
        mutate: ({ engine, avionics }) => {
          engine.jDrive = 1
          avionics.mainComp = 0
        },
        expectedCode: 33,
      },
      {
        name: 'jump-2 requires better computer',
        mutate: ({ engine, avionics }) => {
          engine.jDrive = 2
          avionics.mainComp = 1
        },
        expectedCode: 34,
      },
      {
        name: 'low berth TL restriction',
        mutate: ({ design, accom }) => {
          design.techLevel = 8
          accom.lowBerth = 1
        },
        expectedCode: 96,
      },
      {
        name: 'drop capsule TL restriction',
        mutate: ({ design, accom }) => {
          design.techLevel = 9
          accom.dropCaps = 1
        },
        expectedCode: 98,
      },
      {
        name: 'small craft fib/bis computer restriction',
        mutate: ({ design, avionics }) => {
          design.tonnage = 50
          avionics.mainComp = 2
        },
        expectedCode: 107,
      },
      {
        name: 'small craft fib/bis backup computer restriction',
        mutate: ({ design, avionics }) => {
          design.tonnage = 50
          avionics.bakComp = 2
        },
        expectedCode: 108,
      },
    ]

    for (const scenario of scenarios) {
      const design = baseDesign()
      const engine = baseEngine()
      const avionics = baseAvionics()
      const fuel = baseFuel()
      const accom = baseAccom()
      scenario.mutate({ design, engine, avionics, fuel, accom })

      const issues = validateDesign(
        design,
        baseHull(),
        engine,
        fuel,
        avionics,
        baseWeapons(),
        baseScreens(),
        accom,
        baseUserDef(),
        { remainingTonnage: 0, remainingBudget: 0, remainingEp: 0 },
      )

      expect(
        issues.some((i) => i.code === scenario.expectedCode),
        `${scenario.name} should include code ${scenario.expectedCode}; got [${issues.map((i) => i.code).join(', ')}]`,
      ).toBe(true)
    }
  })

  it('emits expected legacy weapon and screen validation codes', () => {
    const scenarios: Array<{
      name: string
      mutate: (args: {
        design: ShipDesign
        weapons: WeaponInputs
        screens: ScreenInputs
      }) => void
      expectedCode: number
    }> = [
      {
        name: 'hardpoint overage',
        mutate: ({ design, weapons }) => {
          design.tonnage = 100
          weapons.emptyTurrets = 2 // only 1 hardpoint available
        },
        expectedCode: 51,
      },
      {
        name: 'mixed turrets over 1000 tons',
        mutate: ({ design, weapons }) => {
          design.tonnage = 2000
          weapons.mixedTurrets = 0
          weapons.numMixTurrets = 1
        },
        expectedCode: 73,
      },
      {
        name: 'spinal meson with big meson bay',
        mutate: ({ weapons }) => {
          weapons.spinalType = 1
          weapons.spinalMount = 1
          weapons.bigMesonBays = 1
        },
        expectedCode: 74,
      },
      {
        name: 'spinal PA with PA turrets',
        mutate: ({ weapons }) => {
          weapons.spinalType = 2
          weapons.spinalMount = 1
          weapons.paTurrets = 1
        },
        expectedCode: 78,
      },
      {
        name: 'big and little meson bays mixed',
        mutate: ({ weapons }) => {
          weapons.bigMesonBays = 1
          weapons.littleMesonBays = 1
        },
        expectedCode: 79,
      },
      {
        name: 'big missile bays with missile turrets',
        mutate: ({ weapons }) => {
          weapons.bigMissileBays = 1
          weapons.missileTurrets = 1
        },
        expectedCode: 84,
      },
      {
        name: 'little energy bays with energy turrets',
        mutate: ({ weapons }) => {
          weapons.littleEnergyBays = 1
          weapons.energyTurrets = 1
        },
        expectedCode: 89,
      },
      {
        name: 'nuclear damper TL restriction',
        mutate: ({ design, screens }) => {
          design.techLevel = 11
          screens.nucDamp = 1 // requires TL12
        },
        expectedCode: 90,
      },
      {
        name: 'meson screen TL restriction',
        mutate: ({ design, screens }) => {
          design.techLevel = 11
          screens.mesScrn = 1 // requires TL12
        },
        expectedCode: 91,
      },
      {
        name: 'black globe TL restriction',
        mutate: ({ design, screens }) => {
          design.techLevel = 14
          screens.blkGlb = 1 // requires TL15
        },
        expectedCode: 92,
      },
      {
        name: 'backup nuclear damper TL restriction',
        mutate: ({ design, screens }) => {
          design.techLevel = 11
          screens.bakNucDamp = 1
        },
        expectedCode: 93,
      },
      {
        name: 'backup meson screen TL restriction',
        mutate: ({ design, screens }) => {
          design.techLevel = 11
          screens.bakMesScrn = 1
        },
        expectedCode: 94,
      },
      {
        name: 'backup black globe TL restriction',
        mutate: ({ design, screens }) => {
          design.techLevel = 14
          screens.bakBlkGlb = 1
        },
        expectedCode: 95,
      },
    ]

    for (const scenario of scenarios) {
      const design = baseDesign()
      const weapons = baseWeapons()
      const screens = baseScreens()
      scenario.mutate({ design, weapons, screens })

      const issues = validateDesign(
        design,
        baseHull(),
        baseEngine(),
        baseFuel(),
        baseAvionics(),
        weapons,
        screens,
        baseAccom(),
        baseUserDef(),
        { remainingTonnage: 0, remainingBudget: 0, remainingEp: 0 },
      )

      expect(
        issues.some((i) => i.code === scenario.expectedCode),
        `${scenario.name} should include code ${scenario.expectedCode}; got [${issues.map((i) => i.code).join(', ')}]`,
      ).toBe(true)
    }
  })

  it('emits expected legacy weapon tech-level gating codes', () => {
    const scenarios: Array<{
      name: string
      mutate: (args: {
        design: ShipDesign
        weapons: WeaponInputs
      }) => void
      expectedCode: number
    }> = [
      {
        name: 'spinal meson base TL gate',
        mutate: ({ design, weapons }) => {
          design.techLevel = 10
          weapons.spinalType = 1
          weapons.spinalMount = 1
        },
        expectedCode: 52,
      },
      {
        name: 'spinal PA base TL gate',
        mutate: ({ design, weapons }) => {
          design.techLevel = 7
          weapons.spinalType = 2
          weapons.spinalMount = 1
        },
        expectedCode: 53,
      },
      {
        name: 'big bay minimum hull size gate',
        mutate: ({ design, weapons }) => {
          design.tonnage = 900
          weapons.bigMissileBays = 1
        },
        expectedCode: 56,
      },
      {
        name: 'big meson bay TL gate',
        mutate: ({ design, weapons }) => {
          design.techLevel = 12
          weapons.bigMesonBays = 1
        },
        expectedCode: 57,
      },
      {
        name: 'little bay minimum hull size gate',
        mutate: ({ design, weapons }) => {
          design.tonnage = 900
          weapons.littleMissileBays = 1
        },
        expectedCode: 60,
      },
      {
        name: 'little meson bay TL gate',
        mutate: ({ design, weapons }) => {
          design.techLevel = 14
          weapons.littleMesonBays = 1
        },
        expectedCode: 62,
      },
      {
        name: 'little PA bay TL gate',
        mutate: ({ design, weapons }) => {
          design.techLevel = 9
          weapons.littlePaBays = 1
        },
        expectedCode: 63,
      },
      {
        name: 'little repulsor bay TL gate',
        mutate: ({ design, weapons }) => {
          design.techLevel = 13
          weapons.littleRepulsorBays = 1
        },
        expectedCode: 64,
      },
      {
        name: 'little missile bay TL gate',
        mutate: ({ design, weapons }) => {
          design.techLevel = 9
          weapons.littleMissileBays = 1
        },
        expectedCode: 65,
      },
      {
        name: 'little plasma bay TL gate',
        mutate: ({ design, weapons }) => {
          design.techLevel = 9
          weapons.littleEnergyBays = 1
          weapons.littleEnergyType = 0
        },
        expectedCode: 66,
      },
      {
        name: 'little fusion bay TL gate',
        mutate: ({ design, weapons }) => {
          design.techLevel = 11
          weapons.littleEnergyBays = 1
          weapons.littleEnergyType = 1
        },
        expectedCode: 67,
      },
      {
        name: 'beam laser turret TL gate',
        mutate: ({ design, weapons }) => {
          design.techLevel = 8
          weapons.laserTurrets = 1
          weapons.laserType = 0
        },
        expectedCode: 68,
      },
      {
        name: 'plasma turret TL gate',
        mutate: ({ design, weapons }) => {
          design.techLevel = 9
          weapons.energyTurrets = 1
          weapons.energyType = 0
        },
        expectedCode: 69,
      },
      {
        name: 'fusion turret TL gate',
        mutate: ({ design, weapons }) => {
          design.techLevel = 11
          weapons.energyTurrets = 1
          weapons.energyType = 1
        },
        expectedCode: 70,
      },
      {
        name: 'PA turret TL gate',
        mutate: ({ design, weapons }) => {
          design.techLevel = 13
          weapons.paTurrets = 1
        },
        expectedCode: 71,
      },
      {
        name: 'mixed turret beam laser TL gate',
        mutate: ({ design, weapons }) => {
          design.techLevel = 8
          weapons.mixedTurrets = 0
          weapons.numMixTurrets = 1
          weapons.mixTurretLasers = 1
          weapons.laserType = 0
        },
        expectedCode: 72,
      },
    ]

    for (const scenario of scenarios) {
      const design = baseDesign()
      const weapons = baseWeapons()
      scenario.mutate({ design, weapons })

      const issues = validateDesign(
        design,
        baseHull(),
        baseEngine(),
        baseFuel(),
        baseAvionics(),
        weapons,
        baseScreens(),
        baseAccom(),
        baseUserDef(),
        { remainingTonnage: 0, remainingBudget: 0, remainingEp: 0 },
      )

      expect(
        issues.some((i) => i.code === scenario.expectedCode),
        `${scenario.name} should include code ${scenario.expectedCode}; got [${issues.map((i) => i.code).join(', ')}]`,
      ).toBe(true)
    }
  })

  it('matches golden-case full design outcomes', () => {
    const goldenCases = {
      defaultHgProfile: fullDesignOutcome(),
      t20PowerRefitProfile: fullDesignOutcome({
        design: { designSystem: 0, race: 1, tonnage: 2000, techLevel: 14 },
        engine: {
          powerTons: 120,
          powerTonsIsRefitted: true,
          newPowerTons: 180,
          powerTonsRefitTech: 15,
          bakPowerTons: 40,
        },
        fuel: { pFuel: 56, jFuel: 2 },
      }),
      smallCraftEdgeProfile: fullDesignOutcome({
        design: { tonnage: 90, techLevel: 10, budgetMcr: 800 },
        engine: { mDrive: 2, jDrive: 0, pPlant: 2 },
        avionics: { bridge: 1, mainComp: 1 },
        accom: { couches: 4, crewRules: 0 },
      }),
      weaponHeavyProfile: fullDesignOutcome({
        design: { tonnage: 10000, techLevel: 15, budgetMcr: 50000 },
        weapons: {
          bigMissileBays: 4,
          littleMissileBays: 4,
          missileTurrets: 12,
          missileTurretBatteries: 12,
          mixedTurrets: 1,
        },
        screens: { nucDamp: 2, mesScrn: 2 },
      }),
      refitDriveProfile: fullDesignOutcome({
        design: { tonnage: 5000, techLevel: 12 },
        engine: {
          mDrive: 2,
          mDriveIsRefitted: true,
          newMDrive: 4,
          jDrive: 2,
          jDriveIsRefitted: true,
          newJDrive: 3,
          pPlant: 3,
          pPlantIsRefitted: true,
          newPPlant: 5,
          pPlantRefitTech: 13,
          bakMDrive: 1,
          bakMDriveNum: 2,
          bakMDriveIsRefitted: true,
          bakNewMDrive: 2,
          bakNewMDriveNum: 2,
        },
      }),
    }

    expect(goldenCases).toMatchInlineSnapshot(`
      {
        "defaultHgProfile": {
          "totals": {
            "totalEpDemand": 26,
            "totalEpOutput": 30,
            "usedBudget": 478.25,
            "usedTonnage": 2273,
          },
          "validationCodes": [
            1,
          ],
        },
        "refitDriveProfile": {
          "totals": {
            "totalEpDemand": 276,
            "totalEpOutput": 250,
            "usedBudget": 3488.25,
            "usedTonnage": 4583,
          },
          "validationCodes": [
            5,
            2001,
          ],
        },
        "smallCraftEdgeProfile": {
          "totals": {
            "totalEpDemand": 2.25,
            "totalEpOutput": 1.8,
            "usedBudget": 75.85,
            "usedTonnage": 1967.5,
          },
          "validationCodes": [
            1,
            5,
            100,
            2002,
          ],
        },
        "t20PowerRefitProfile": {
          "totals": {
            "totalEpDemand": 51,
            "totalEpOutput": 360,
            "usedBudget": 1208.95,
            "usedTonnage": 3161.6,
          },
          "validationCodes": [
            1,
            2001,
          ],
        },
        "weaponHeavyProfile": {
          "totals": {
            "totalEpDemand": 311,
            "totalEpOutput": 300,
            "usedBudget": 3898.65,
            "usedTonnage": 5852,
          },
          "validationCodes": [
            5,
            45,
            82,
            84,
            87,
            2001,
          ],
        },
      }
    `)
  })
})

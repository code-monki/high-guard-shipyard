/* ship.ts — Pinia store that holds all reactive ship-design state, derives module computations, runs validation, and exposes import/export actions. */

import { computed, ref, watchEffect } from 'vue'
import { defineStore } from 'pinia'
import {
  computeAvionicsModule,
  computeEngineModule,
  computeFuelModule,
  computeHullModule,
  computeLittleBaysModule,
  computeBigBaysModule,
  computeTurretsModule,
  computeScreensModule,
  computeSpinalModule,
  computeAccomModule,
  computeCraftModule,
  computeUserDefModule,
} from '../domain/calculations'
import { defaultLegacyOptionsInputs, parseHgsText, serializeHgsText } from '../domain/hgs'
import { computeLegacyAutoAccomMinimums, validateDesign } from '../domain/validation'
import type {
  AccomInputs,
  AvionicsInputs,
  CraftInputs,
  EngineInputs,
  FuelInputs,
  HullInputs,
  LegacyOptionsInputs,
  ScreenInputs,
  ShipDesign,
  ShipModule,
  UserDefInputs,
  WeaponInputs,
} from '../types'

const defaultDesign = (): ShipDesign => ({
  shipName: 'ISS Example',
  shipClass: 'Frontier Patrol',
  hullCode: 'A24689',
  tonnage: 5000,
  budgetMcr: 2500,
  techLevel: 13,
  race: 1,
  designSystem: 1,
  isRefitted: false,
  refitTechLevel: 13,
  refitBudgetMcr: 0,
  notes:
    'Prototype web port in progress. Hull/Engineering/Fuel values now come from translated Pascal formulas.',
  avionics: { type: 'avionics', name: 'Avionics', techLevel: 13, tonnage: 0, costMcr: 0, epDemand: 0 },
})

const SPINAL_MESON_SPACE = [0, 5000, 8000, 2000, 5000, 1000, 2000, 1000, 2000, 1000, 8000, 5000, 4000, 2000, 8000, 7000, 5000, 8000, 7000]
const SPINAL_PA_SPACE = [0, 5500, 5000, 4500, 4000, 3500, 3000, 2500, 2500, 5000, 4500, 4000, 3500, 3000, 2500, 4500, 4000, 3500, 3000]

export const useShipStore = defineStore('ship', () => {
  const hgsRawLines = ref<string[] | null>(null)
  const design = ref<ShipDesign>(defaultDesign())
  const hullInputs = ref<HullInputs>({
    config: 3,
    armour: 2,
    streamLining: 0,
    airframe: 1,
    structure: 0,
  })
  const engineInputs = ref<EngineInputs>({
    mDrive: 4,
    mDriveIsRefitted: false,
    newMDrive: 0,
    bakMDrive: 0,
    bakMDriveIsRefitted: false,
    bakNewMDrive: 0,
    bakMDriveNum: 1,
    bakNewMDriveNum: 1,
    jDrive: 3,
    jDriveIsRefitted: false,
    newJDrive: 0,
    bakJDrive: 0,
    bakJDriveIsRefitted: false,
    bakNewJDrive: 0,
    bakJDriveNum: 1,
    bakNewJDriveNum: 1,
    pPlant: 7,
    pPlantIsRefitted: false,
    newPPlant: 0,
    pPlantRefitTech: 13,
    bakPPlant: 0,
    bakPPlantIsRefitted: false,
    bakNewPPlant: 0,
    bakPPlantRefitTech: 13,
    bakPPlantNum: 1,
    bakNewPPlantNum: 1,
    powerTons: 300,
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
  const fuelInputs = ref<FuelInputs>({
    pFuel: 4,
    lhydPFuel: 0,
    lhydJFuel: 0,
    jFuel: 3,
    extraFuel: 0,
    lhydExtraFuel: 0,
    scoops: 0,
    purifier: 0,
    purifyLHyd: false,
    refitPurif: false,
    refitPurifTech: 13,
    basePFuel: 0,
    baseJFuel: 0,
    baseEFuel: 0,
  })
  const avionicsInputs = ref<AvionicsInputs>({
    mainComp: 13,
    bakComp: 7,
    bakCompNum: 1,
    bridge: 0,
    bakBridge: 1,
    bakBridgeNum: 0,
    flagBridge: false,
    flagComp: 0,
    fltAvionics: 6,
    bakFltAvionics: 4,
    bakFltAvionicsNum: 1,
    sensors: 5,
    bakSensors: 3,
    bakSensorsNum: 1,
    comms: 5,
    bakComms: 3,
    bakCommsNum: 1,
    commsType: 0,
  })
  const weaponInputs = ref<WeaponInputs>({
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
  const screenInputs = ref<ScreenInputs>({
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
  const accomInputs = ref<AccomInputs>({
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
    crewRules: 1,
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
    engCrew: 0,
    avionicsCrew: 0,
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
  })
  const userDefInputs = ref<UserDefInputs>({
    items: Array.from({ length: 8 }, () => ({
      num: 0,
      size: 0,
      crew: 0,
      ep: 0,
      cost: 0,
      hp: 0,
      desc: '',
    })),
  })
  const craftInputs = ref<CraftInputs>({
    items: Array.from({ length: 8 }, () => ({
      num: 0,
      tonnage: 0,
      crew: 0,
      vehicle: 0,
      price: 0,
      desc: '',
    })),
    ftrSqd: 0,
    lf1Num: 0,
    lf1Size: 0,
    lf2Num: 0,
    lf2Size: 0,
  })
  const legacyOptionsInputs = ref<LegacyOptionsInputs>(defaultLegacyOptionsInputs())

  /** Computed hull module result (tonnage consumed and cost). */
  const hullModule = computed(() =>
    computeHullModule(design.value.tonnage, design.value.techLevel, hullInputs.value),
  )
  /** Computed engineering module result (drive/power-plant tonnage, cost, EP output and M-Drive demand). */
  const engineModule = computed(() =>
    computeEngineModule(
      design.value.tonnage,
      design.value.techLevel,
      design.value.race,
      design.value.designSystem,
      engineInputs.value,
    ),
  )
  /** Computed fuel module result (tankage tonnage and cost). */
  const fuelModule = computed(() =>
    computeFuelModule(
      design.value.tonnage,
      design.value.techLevel,
      design.value.race,
      design.value.designSystem,
      engineInputs.value,
      fuelInputs.value,
    ),
  )
  /** Computed avionics module result (computers, bridges, sensors tonnage, cost, and EP demand). */
  const avionicsModule = computed(() =>
    computeAvionicsModule(
      design.value.tonnage,
      design.value.techLevel,
      design.value.race,
      design.value.designSystem,
      avionicsInputs.value,
    ),
  )
  /** Computed screens module result (dampers, meson screens, black globes tonnage, cost, and EP demand). */
  const screensModule = computed(() =>
    computeScreensModule(
      design.value.tonnage,
      design.value.techLevel,
      screenInputs.value,
    ),
  )
  /** Computed spinal mount module result (tonnage, cost, and EP demand). */
  const spinalModule = computed(() =>
    computeSpinalModule(
      design.value.techLevel,
      design.value.race,
      weaponInputs.value,
    ),
  )
  /** Computed 100-ton bays module result (tonnage, cost, and EP demand). */
  const bigBaysModule = computed(() =>
    computeBigBaysModule(
      design.value.techLevel,
      design.value.race,
      weaponInputs.value,
    ),
  )
  /** Computed 50-ton bays module result (tonnage, cost, and EP demand). */
  const littleBaysModule = computed(() =>
    computeLittleBaysModule(
      design.value.techLevel,
      design.value.race,
      weaponInputs.value,
    ),
  )
  /** Computed turrets module result (tonnage, cost, and EP demand). */
  const turretsModule = computed(() =>
    computeTurretsModule(
      design.value.techLevel,
      design.value.race,
      weaponInputs.value,
      legacyOptionsInputs.value.chargeForHardpoints,
    ),
  )
  /** Computed accommodations module result (quarters, passengers, facilities tonnage and cost). */
  const accomModule = computed(() =>
    computeAccomModule(
      design.value.techLevel,
      design.value.race,
      accomInputs.value.crewRules,
      accomInputs.value,
    ),
  )
  /** Computed user-defined components module result (aggregate tonnage, cost, and EP demand). */
  const userDefModule = computed(() =>
    computeUserDefModule(
      design.value.techLevel,
      userDefInputs.value,
    ),
  )
  /** Computed craft facilities module result (small craft and launcher tonnage and cost). */
  const craftModule = computed(() =>
    computeCraftModule(
      design.value.techLevel,
      design.value.tonnage,
      hullInputs.value.config,
      craftInputs.value,
    ),
  )
  const modules = computed<ShipModule[]>(() => [
    hullModule.value,
    engineModule.value,
    fuelModule.value,
    avionicsModule.value,
    spinalModule.value,
    bigBaysModule.value,
    littleBaysModule.value,
    turretsModule.value,
    screensModule.value,
    accomModule.value,
    userDefModule.value,
    craftModule.value,
  ])

  /** Sum of tonnage across all design modules. */
  const usedTonnage = computed(() =>
    modules.value.reduce((total, module) => total + module.tonnage, 0),
  )
  /** Sum of cost (MCr) across all design modules. */
  const usedBudget = computed(() =>
    modules.value.reduce((total, module) => total + module.costMcr, 0),
  )
  /** Total Energy Points produced by all power-plant modules. */
  const totalEpOutput = computed(() =>
    modules.value.reduce((total, module) => total + (module.epOutput ?? 0), 0),
  )
  /** Total Energy Points consumed by all modules. */
  const totalEpDemand = computed(() =>
    modules.value.reduce((total, module) => total + (module.epDemand ?? 0), 0),
  )
  const remainingTonnage = computed(() => design.value.tonnage - usedTonnage.value)
  const remainingBudget = computed(() => design.value.budgetMcr - usedBudget.value)
  const remainingEp = computed(() => totalEpOutput.value - totalEpDemand.value)
  const buildAccomWithDerivedCrew = (): AccomInputs => {
    const effectiveJDrive = engineInputs.value.jDriveIsRefitted
      ? engineInputs.value.newJDrive
      : engineInputs.value.jDrive
    const deriveEngineeringCrew = () => {
      const size = design.value.tonnage
      const crewType = accomInputs.value.crewRules
      const eEngSpace = engineModule.value.tonnage
      if (crewType === 0 && size >= 200) return { cmd: 0, crew: Math.ceil(eEngSpace / 35) }
      if (crewType === 1 && size >= 100) return { cmd: 1, crew: Math.ceil(eEngSpace / 100 - 1) }
      return { cmd: 0, crew: 0 }
    }
    const deriveAvionicsCrew = () => {
      const size = design.value.tonnage
      const crewType = accomInputs.value.crewRules
      if (crewType === 0 || size < 100) {
        return { cmd: 0, crew: size <= 200 || effectiveJDrive === 0 ? 1 : 2 }
      }
      return { cmd: 1, crew: Math.max(10, Math.ceil((size / 10000) * 5) - 1) }
    }
    const deriveScreensCrew = () => {
      const size = design.value.tonnage
      const rules = accomInputs.value.crewRules
      const hasPrimaryScreens =
        screenInputs.value.nucDamp > 0 ||
        screenInputs.value.mesScrn > 0 ||
        screenInputs.value.blkGlb > 0
      const crew =
        (screenInputs.value.nucDamp > 0 ? 4 : 0) +
        (screenInputs.value.mesScrn > 0 ? 4 : 0) +
        (screenInputs.value.blkGlb > 0 ? 4 : 0)
      const cmd = rules === 1 && size >= 100 && hasPrimaryScreens ? 1 : 0
      return { cmd, crew }
    }
    const deriveSpinalCrew = () => {
      const hasSpinal = weaponInputs.value.spinalType > 0 && weaponInputs.value.spinalMount > 0
      if (!hasSpinal) return { cmd: 0, crew: 0 }
      const mount = weaponInputs.value.spinalMount
      const space =
        weaponInputs.value.spinalType === 1
          ? (SPINAL_MESON_SPACE[mount] ?? 0)
          : weaponInputs.value.spinalType === 2
            ? (SPINAL_PA_SPACE[mount] ?? 0)
            : 0
      if (space <= 0) return { cmd: 0, crew: 0 }
      const divisor = design.value.race === 1 ? 200 : 100
      return { cmd: 1, crew: Math.ceil(space / divisor) }
    }
    const deriveBigBaysCrew = () => {
      const armed =
        weaponInputs.value.bigMesonBays +
        weaponInputs.value.bigPaBays +
        weaponInputs.value.bigRepulsorBays +
        weaponInputs.value.bigMissileBays
      const cmd = accomInputs.value.crewRules === 1 && design.value.tonnage >= 100 && armed > 0 ? 1 : 0
      return { cmd, crew: armed * 2 }
    }
    const deriveLittleBaysCrew = () => {
      const armed =
        weaponInputs.value.littleMesonBays +
        weaponInputs.value.littlePaBays +
        weaponInputs.value.littleRepulsorBays +
        weaponInputs.value.littleMissileBays +
        weaponInputs.value.littleEnergyBays
      const cmd = accomInputs.value.crewRules === 1 && design.value.tonnage >= 100 && armed > 0 ? 1 : 0
      return { cmd, crew: armed * 2 }
    }
    const deriveTurretsCrew = () => {
      const size = design.value.tonnage
      const rules = accomInputs.value.crewRules
      const w = weaponInputs.value
      const sandGunners = Math.min(w.sandTurrets, w.sandTurretBatteries)
      const laserGunners = Math.min(w.laserTurrets, w.laserTurretBatteries)
      const energyGunners = Math.min(w.energyTurrets, w.energyTurretBatteries)
      const paGunners = Math.min(w.paTurrets, w.paTurretBatteries)
      const missGunners = Math.min(w.missileTurrets, w.missileTurretBatteries)

      let cmd = 0
      let crew = 0
      if (rules === 0) {
        if (w.mixedTurrets === 0) {
          if (size < 100) {
            crew = Math.max(
              0,
              w.mixTurretLasers * w.numMixTurrets +
                w.mixTurretMissiles * w.numMixTurrets +
                w.mixTurretEnergy * w.numMixTurrets +
                w.mixTurretSand * w.numMixTurrets,
            )
            crew = Math.min(w.numMixTurrets, crew)
          } else {
            crew = w.numMixTurrets - w.emptyMixTurrets
          }
        } else if (size < 100) {
          crew = Math.max(0, sandGunners + laserGunners + energyGunners + paGunners + missGunners)
        } else {
          crew = sandGunners + laserGunners + energyGunners + paGunners + missGunners
        }
      } else if (size < 100) {
        if (w.mixedTurrets === 0) {
          let mixGunners = 0
          if (w.mixTurretLasers > 0) mixGunners += w.numMixTurrets
          if (w.mixTurretMissiles > 0) mixGunners += w.numMixTurrets
          if (w.mixTurretEnergy > 0) mixGunners += w.numMixTurrets
          mixGunners -= 1
          crew = Math.max(0, mixGunners)
        } else {
          crew = Math.max(0, laserGunners + energyGunners + paGunners + missGunners - 1)
        }
      } else {
        if (
          w.missileTurretBatteries +
            w.laserTurretBatteries +
            w.energyTurretBatteries +
            w.sandTurretBatteries +
            w.paTurretBatteries >
          0
        ) {
          cmd = 1
        }
        crew = sandGunners + laserGunners + energyGunners + paGunners + missGunners
      }
      return { cmd, crew: Math.max(0, crew) }
    }
    const deriveAccomCrew = () => {
      const size = design.value.tonnage
      const rules = accomInputs.value.crewRules
      const totPass = accomInputs.value.highPass + accomInputs.value.midPass + accomInputs.value.lowPass
      let cmd = 0
      let crew = 0
      let shipsTroops = 0
      if (rules === 0) {
        cmd = accomInputs.value.bk2Captain ? 1 : 0
        if (accomInputs.value.highPass > 0) {
          crew += Math.floor(accomInputs.value.highPass / 8)
          if (accomInputs.value.highPass % 8 !== 0) crew += 1
        }
        if ((totPass > 0 || size >= 200) && effectiveJDrive !== 0) {
          crew += Math.max(1, Math.floor(totPass / 120))
          if (totPass > 0 && size >= 200 && totPass % 120 !== 0 && totPass > 120) crew += 1
        }
      } else if (rules === 1) {
        cmd = 1
        crew += Math.round(size / 500) - 1
        if (accomInputs.value.shpTrpMark === 0) shipsTroops = Math.round(size / 1000)
      }
      return { cmd: Math.max(0, cmd), crew: Math.max(0, crew), shipsTroops: Math.max(0, shipsTroops) }
    }
    const deriveCraftCrew = () => {
      const isVehicle = (v: number): boolean => v === 1
      const numVehicles = craftInputs.value.items.reduce(
        (sum, item) => sum + (isVehicle(item.vehicle) ? item.num : 0),
        0,
      )
      const numCraft = craftInputs.value.items.reduce(
        (sum, item) => sum + (!isVehicle(item.vehicle) ? item.num : 0),
        0,
      )
      let cmd = 0
      let crew = 0
      if (accomInputs.value.crewRules === 0 || design.value.tonnage < 100) {
        crew += craftInputs.value.items.reduce((sum, item) => sum + item.num * item.crew, 0)
        crew += (craftInputs.value.lf1Num + craftInputs.value.lf2Num) * 10
      } else {
        cmd = numCraft > 0 || numVehicles > 0 ? 1 : 0
        crew += craftInputs.value.items.reduce(
          (sum, item) => sum + (!isVehicle(item.vehicle) ? item.num : 0),
          0,
        )
        crew += craftInputs.value.items.reduce((sum, item) => sum + item.num * item.crew, 0)
        crew += (craftInputs.value.lf1Num + craftInputs.value.lf2Num) * 10
        if (numVehicles > 2) {
          crew += Math.floor(numVehicles / 3)
          if (numVehicles % 3 !== 0) crew += 1
        }
      }
      return { cmd: Math.max(0, cmd), crew: Math.max(0, crew) }
    }
    const engCrew = deriveEngineeringCrew()
    const aviCrew = deriveAvionicsCrew()
    const scrCrew = deriveScreensCrew()
    const spiCrew = deriveSpinalCrew()
    const bigCrew = deriveBigBaysCrew()
    const litCrew = deriveLittleBaysCrew()
    const turCrew = deriveTurretsCrew()
    const accCrew = deriveAccomCrew()
    const crfCrew = deriveCraftCrew()
    const usrCrew = userDefInputs.value.items.reduce((sum, item) => sum + item.num * item.crew, 0)
    return {
      ...accomInputs.value,
      engCmdCrew: engCrew.cmd,
      engCrew: engCrew.crew,
      avionicsCmdCrew: aviCrew.cmd,
      avionicsCrew: aviCrew.crew,
      spinalCmdCrew: spiCrew.cmd,
      spinalCrew: spiCrew.crew,
      bigBaysCmdCrew: bigCrew.cmd,
      bigBaysCrew: bigCrew.crew,
      littleBaysCmdCrew: litCrew.cmd,
      littleBaysCrew: litCrew.crew,
      screensCmdCrew: scrCrew.cmd,
      screensCrew: scrCrew.crew,
      turretsCmdCrew: turCrew.cmd,
      turretsCrew: turCrew.crew,
      accomCmdCrew: accCrew.cmd,
      accomCrew: accCrew.crew,
      shipsTroops: accCrew.shipsTroops,
      craftCmdCrew: crfCrew.cmd,
      craftCrew: crfCrew.crew,
      userDefCrew: usrCrew,
    }
  }

  /** All rule violations for the current design state; empty array when the design is valid. */
  const validationIssues = computed(() =>
    validateDesign(
      design.value,
      hullInputs.value,
      engineInputs.value,
      fuelInputs.value,
      avionicsInputs.value,
      weaponInputs.value,
      screenInputs.value,
      buildAccomWithDerivedCrew(),
      userDefInputs.value,
      {
        remainingTonnage: remainingTonnage.value,
        remainingBudget: remainingBudget.value,
        remainingEp: remainingEp.value,
      },
    ),
  )

  watchEffect(() => {
    if (!legacyOptionsInputs.value.autoCalcAccom) return
    const tol = 1e-9
    for (let iter = 0; iter < 16; iter += 1) {
      const merged = buildAccomWithDerivedCrew()
      const mins = computeLegacyAutoAccomMinimums(design.value, avionicsInputs.value, merged)
      const ton = design.value.tonnage
      const cur = accomInputs.value
      let stRoom = cur.stRoom
      let couches = cur.couches
      let lowBerth = cur.lowBerth
      let changed = false
      if (ton >= 100 && Math.abs(stRoom - mins.minStRoom) > tol) {
        stRoom = mins.minStRoom
        changed = true
      }
      if (ton < 100 && Math.abs(couches - mins.minCouches) > tol) {
        couches = mins.minCouches
        changed = true
      }
      if (lowBerth + tol < mins.minLowBerth) {
        lowBerth = mins.minLowBerth
        changed = true
      }
      if (!changed) break
      accomInputs.value = { ...cur, stRoom, couches, lowBerth }
    }
  })

  /** Resets all design inputs and module state to the built-in default example ship. */
  const resetDesign = () => {
    hgsRawLines.value = null
    design.value = defaultDesign()
    hullInputs.value = { config: 3, armour: 2, streamLining: 0, airframe: 1, structure: 0 }
    engineInputs.value = {
      mDrive: 4,
      mDriveIsRefitted: false,
      newMDrive: 0,
      bakMDrive: 0,
      bakMDriveIsRefitted: false,
      bakNewMDrive: 0,
      bakMDriveNum: 1,
      bakNewMDriveNum: 1,
      jDrive: 3,
      jDriveIsRefitted: false,
      newJDrive: 0,
      bakJDrive: 0,
      bakJDriveIsRefitted: false,
      bakNewJDrive: 0,
      bakJDriveNum: 1,
      bakNewJDriveNum: 1,
      pPlant: 7,
      pPlantIsRefitted: false,
      newPPlant: 0,
      pPlantRefitTech: 13,
      bakPPlant: 0,
      bakPPlantIsRefitted: false,
      bakNewPPlant: 0,
      bakPPlantRefitTech: 13,
      bakPPlantNum: 1,
      bakNewPPlantNum: 1,
      powerTons: 300,
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
    }
    fuelInputs.value = {
      pFuel: 4,
      lhydPFuel: 0,
      lhydJFuel: 0,
      jFuel: 3,
      extraFuel: 0,
      lhydExtraFuel: 0,
      scoops: 0,
      purifier: 0,
      purifyLHyd: false,
      refitPurif: false,
      refitPurifTech: 13,
      basePFuel: 0,
      baseJFuel: 0,
      baseEFuel: 0,
    }
    avionicsInputs.value = {
      mainComp: 13,
      bakComp: 7,
      bakCompNum: 1,
      bridge: 0,
      bakBridge: 1,
      bakBridgeNum: 0,
      flagBridge: false,
      flagComp: 0,
      fltAvionics: 6,
      bakFltAvionics: 4,
      bakFltAvionicsNum: 1,
      sensors: 5,
      bakSensors: 3,
      bakSensorsNum: 1,
      comms: 5,
      bakComms: 3,
      bakCommsNum: 1,
      commsType: 0,
    }
    weaponInputs.value = {
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
    }
    screenInputs.value = {
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
    }
    accomInputs.value = {
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
      crewRules: 1,
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
      engCrew: 0,
      avionicsCrew: 0,
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
    userDefInputs.value = {
      items: Array.from({ length: 8 }, () => ({
        num: 0,
        size: 0,
        crew: 0,
        ep: 0,
        cost: 0,
        hp: 0,
        desc: '',
      })),
    }
    craftInputs.value = {
      items: Array.from({ length: 8 }, () => ({
        num: 0,
        tonnage: 0,
        crew: 0,
        vehicle: 0,
        price: 0,
        desc: '',
      })),
      ftrSqd: 0,
      lf1Num: 0,
      lf1Size: 0,
      lf2Num: 0,
      lf2Size: 0,
    }
    legacyOptionsInputs.value = defaultLegacyOptionsInputs()
  }

  /** Parses a .hgs file text string and replaces all current design inputs with the parsed values. */
  const importHgsText = (text: string): void => {
    const parsed = parseHgsText(text)
    hgsRawLines.value = parsed.rawLines
    design.value = {
      ...design.value,
      ...parsed.design,
    }
    hullInputs.value = {
      ...hullInputs.value,
      ...parsed.hull,
    }
    engineInputs.value = {
      ...engineInputs.value,
      ...parsed.engine,
    }
    fuelInputs.value = {
      ...fuelInputs.value,
      ...parsed.fuel,
    }
    avionicsInputs.value = {
      ...avionicsInputs.value,
      ...parsed.avionics,
    }
    weaponInputs.value = {
      ...weaponInputs.value,
      ...parsed.weapons,
    }
    screenInputs.value = {
      ...screenInputs.value,
      ...parsed.screens,
    }
    accomInputs.value = {
      ...accomInputs.value,
      ...parsed.accom,
    }
    userDefInputs.value = {
      ...userDefInputs.value,
      ...parsed.userDef,
    }
    craftInputs.value = {
      ...craftInputs.value,
      ...parsed.craft,
    }
    legacyOptionsInputs.value = {
      ...legacyOptionsInputs.value,
      ...parsed.legacyOptions,
    }
  }

  /** Serialises the current design to a .hgs-format string suitable for download as a file. */
  const exportHgsText = (): string =>
    serializeHgsText({
      rawLines: hgsRawLines.value ?? [],
      design: design.value,
      hull: hullInputs.value,
      engine: engineInputs.value,
      fuel: fuelInputs.value,
      avionics: avionicsInputs.value,
      weapons: weaponInputs.value,
      screens: screenInputs.value,
      accom: accomInputs.value,
      userDef: userDefInputs.value,
      craft: craftInputs.value,
      legacyOptions: legacyOptionsInputs.value,
    })

  /** Parses a JSON string exported by this tool and replaces all current design inputs with the parsed values. */
  const importJsonText = (text: string): void => {
    const data: unknown = JSON.parse(text)
    if (!data || typeof data !== 'object' || !('design' in data)) {
      throw new Error('Not a valid High Guard Shipyard JSON file')
    }
    const d = data as Record<string, unknown>
    hgsRawLines.value = null
    if (d.design) design.value = { ...design.value, ...(d.design as object) }
    if (d.hull) hullInputs.value = { ...hullInputs.value, ...(d.hull as object) }
    if (d.engine) engineInputs.value = { ...engineInputs.value, ...(d.engine as object) }
    if (d.fuel) fuelInputs.value = { ...fuelInputs.value, ...(d.fuel as object) }
    if (d.avionics) avionicsInputs.value = { ...avionicsInputs.value, ...(d.avionics as object) }
    if (d.weapons) weaponInputs.value = { ...weaponInputs.value, ...(d.weapons as object) }
    if (d.screens) screenInputs.value = { ...screenInputs.value, ...(d.screens as object) }
    if (d.accom) accomInputs.value = { ...accomInputs.value, ...(d.accom as object) }
    if (d.userDef) userDefInputs.value = { ...userDefInputs.value, ...(d.userDef as object) }
    if (d.craft) craftInputs.value = { ...craftInputs.value, ...(d.craft as object) }
    if (d.legacyOptions) legacyOptionsInputs.value = { ...legacyOptionsInputs.value, ...(d.legacyOptions as object) }
  }

  /** Serialises the current design to a JSON string suitable for download as a file. */
  const exportJsonText = (): string =>
    JSON.stringify(
      {
        version: 1,
        design: design.value,
        hull: hullInputs.value,
        engine: engineInputs.value,
        fuel: fuelInputs.value,
        avionics: avionicsInputs.value,
        weapons: weaponInputs.value,
        screens: screenInputs.value,
        accom: accomInputs.value,
        userDef: userDefInputs.value,
        craft: craftInputs.value,
        legacyOptions: legacyOptionsInputs.value,
      },
      null,
      2,
    )

  return {
    design,
    hullInputs,
    engineInputs,
    fuelInputs,
    avionicsInputs,
    weaponInputs,
    screenInputs,
    accomInputs,
    userDefInputs,
    craftInputs,
    legacyOptionsInputs,
    modules,
    hullModule,
    engineModule,
    fuelModule,
    avionicsModule,
    screensModule,
    spinalModule,
    bigBaysModule,
    littleBaysModule,
    turretsModule,
    accomModule,
    userDefModule,
    craftModule,
    usedTonnage,
    usedBudget,
    totalEpOutput,
    totalEpDemand,
    remainingTonnage,
    remainingBudget,
    remainingEp,
    validationIssues,
    resetDesign,
    importHgsText,
    exportHgsText,
    importJsonText,
    exportJsonText,
  }
})

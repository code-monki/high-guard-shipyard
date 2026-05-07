/* calculations.ts — Pure computation functions that translate High Guard design inputs into ShipModule results (tonnage, cost in MCr, EP output/demand). */

import type {
  AccomInputs,
  AvionicsInputs,
  EngineInputs,
  FuelInputs,
  HullInputs,
  ScreenInputs,
  ShipModule,
  CraftInputs,
  UserDefInputs,
  WeaponInputs,
} from '../types'

const max = (a: number, b: number): number => (a > b ? a : b)
const min = (a: number, b: number): number => (a < b ? a : b)
const round3 = (value: number): number => Math.round(value * 1000) / 1000
const intUp = (value: number): number => Math.ceil(value)

const COMPUTER_COST = [0, 2, 3, 4, 9, 14, 18, 18, 27, 30, 45, 45, 68, 55, 83, 80, 100, 110, 140, 140, 200]
const COMPUTER_TONS = [0, 1, 2, 1, 2, 4, 2, 3, 6, 4, 8, 5, 10, 7, 14, 9, 18, 11, 22, 13, 26]
const COMPUTER_EP = [0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 5, 5, 7, 7, 9, 9, 12, 12]
const NUC_DAMP_TONS = [0, 50, 15, 20, 8, 10, 12, 10, 15, 20]
const NUC_DAMP_COST = [0, 50, 40, 45, 30, 35, 38, 30, 40, 50]
const NUC_DAMP_EP = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90]
const MES_SCRN_TONS = [0, 90, 30, 45, 16, 20, 24, 20, 30, 40]
const MES_SCRN_COST = [0, 80, 50, 55, 40, 45, 50, 40, 50, 60]
const MES_SCRN_EP = [0, 0.2, 0.4, 0.6, 0.8, 1.0, 1.2, 1.4, 1.6, 1.8]
const BLK_GLB_TONS = [0, 10, 15, 20, 25, 20, 30, 35, 20, 20]
const BLK_GLB_COST = [0, 400, 600, 800, 1000, 0, 0, 0, 0, 0]
const SPINAL_MESON_COST = [0, 10000, 12000, 3000, 5000, 800, 1000, 400, 600, 400, 10000, 3000, 800, 600, 5000, 1000, 800, 2000, 1000]
const SPINAL_MESON_SPACE = [0, 5000, 8000, 2000, 5000, 1000, 2000, 1000, 2000, 1000, 8000, 5000, 4000, 2000, 8000, 7000, 5000, 8000, 7000]
const SPINAL_MESON_EP = [0, 500, 600, 600, 700, 700, 800, 800, 900, 900, 1000, 1000, 1000, 1000, 1100, 1100, 1100, 1200, 1200]
const SPINAL_PA_COST = [0, 3500, 3000, 2400, 1500, 1200, 1200, 800, 500, 3000, 2000, 1600, 1200, 1000, 800, 2000, 1500, 1200, 1000]
const SPINAL_PA_SPACE = [0, 5500, 5000, 4500, 4000, 3500, 3000, 2500, 2500, 5000, 4500, 4000, 3500, 3000, 2500, 4500, 4000, 3500, 3000]
const SPINAL_PA_EP = [0, 500, 500, 500, 600, 600, 600, 700, 700, 800, 800, 800, 900, 900, 900, 1000, 1000, 1000, 1000]

/**
 * Computes hull tonnage consumed and cost for the given configuration, armour, streamlining, and structure.
 */
export const computeHullModule = (
  tonnage: number,
  techLevel: number,
  inputs: HullInputs,
): ShipModule => {
  const configCost = (): number => {
    const size = tonnage
    switch (inputs.config) {
      case 1:
        return (size / 10) * 1.2
      case 2:
        return (size / 10) * 1.1
      case 3:
        return size / 10
      case 4:
        return (size / 10) * 0.6
      case 5:
        return (size / 10) * 0.7
      case 6:
        return (size / 10) * 0.8
      case 7:
        return (size / 10) * 0.5
      case 8:
        return size / 10000 + (size * 0.8) / 1000
      case 9:
        return size / 10000 + (size * 0.65) / 1000
      default:
        return 0
    }
  }

  const armourBase = (): number => {
    if (techLevel >= 7 && techLevel <= 9) return 0.04 + (4 * inputs.armour) / 100
    if (techLevel >= 10 && techLevel <= 11) return 0.03 + (3 * inputs.armour) / 100
    if (techLevel >= 12 && techLevel <= 13) return 0.02 + (2 * inputs.armour) / 100
    return 0.01 + inputs.armour / 100
  }

  const armourSpace = inputs.armour > 0 ? tonnage * armourBase() : 0
  const armourCost =
    inputs.armour > 0 ? armourSpace * (0.3 + inputs.armour / 10) : 0
  const planetoidSpace = inputs.config === 8 ? tonnage * 0.2 : inputs.config === 9 ? tonnage * 0.35 : 0
  const controlsSpace = inputs.airframe === 0 ? tonnage * 0.05 : 0
  const streamliningCost = inputs.streamLining === 0 ? tonnage * 0.005 : 0

  return {
    type: 'hull',
    name: 'Hull',
    techLevel,
    tonnage: round3(planetoidSpace + armourSpace + controlsSpace + inputs.structure),
    costMcr: round3(configCost() + armourCost + streamliningCost),
  }
}

/**
 * Computes engineering tonnage, cost, EP output, and M-Drive EP demand for all primary and backup drives.
 * @param race - Race profile index (1 = human standard; affects power plant tonnage tiers).
 * @param designSystem - 1 = High Guard drive-letter system; 0 = T20/General power-tons system.
 */
export const computeEngineModule = (
  tonnage: number,
  techLevel: number,
  race: number,
  designSystem: number,
  inputs: EngineInputs,
): ShipModule => {
  const minSize = designSystem === 1 ? 1 : 0
  const mDrive = inputs.mDriveIsRefitted ? inputs.newMDrive : inputs.mDrive
  const bakMDrive = inputs.bakMDriveIsRefitted ? inputs.bakNewMDrive : inputs.bakMDrive
  const bakMDriveNum = inputs.bakMDriveIsRefitted ? inputs.bakNewMDriveNum : inputs.bakMDriveNum
  const jDrive = inputs.jDriveIsRefitted ? inputs.newJDrive : inputs.jDrive
  const bakJDrive = inputs.bakJDriveIsRefitted ? inputs.bakNewJDrive : inputs.bakJDrive
  const bakJDriveNum = inputs.bakJDriveIsRefitted ? inputs.bakNewJDriveNum : inputs.bakJDriveNum
  const pPlant = inputs.pPlantIsRefitted ? inputs.newPPlant : inputs.pPlant
  const bakPPlant = inputs.bakPPlantIsRefitted ? inputs.bakNewPPlant : inputs.bakPPlant
  const powerTons = inputs.powerTonsIsRefitted ? inputs.newPowerTons : inputs.powerTons
  const bakPowerTons = inputs.bakPowerTonsIsRefitted ? inputs.bakNewPowerTons : inputs.bakPowerTons
  const pPlantTl = inputs.pPlantIsRefitted ? inputs.pPlantRefitTech : techLevel
  const bakPPlantTl = inputs.bakPPlantIsRefitted ? inputs.bakPPlantRefitTech : techLevel
  const powerTonsTl = inputs.powerTonsIsRefitted ? inputs.powerTonsRefitTech : techLevel
  const bakPowerTonsTl = inputs.bakPowerTonsIsRefitted ? inputs.bakPowerTonsRefitTech : techLevel

  const mDriveSpace =
    mDrive > 0 ? max(tonnage * (((3 * mDrive) - 1) / 100), minSize) : 0
  const bakMDriveSpace =
    bakMDrive > 0 ? max(tonnage * (((3 * bakMDrive) - 1) / 100), minSize) * Math.max(0, bakMDriveNum) : 0
  const jDriveSpace =
    jDrive > 0 ? max(tonnage * ((jDrive + 1) / 100), minSize) : 0
  const bakJDriveSpace =
    bakJDrive > 0 ? max(tonnage * ((bakJDrive + 1) / 100), minSize) * Math.max(0, bakJDriveNum) : 0

  const pPlantSpace = (): number => {
    if (designSystem === 0) return powerTons
    if (pPlant <= 0) return 0
    if (race === 1) {
      if (pPlantTl <= 10) return max(tonnage * ((pPlant * 4) / 100), minSize)
      if (pPlantTl <= 12) return max(tonnage * ((pPlant * 3) / 100), minSize)
      if (pPlantTl <= 14) return max(tonnage * ((pPlant * 2) / 100), minSize)
      return max(tonnage * (pPlant / 100), minSize)
    }
    if (pPlantTl <= 8) return max(tonnage * ((pPlant * 4) / 100), minSize)
    if (pPlantTl <= 12) return max(tonnage * ((pPlant * 3) / 100), minSize)
    if (pPlantTl <= 14) return max(tonnage * ((pPlant * 2) / 100), minSize)
    return max(tonnage * (pPlant / 100), minSize)
  }
  const bakPPlantSpace = (): number => {
    if (designSystem === 0) return bakPowerTons
    if (bakPPlant <= 0) return 0
    if (race === 1) {
      if (bakPPlantTl <= 10) return max(tonnage * ((bakPPlant * 4) / 100), minSize)
      if (bakPPlantTl <= 12) return max(tonnage * ((bakPPlant * 3) / 100), minSize)
      if (bakPPlantTl <= 14) return max(tonnage * ((bakPPlant * 2) / 100), minSize)
      return max(tonnage * (bakPPlant / 100), minSize)
    }
    if (bakPPlantTl <= 8) return max(tonnage * ((bakPPlant * 4) / 100), minSize)
    if (bakPPlantTl <= 12) return max(tonnage * ((bakPPlant * 3) / 100), minSize)
    if (bakPPlantTl <= 14) return max(tonnage * ((bakPPlant * 2) / 100), minSize)
    return max(tonnage * (bakPPlant / 100), minSize)
  }

  const mDriveCost =
    mDrive <= 0 ? 0 : mDriveSpace * (mDrive === 1 ? 1.5 : mDrive === 2 ? 0.7 : 0.5)
  const bakMDriveCost =
    bakMDrive <= 0
      ? 0
      : bakMDriveSpace * (bakMDrive === 1 ? 1.5 : bakMDrive === 2 ? 0.7 : 0.5)
  const jDriveCost =
    jDrive <= 0 ? 0 : jDriveSpace * 4 * (inputs.milStdJump ? 10 : 1)
  // Legacy EngPas applies MilStd ×10 to primary/refitted J-drive cost only; backup J-drive ×10 is commented out.
  const bakJDriveCost = bakJDrive <= 0 ? 0 : bakJDriveSpace * 4
  const pPlantCost =
    designSystem === 0
      ? powerTons * (powerTonsTl < 17 ? 3 : 1)
      : pPlantSpace() * 3
  const bakPPlantCost =
    designSystem === 0
      ? bakPowerTons * (bakPowerTonsTl < 17 ? 3 : 1)
      : bakPPlantSpace() * 3

  const epOutput =
    designSystem === 0
      ? pPlantSpaceFromPowerTons(powerTons, powerTonsTl, race)
      : pPlant * (tonnage / 100)
  const epDemand = mDriveSpace * 0.5

  return {
    type: 'engine',
    name: 'Engineering',
    techLevel,
    tonnage: round3(mDriveSpace + bakMDriveSpace + jDriveSpace + bakJDriveSpace + pPlantSpace() + bakPPlantSpace() + inputs.upgradeSpace),
    costMcr: round3(mDriveCost + bakMDriveCost + jDriveCost + bakJDriveCost + pPlantCost + bakPPlantCost),
    epOutput: round3(epOutput),
    epDemand: round3(epDemand),
  }
}

const pPlantSpaceFromPowerTons = (powerTons: number, techLevel: number, race: number): number => {
  if (race === 1) {
    if (techLevel <= 10) return (powerTons / 2) * 1
    if (techLevel <= 12) return (powerTons / 1.5) * 1
    if (techLevel <= 14) return powerTons
    if (techLevel === 15) return powerTons * 2
    if (techLevel === 16) return powerTons * 3
    return powerTons * 8
  }
  if (techLevel <= 8) return (powerTons / 2) * 1
  if (techLevel <= 12) return (powerTons / 1.5) * 1
  if (techLevel <= 14) return powerTons
  if (techLevel === 15) return powerTons * 2
  if (techLevel === 16) return powerTons * 3
  return powerTons * 8
}

/**
 * Computes fuel tankage tonnage and cost, including liquid-hydrogen tanks, scoops, and purifier.
 * @param engineInputs - Engine inputs are needed to derive power-plant size for fuel calculations.
 */
export const computeFuelModule = (
  tonnage: number,
  techLevel: number,
  race: number,
  designSystem: number,
  engineInputs: EngineInputs,
  inputs: FuelInputs,
): ShipModule => {
  const pPlant = engineInputs.pPlantIsRefitted ? engineInputs.newPPlant : engineInputs.pPlant
  const powerTons = engineInputs.powerTonsIsRefitted ? engineInputs.newPowerTons : engineInputs.powerTons
  const powerTech = engineInputs.powerTonsIsRefitted ? engineInputs.powerTonsRefitTech : techLevel
  const plantTech = engineInputs.pPlantIsRefitted ? engineInputs.pPlantRefitTech : techLevel
  const purifierTl = inputs.refitPurif ? inputs.refitPurifTech : techLevel

  const pFuelSpace = (): number => {
    if (designSystem === 0) {
      if (race === 1) {
        if (powerTech <= 10) return ((powerTons / 2) * inputs.pFuel) / 28
        if (powerTech <= 12) return ((powerTons / 1.5) * inputs.pFuel) / 28
        if (powerTech <= 16) return (powerTons * inputs.pFuel) / 28
        return (((powerTons * inputs.pFuel) / 28) / 10)
      }
      if (powerTech <= 8) return ((powerTons / 2) * inputs.pFuel) / 28
      if (powerTech <= 12) return ((powerTons / 1.5) * inputs.pFuel) / 28
      if (powerTech <= 16) return (powerTons * inputs.pFuel) / 28
      return (((powerTons * inputs.pFuel) / 28) / 10)
    }
    if (plantTech <= 0 || pPlant <= 0) return 0
    return ((tonnage * (pPlant / 100)) * inputs.pFuel) / 28
  }

  const jFuelSpace = tonnage * (inputs.jFuel / 10)
  const totalFuel = pFuelSpace() + jFuelSpace + inputs.extraFuel
  const minFuel = designSystem === 1 ? 1 : 0
  const fuelTankage = totalFuel > 0 ? max(totalFuel, minFuel) : 0
  const lhydTankage = (() => {
    const lhydPFuelSpace = (): number => {
      if (designSystem === 0) {
        if (race === 1) {
          if (powerTech <= 10) return ((powerTons / 2) * inputs.lhydPFuel) / 28
          if (powerTech <= 12) return ((powerTons / 1.5) * inputs.lhydPFuel) / 28
          if (powerTech <= 16) return (powerTons * inputs.lhydPFuel) / 28
          return (((powerTons * inputs.lhydPFuel) / 28) / 10)
        }
        if (powerTech <= 8) return ((powerTons / 2) * inputs.lhydPFuel) / 28
        if (powerTech <= 12) return ((powerTons / 1.5) * inputs.lhydPFuel) / 28
        if (powerTech <= 16) return (powerTons * inputs.lhydPFuel) / 28
        return (((powerTons * inputs.lhydPFuel) / 28) / 10)
      }
      return ((tonnage * (pPlant / 100)) * inputs.lhydPFuel) / 28
    }
    return lhydPFuelSpace() + tonnage * (inputs.lhydJFuel / 10) + inputs.lhydExtraFuel
  })()

  const purifierSpace = (): number => {
    if (inputs.purifier !== 0 || purifierTl === 7) return 0
    const purificationTankage = inputs.purifyLHyd ? fuelTankage + lhydTankage : fuelTankage
    const mult = designSystem === 0
      ? purifierTl === 8 ? 50 : purifierTl === 9 ? 45 : purifierTl === 10 ? 40 : purifierTl === 11 ? 35 : purifierTl === 12 ? 30 : purifierTl === 13 ? 25 : purifierTl === 14 ? 20 : 15
      : purifierTl === 8 ? 5 : purifierTl === 9 ? 4.5 : purifierTl === 10 ? 4 : purifierTl === 11 ? 3.5 : purifierTl === 12 ? 3 : purifierTl === 13 ? 2.5 : purifierTl === 14 ? 2 : 1.5
    const minPurifier = purifierTl === 8 ? 10 : purifierTl === 9 ? 9 : purifierTl === 10 ? 8 : purifierTl === 11 ? 7 : purifierTl === 12 ? 6 : purifierTl === 13 ? 5 : purifierTl === 14 ? 4 : 3
    return max(minPurifier, intUp((purificationTankage / 1000) * mult))
  }

  const purifierCost = (): number => {
    if (inputs.purifier !== 0 || purifierTl === 7) return 0
    if (designSystem === 0) {
      const unit = purifierTl === 8 ? 0.2 : purifierTl === 9 ? 0.19 : purifierTl === 10 ? 0.18 : purifierTl === 11 ? 0.17 : purifierTl === 12 ? 0.16 : purifierTl === 13 ? 0.15 : purifierTl === 14 ? 0.14 : 0.15
      const divisor = purifierTl === 8 ? 50 : purifierTl === 9 ? 45 : purifierTl === 10 ? 40 : purifierTl === 11 ? 35 : purifierTl === 12 ? 30 : purifierTl === 13 ? 25 : purifierTl === 14 ? 20 : 15
      return (purifierSpace() / divisor) * unit
    }
    const factor = purifierTl === 8 ? 0.004 : purifierTl === 9 ? 0.004222 : purifierTl === 10 ? 0.0045 : purifierTl === 11 ? 0.004857 : purifierTl === 12 ? 0.005333 : purifierTl === 13 ? 0.006 : purifierTl === 14 ? 0.007 : 0.01
    return purifierSpace() * factor
  }

  const scoopsCost = inputs.scoops === 0 && tonnage >= 100 ? tonnage / 1000 : 0
  const lhydFuelCost = (() => {
    if (inputs.lhydPFuel <= 0 && inputs.lhydJFuel <= 0 && inputs.lhydExtraFuel <= 0) return 0
    const lhydPFuel = ((tonnage * (pPlant / 100)) * inputs.lhydPFuel) / 28
    const lhydJFuel = tonnage * (inputs.lhydJFuel / 10)
    return (0.001 * (lhydPFuel + lhydJFuel + inputs.lhydExtraFuel)) + 0.01
  })()

  return {
    type: 'fuel',
    name: 'Fuel',
    techLevel,
    tonnage: round3(fuelTankage + purifierSpace()),
    costMcr: round3(scoopsCost + purifierCost() + lhydFuelCost),
  }
}

const isHiverLike = (race: number): boolean => race === 2 || race === 4
const compModel = (computer: number): number => {
  if (computer <= 0) return 0
  if (computer <= 3) return 1
  if (computer <= 6) return 2
  if (computer <= 8) return 3
  if (computer <= 10) return 4
  if (computer <= 12) return 5
  if (computer <= 14) return 6
  if (computer <= 16) return 7
  if (computer <= 18) return 8
  if (computer <= 20) return 9
  return 10
}
const isFib = (computer: number): boolean => [2, 5, 8, 10, 12, 14, 16, 18, 20].includes(computer)
const compCost = (idx: number, race: number): number => (isHiverLike(race) ? COMPUTER_COST[idx] * 0.5 : COMPUTER_COST[idx])
const bridgeSpace = (tonnage: number, bridge: number): number =>
  bridge === 0 ? (tonnage < 100 ? max(tonnage * 0.2, 4) : max(tonnage * 0.02, 20)) : 0
const bridgeCost = (tonnage: number, bridge: number, race: number): number => {
  if (bridge !== 0) return 0
  if (tonnage < 100) return max(tonnage * 0.2, 4) * (race === 4 ? 0.02 : 0.025)
  return tonnage * (race === 4 ? 0.004 : 0.005)
}

/**
 * Computes avionics tonnage, cost, and EP demand for computers, bridges, flight avionics, sensors, and comms.
 * @param designSystem - Determines which cost/tonnage formula branch is used (High Guard vs T20).
 */
export const computeAvionicsModule = (
  tonnage: number,
  techLevel: number,
  race: number,
  designSystem: number,
  inputs: AvionicsInputs,
): ShipModule => {
  const mainCompCost = compCost(inputs.mainComp, race)
  const bakCompCost = compCost(inputs.bakComp, race) * inputs.bakCompNum
  const flagCompCost = compCost(inputs.flagComp, race)
  const mainCompTons = COMPUTER_TONS[inputs.mainComp] ?? 0
  const bakCompTons = (COMPUTER_TONS[inputs.bakComp] ?? 0) * inputs.bakCompNum
  const flagCompTons = COMPUTER_TONS[inputs.flagComp] ?? 0
  const mainBridgeCost = bridgeCost(tonnage, inputs.bridge, race)
  const mainBridgeSpace = bridgeSpace(tonnage, inputs.bridge)
  const backupBridgeCost = bridgeCost(tonnage, inputs.bakBridge, race) * inputs.bakBridgeNum
  const backupBridgeSpace = bridgeSpace(tonnage, inputs.bakBridge) * inputs.bakBridgeNum
  const flagBridgeCostValue = inputs.flagBridge
    ? (tonnage < 100
        ? min(max(tonnage * 0.2, 4), 40) * (race === 4 ? 0.02 : 0.025)
        : min(tonnage * (race === 4 ? 0.004 : 0.005), race === 4 ? 40 : 50))
    : 0
  const flagBridgeSpaceValue = inputs.flagBridge
    ? tonnage < 100
      ? min(max(tonnage * 0.2, 4), 40)
      : min(max(tonnage * 0.02, 20), 200)
    : 0

  if (designSystem === 1) {
    const cost = mainCompCost + bakCompCost + flagCompCost + mainBridgeCost + backupBridgeCost + flagBridgeCostValue
    const space = mainCompTons + bakCompTons + flagCompTons + mainBridgeSpace + backupBridgeSpace + flagBridgeSpaceValue
    const epOutput = 0
    const epDemand = (COMPUTER_EP[inputs.mainComp] ?? 0) + (COMPUTER_EP[inputs.flagComp] ?? 0)
    return {
      type: 'avionics',
      name: 'Avionics',
      techLevel,
      tonnage: round3(space),
      costMcr: round3(cost),
      epOutput,
      epDemand: round3(epDemand),
    }
  }

  const raceFactor = isHiverLike(race) ? 0.5 : 1
  const commsMultiplier = inputs.commsType === 2 ? 5 : 1
  const primeElectronicsCost =
    ((inputs.fltAvionics * 0.9 + inputs.sensors * 0.6 + inputs.comms * 0.5 * commsMultiplier) * raceFactor)
  const backupElectronicsCost =
    (((inputs.bakFltAvionics * 0.9) * inputs.bakFltAvionicsNum)
      + ((inputs.bakSensors * 0.6) * inputs.bakSensorsNum)
      + ((inputs.bakComms * 0.5 * commsMultiplier) * inputs.bakCommsNum)) * raceFactor

  const fibMain = isFib(inputs.mainComp) ? 2 : 1
  const fibBak = isFib(inputs.bakComp) ? 2 : 1
  const primeCompModel = compModel(inputs.mainComp)
  const bakCompModel = compModel(inputs.bakComp)

  const primeCost = (primeElectronicsCost * primeCompModel) * fibMain
  const bakCost = (backupElectronicsCost * bakCompModel) * fibBak

  const r20MainCompSpace = primeCompModel * 0.1
  const r20BakCompSpace = (bakCompModel * 0.1) * inputs.bakCompNum
  const primeSpace = (r20MainCompSpace + inputs.fltAvionics * 0.4 + inputs.sensors * 0.3 + inputs.comms * 0.2) * fibMain
  const bakSpace =
    (r20BakCompSpace
      + (inputs.bakFltAvionics * 0.4) * inputs.bakFltAvionicsNum
      + (inputs.bakSensors * 0.3) * inputs.bakSensorsNum
      + (inputs.bakComms * 0.2) * inputs.bakCommsNum) * fibBak

  return {
    type: 'avionics',
    name: 'Avionics',
    techLevel,
    tonnage: round3(primeSpace + bakSpace + mainBridgeSpace + backupBridgeSpace + flagBridgeSpaceValue),
    costMcr: round3(primeCost + bakCost + mainBridgeCost + backupBridgeCost + flagBridgeCostValue),
    epOutput: 0,
    epDemand: round3((COMPUTER_EP[inputs.mainComp] ?? 0) + (COMPUTER_EP[inputs.flagComp] ?? 0)),
  }
}

/**
 * Computes tonnage, cost, and EP demand for nuclear dampers, meson screens, black globes, and capacitors.
 */
export const computeScreensModule = (
  tonnage: number,
  techLevel: number,
  inputs: ScreenInputs,
): ShipModule => {
  const nd = inputs.nucDamp
  const ms = inputs.mesScrn
  const bg = inputs.blkGlb
  const bnd = inputs.bakNucDamp
  const bms = inputs.bakMesScrn
  const bbg = inputs.bakBlkGlb

  const space =
    (NUC_DAMP_TONS[nd] ?? 0) +
    (MES_SCRN_TONS[ms] ?? 0) +
    (BLK_GLB_TONS[bg] ?? 0) +
    (NUC_DAMP_TONS[bnd] ?? 0) * inputs.bakNucDampNum +
    (MES_SCRN_TONS[bms] ?? 0) * inputs.bakMesScrnNum +
    (BLK_GLB_TONS[bbg] ?? 0) * inputs.bakBlkGlbNum +
    inputs.extraCaps

  const cost =
    (NUC_DAMP_COST[nd] ?? 0) +
    (MES_SCRN_COST[ms] ?? 0) +
    (BLK_GLB_COST[bg] ?? 0) +
    (NUC_DAMP_COST[bnd] ?? 0) * inputs.bakNucDampNum +
    (MES_SCRN_COST[bms] ?? 0) * inputs.bakMesScrnNum +
    (BLK_GLB_COST[bbg] ?? 0) * inputs.bakBlkGlbNum +
    inputs.extraCaps * 4

  const epDemand = (NUC_DAMP_EP[nd] ?? 0) + (MES_SCRN_EP[ms] ?? 0) * (tonnage / 100)

  return {
    type: 'screens',
    name: 'Screens',
    techLevel,
    tonnage: round3(space),
    costMcr: round3(cost),
    epOutput: 0,
    epDemand: round3(epDemand),
  }
}

/**
 * Computes tonnage, cost, and EP demand for the spinal mount weapon (meson gun or particle accelerator).
 */
export const computeSpinalModule = (
  techLevel: number,
  race: number,
  inputs: WeaponInputs,
): ShipModule => {
  const isRaceOne = race === 1
  const mult = isRaceOne ? 2 : 1
  const mount = inputs.spinalMount
  let cost = 0
  let tonnage = 0
  let epDemand = 0
  if (inputs.spinalType === 1) {
    cost = (SPINAL_MESON_COST[mount] ?? 0) * mult
    tonnage = (SPINAL_MESON_SPACE[mount] ?? 0) * mult
    epDemand = SPINAL_MESON_EP[mount] ?? 0
  } else if (inputs.spinalType === 2) {
    cost = (SPINAL_PA_COST[mount] ?? 0) * mult
    tonnage = (SPINAL_PA_SPACE[mount] ?? 0) * mult
    epDemand = SPINAL_PA_EP[mount] ?? 0
  }
  return {
    type: 'spinal',
    name: 'Spinal Mount',
    techLevel,
    tonnage: round3(tonnage),
    costMcr: round3(cost),
    epOutput: 0,
    epDemand: round3(epDemand),
  }
}

/**
 * Computes tonnage, cost, and EP demand for all 100-ton weapon bays.
 */
export const computeBigBaysModule = (
  techLevel: number,
  race: number,
  inputs: WeaponInputs,
): ShipModule => {
  const mult = race === 1 ? 2 : 1
  const emptyBays = inputs.bigEmptyBays
  const meson = inputs.bigMesonBays
  const pa = inputs.bigPaBays
  const rep = inputs.bigRepulsorBays
  const missile = inputs.bigMissileBays

  const tonnage = (emptyBays + meson + pa + rep + missile) * 100 * mult
  const cost = ((emptyBays * 1) + (meson * 71) + (pa * 36) + (rep * 11) + (missile * 21)) * mult
  const epDemand = meson * 200 + pa * 60 + rep * 10

  return {
    type: 'bigbays',
    name: 'Big Bays',
    techLevel,
    tonnage: round3(tonnage),
    costMcr: round3(cost),
    epOutput: 0,
    epDemand: round3(epDemand),
  }
}

/**
 * Computes tonnage, cost, and EP demand for all 50-ton weapon bays.
 */
export const computeLittleBaysModule = (
  techLevel: number,
  race: number,
  inputs: WeaponInputs,
): ShipModule => {
  const mult = race === 1 ? 2 : 1
  const emptyBays = inputs.littleEmptyBays
  const meson = inputs.littleMesonBays
  const pa = inputs.littlePaBays
  const rep = inputs.littleRepulsorBays
  const missile = inputs.littleMissileBays
  const energy = inputs.littleEnergyBays

  const tonnage = (emptyBays + meson + pa + rep + missile + energy) * 50 * mult
  const energyBayCost = race === 1 ? 11 + inputs.littleEnergyType * 6 : 5.5 + inputs.littleEnergyType * 3
  const cost =
    (emptyBays * (race === 1 ? 1 : 0.5)) +
    (meson * (race === 1 ? 101 : 50.5)) +
    (pa * (race === 1 ? 41 : 20.5)) +
    (rep * (race === 1 ? 13 : 6.5)) +
    (missile * (race === 1 ? 25 : 12.5)) +
    energy * energyBayCost
  const epDemand = meson * 100 + pa * 30 + rep * 5 + energy * (10 + inputs.littleEnergyType * 10)

  return {
    type: 'littlebays',
    name: 'Little Bays',
    techLevel,
    tonnage: round3(tonnage),
    costMcr: round3(cost),
    epOutput: 0,
    epDemand: round3(epDemand),
  }
}

/**
 * Computes tonnage, cost, and EP demand for all turret weapons (mixed and standard modes).
 * @param chargeHardpoints - When false, hardpoint (mount) costs are omitted; matches legacy option `ChargeForHardpoints`.
 */
export const computeTurretsModule = (
  techLevel: number,
  race: number,
  inputs: WeaponInputs,
  chargeHardpoints = true,
): ShipModule => {
  const hpCostByStyle = (style: number): number => (style === 0 ? 0.1 : style === 1 ? 0.3 : style === 2 ? 0.6 : 1.1)
  const raceMult = race === 1 ? 2 : 1
  const mixBatteries = (weaponStyle: number): number =>
    Math.max(0, inputs.numMixTurrets - inputs.emptyMixTurrets) * weaponStyle

  const emptyTurretCost = (): number => {
    if (!chargeHardpoints) return 0
    return hpCostByStyle(inputs.emptyTurretStyle) * inputs.emptyTurrets * raceMult
  }
  const emptyTurretSpace = (): number => inputs.emptyTurrets * 1 * raceMult

  const missileTurretCost = (): number => {
    const hp = hpCostByStyle(inputs.missileTurretStyle) * inputs.missileTurrets * raceMult
    const wpn = inputs.missileTurrets * inputs.missileTurretStyle * 0.75 * raceMult
    return (chargeHardpoints ? hp : 0) + wpn
  }
  const missileTurretSpace = (): number => inputs.missileTurrets * 1 * raceMult

  const laserTurretCost = (): number => {
    const hp = hpCostByStyle(inputs.laserTurretStyle) * inputs.laserTurrets * raceMult
    const laserUnit = inputs.laserType === 0 ? 1 : 0.5
    const wpn = inputs.laserTurrets * inputs.laserTurretStyle * laserUnit * raceMult
    return (chargeHardpoints ? hp : 0) + wpn
  }
  const laserTurretSpace = (): number => inputs.laserTurrets * 1 * raceMult

  const energyTurretCost = (): number => {
    const hp = (inputs.energyTurretStyle === 0 ? 0.1 : inputs.energyTurretStyle === 1 ? 0.6 : 1.1) * inputs.energyTurrets * raceMult
    const unit = inputs.energyType === 0 ? 1.5 : 2
    const wpn = inputs.energyTurrets * inputs.energyTurretStyle * unit * raceMult
    return (chargeHardpoints ? hp : 0) + wpn
  }
  const energyTurretSpace = (): number => inputs.energyTurrets * 2 * raceMult

  const sandTurretCost = (): number => {
    const hp = hpCostByStyle(inputs.sandTurretStyle) * inputs.sandTurrets * raceMult
    const wpn = inputs.sandTurrets * inputs.sandTurretStyle * 0.25 * raceMult
    return (chargeHardpoints ? hp : 0) + wpn
  }
  const sandTurretSpace = (): number => inputs.sandTurrets * 1 * raceMult

  const paTurretCost = (): number => {
    const hpUnit = inputs.paTurretStyle === 0 ? 0.1 : techLevel < 15 ? 1.6 : 1.1
    const hp = hpUnit * inputs.paTurrets * raceMult
    const unit = techLevel < 15 ? 4 : 3
    const wpn = inputs.paTurrets * inputs.paTurretStyle * unit * raceMult
    return (chargeHardpoints ? hp : 0) + wpn
  }
  const paTurretSpace = (): number => inputs.paTurrets * (techLevel < 15 ? 5 : 3) * raceMult

  const mixedTurretCost = (): number => {
    const hp = hpCostByStyle(inputs.mixTurretStyle) * inputs.numMixTurrets * raceMult
    let price = 0
    price += mixBatteries(inputs.mixTurretMissiles) * 0.75
    price += mixBatteries(inputs.mixTurretLasers) * (inputs.laserType === 0 ? 1 : 0.5)
    price += mixBatteries(inputs.mixTurretEnergy) * (inputs.energyType === 0 ? 1.5 : 2)
    price += mixBatteries(inputs.mixTurretSand) * 0.25
    const wpn = price * raceMult
    return (chargeHardpoints ? hp : 0) + wpn
  }
  const mixedTurretSpace = (): number => (inputs.mixTurretEnergy > 0 ? inputs.numMixTurrets * 2 : inputs.numMixTurrets) * raceMult

  const cost =
    inputs.mixedTurrets === 0
      ? mixedTurretCost()
      : emptyTurretCost() +
        missileTurretCost() +
        laserTurretCost() +
        energyTurretCost() +
        sandTurretCost() +
        paTurretCost()
  const tonnage =
    inputs.mixedTurrets === 0
      ? mixedTurretSpace()
      : emptyTurretSpace() +
        missileTurretSpace() +
        laserTurretSpace() +
        energyTurretSpace() +
        sandTurretSpace() +
        paTurretSpace()
  const epDemand =
    inputs.mixedTurrets === 0
      ? mixBatteries(inputs.mixTurretLasers) * 1 + mixBatteries(inputs.mixTurretEnergy) * (1 + inputs.energyType)
      : inputs.laserTurrets * inputs.laserTurretStyle * 1 +
        inputs.energyTurrets * inputs.energyTurretStyle * (inputs.energyType === 0 ? 1 : 2) +
        inputs.paTurrets * inputs.paTurretStyle * 5

  return {
    type: 'turrets',
    name: 'Turrets',
    techLevel,
    tonnage: round3(tonnage),
    costMcr: round3(cost),
    epOutput: 0,
    epDemand: round3(epDemand),
  }
}

/**
 * Computes accommodations tonnage and cost for quarters, low berths, drop capsules, passengers, and facilities.
 * @param crewRules - 0 = Book 2 rules; 1 = High Guard crew rules; affects stateroom space/cost.
 */
export const computeAccomModule = (
  techLevel: number,
  race: number,
  crewRules: number,
  inputs: AccomInputs,
): ShipModule => {
  const stRoomCost = (): number => {
    if (race === 0 || race === 2 || race === 4) return inputs.stRoom * 0.5
    if (race === 1) return inputs.stRoom * (crewRules === 0 ? 1 : 0.5)
    return inputs.stRoom * 0.25
  }
  const stRoomSpace = (): number => {
    if (race === 0 || race === 2 || race === 4) return inputs.stRoom * 4
    if (race === 1) return inputs.stRoom * 48
    return inputs.stRoom * 2
  }
  const smStRoomCost = (): number => {
    if (race === 0 || race === 2 || race === 4) return inputs.smStRoom * 0.05
    if (race === 1) return inputs.smStRoom * (crewRules === 0 ? 0.1 : 0.05)
    return inputs.smStRoom * 0.025
  }
  const smStRoomSpace = (): number => {
    if (race === 0 || race === 2 || race === 4) return inputs.smStRoom * 2
    if (race === 1) return inputs.smStRoom * 24
    return inputs.smStRoom * 1
  }
  const couchesCost = inputs.couches * 0.025
  const couchesSpace = race === 1 ? inputs.couches * 6 : inputs.couches * 0.5
  const lowBerthCost = (race === 1 ? 0.1 : race === 2 || race === 4 ? 0.5 : 0.05) * inputs.lowBerth
  const lowBerthSpace = (race === 1 ? 1 : 0.5) * inputs.lowBerth
  const emLowBerthCost = (race === 1 ? 0.2 : race === 2 || race === 4 ? 1 : 0.1) * inputs.emLowBerth
  const emLowBerthSpace = (race === 1 ? 2 : 1) * inputs.emLowBerth
  const dropCapsCost = inputs.dropCaps * 0.01
  const dropCapsSpace = inputs.dropCaps * 1
  const readyDropCapsCost = inputs.readyDropCaps * 0.001
  const readyDropCapsSpace = inputs.readyDropCaps * 0.5
  const storedDropCapsSpace = inputs.storedDropCaps * 0.5
  const otherCost =
    inputs.engShop * 1 +
    inputs.vehicleShop * 2 +
    inputs.labs * 5 +
    inputs.sickBay * 5 +
    inputs.autoDoc * 10 +
    inputs.airlock * 0.005 +
    inputs.fresher * 0.002 +
    inputs.missileMag * 0.1
  const otherSpace =
    inputs.engShop * 6 +
    inputs.vehicleShop * 10 +
    inputs.labs * 8 +
    inputs.sickBay * 8 +
    inputs.autoDoc * 2 +
    inputs.airlock * 3 +
    inputs.fresher * 0.5 +
    inputs.missileMag * 1

  return {
    type: 'accom',
    name: 'Accommodations',
    techLevel,
    tonnage: round3(
      stRoomSpace() +
        smStRoomSpace() +
        couchesSpace +
        lowBerthSpace +
        emLowBerthSpace +
        dropCapsSpace +
        readyDropCapsSpace +
        storedDropCapsSpace +
        inputs.cargo +
        otherSpace,
    ),
    costMcr: round3(
      stRoomCost() +
        smStRoomCost() +
        couchesCost +
        lowBerthCost +
        emLowBerthCost +
        dropCapsCost +
        readyDropCapsCost +
        otherCost,
    ),
    epOutput: 0,
    epDemand: 0,
  }
}

/**
 * Computes aggregate tonnage, cost, and EP demand for all user-defined component rows.
 */
export const computeUserDefModule = (
  techLevel: number,
  inputs: UserDefInputs,
): ShipModule => {
  const tonnage = inputs.items.reduce((sum, item) => sum + item.num * item.size, 0)
  const cost = inputs.items.reduce((sum, item) => sum + item.num * item.cost, 0)
  const epDemand = inputs.items.reduce((sum, item) => sum + item.num * item.ep, 0)
  return {
    type: 'userdef',
    name: 'User Defined',
    techLevel,
    tonnage: round3(tonnage),
    costMcr: round3(cost),
    epOutput: 0,
    epDemand: round3(epDemand),
  }
}

/**
 * Computes tonnage and cost for carried small craft, vehicles, and launch catapult facilities.
 * @param hullConfig - Hull configuration code; planetoid hulls (7) skip the large-ship space overhead.
 */
export const computeCraftModule = (
  techLevel: number,
  shipTonnage: number,
  hullConfig: number,
  inputs: CraftInputs,
): ShipModule => {
  const isVehicle = (v: number): boolean => v === 1
  const craftSpace = (num: number, size: number, vehicle: boolean): number => {
    if (shipTonnage <= 1000 || hullConfig === 7 || vehicle) return num * size
    return size < 100 ? num * size * 1.3 : num * size * 1.1
  }
  const craftCost = (num: number, size: number, vehicle: boolean): number =>
    vehicle ? 0 : craftSpace(num, size, vehicle) * 0.002
  const launcherSpace = (num: number, size: number): number => num * (size * 25)
  const launcherCost = (num: number, size: number): number => launcherSpace(num, size) * 0.002

  const bodySpace = inputs.items.reduce(
    (sum, item) => sum + craftSpace(item.num, item.tonnage, isVehicle(item.vehicle)),
    0,
  )
  const bodyCost = inputs.items.reduce(
    (sum, item) => sum + craftCost(item.num, item.tonnage, isVehicle(item.vehicle)),
    0,
  )
  const lSpace = launcherSpace(inputs.lf1Num, inputs.lf1Size) + launcherSpace(inputs.lf2Num, inputs.lf2Size)
  const lCost = launcherCost(inputs.lf1Num, inputs.lf1Size) + launcherCost(inputs.lf2Num, inputs.lf2Size)

  return {
    type: 'craft',
    name: 'Craft Facilities',
    techLevel,
    tonnage: round3(bodySpace + lSpace),
    costMcr: round3(bodyCost + lCost),
    epOutput: 0,
    epDemand: 0,
  }
}

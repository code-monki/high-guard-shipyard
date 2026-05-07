/* types.ts — Shared TypeScript interfaces and type aliases for all ship-design data structures. */

export type DesignModuleType =
  | 'hull'
  | 'engine'
  | 'fuel'
  | 'avionics'
  | 'screens'
  | 'spinal'
  | 'bigbays'
  | 'littlebays'
  | 'turrets'
  | 'accom'
  | 'userdef'
  | 'craft'

/** Computed result for a single design module (hull, engine, fuel, etc.). */
export interface ShipModule {
  type: DesignModuleType
  name: string
  techLevel: number
  tonnage: number
  costMcr: number
  /** Energy Points produced by this module (power plant only). */
  epOutput?: number
  /** Energy Points consumed by this module. */
  epDemand?: number
}

/** Top-level ship design parameters (identity, tonnage, budget, TL, race). */
export interface ShipDesign {
  shipName: string
  shipClass: string
  hullCode: string
  tonnage: number
  budgetMcr: number
  techLevel: number
  race: number
  designSystem: number
  isRefitted: boolean
  refitTechLevel: number
  refitBudgetMcr: number
  notes: string
  avionics: ShipModule
}

/** User inputs for the hull configuration panel. */
export interface HullInputs {
  config: number
  armour: number
  streamLining: number
  airframe: number
  structure: number
}

/** Matches legacy `GenOptionsDetails` row (minus MilStd jump, which lives on `EngineInputs`). */
export interface LegacyOptionsInputs {
  /** Legacy default is off (`ChargeForHardpoints := 0` in OptionsPas). */
  chargeForHardpoints: boolean
  /** When true, staterooms/couches/low-berths are automatically set to minimum required values. */
  autoCalcAccom: boolean
  optPowerTon: boolean
  /** Stored MilStd cost multiplier override (non-standard; loaded from .hgs opt row). */
  milStdMod: number
}

/** User inputs for drive and power plant configuration, including backup drives and refit state. */
export interface EngineInputs {
  mDrive: number
  mDriveIsRefitted: boolean
  newMDrive: number
  bakMDrive: number
  bakMDriveIsRefitted: boolean
  bakNewMDrive: number
  bakMDriveNum: number
  bakNewMDriveNum: number
  jDrive: number
  jDriveIsRefitted: boolean
  newJDrive: number
  bakJDrive: number
  bakJDriveIsRefitted: boolean
  bakNewJDrive: number
  bakJDriveNum: number
  bakNewJDriveNum: number
  pPlant: number
  pPlantIsRefitted: boolean
  newPPlant: number
  pPlantRefitTech: number
  bakPPlant: number
  bakPPlantIsRefitted: boolean
  bakNewPPlant: number
  bakPPlantRefitTech: number
  bakPPlantNum: number
  bakNewPPlantNum: number
  /** T20/General design system power plant size in tons (replaces pPlant factor when designSystem === 0). */
  powerTons: number
  powerTonsIsRefitted: boolean
  newPowerTons: number
  powerTonsRefitTech: number
  bakPowerTons: number
  bakPowerTonsNum: number
  bakPowerTonsIsRefitted: boolean
  bakNewPowerTons: number
  bakNewPowerTonsNum: number
  bakPowerTonsRefitTech: number
  /** Reserved tonnage set aside for future drive upgrades. */
  upgradeSpace: number
  /** When true, all drives share a single engineering space total rather than separate compartments. */
  singleEngSpace: boolean
  /** Permits drive letter upgrades during refit (legacy flag from EngPas). */
  driveUpgradesAllowed: boolean
  milStdJump: boolean
}

/** User inputs for fuel tankage, scoops, and purification. */
export interface FuelInputs {
  pFuel: number
  lhydPFuel: number
  lhydJFuel: number
  jFuel: number
  extraFuel: number
  lhydExtraFuel: number
  scoops: number
  purifier: number
  purifyLHyd: boolean
  refitPurif: boolean
  refitPurifTech: number
  basePFuel: number
  baseJFuel: number
  baseEFuel: number
}

/** User inputs for computers, bridges, flight avionics, sensors, and comms. */
export interface AvionicsInputs {
  mainComp: number
  bakComp: number
  bakCompNum: number
  bridge: number
  bakBridge: number
  bakBridgeNum: number
  flagBridge: boolean
  flagComp: number
  fltAvionics: number
  bakFltAvionics: number
  bakFltAvionicsNum: number
  sensors: number
  bakSensors: number
  bakSensorsNum: number
  comms: number
  bakComms: number
  bakCommsNum: number
  commsType: number
}

/** A single rule violation produced by `validateDesign`. */
export interface ValidationIssue {
  code: number
  message: string
}

/** User inputs for all weapon systems: spinal mount, bays, and turrets. */
export interface WeaponInputs {
  spinalType: number
  spinalMount: number
  bigEmptyBays: number
  bigMesonBays: number
  bigPaBays: number
  bigRepulsorBays: number
  bigMissileBays: number
  littleEmptyBays: number
  littleMesonBays: number
  littlePaBays: number
  littleRepulsorBays: number
  littleMissileBays: number
  littleEnergyBays: number
  littleEnergyType: number
  paTurrets: number
  missileTurrets: number
  sandTurretBatteries: number
  laserTurretBatteries: number
  energyTurretBatteries: number
  paTurretBatteries: number
  missileTurretBatteries: number
  emptyTurretStyle: number
  missileTurretStyle: number
  laserTurretStyle: number
  energyTurretStyle: number
  sandTurretStyle: number
  paTurretStyle: number
  mixTurretStyle: number
  mixTurretMissiles: number
  mixTurretLasers: number
  mixTurretEnergy: number
  mixTurretSand: number
  emptyMixTurrets: number
  laserType: number
  energyType: number
  mixedTurrets: number
  numMixTurrets: number
  emptyTurrets: number
  laserTurrets: number
  energyTurrets: number
  sandTurrets: number
}

/** User inputs for nuclear dampers, meson screens, black globes, and extra capacitors. */
export interface ScreenInputs {
  nucDamp: number
  mesScrn: number
  blkGlb: number
  bakNucDamp: number
  bakMesScrn: number
  bakBlkGlb: number
  bakNucDampNum: number
  bakMesScrnNum: number
  bakBlkGlbNum: number
  extraCaps: number
}

/** User inputs for all accommodation, crew, passenger, and facility fields. */
export interface AccomInputs {
  lowBerth: number
  emLowBerth: number
  dropCaps: number
  readyDropCaps: number
  storedDropCaps: number
  stRoom: number
  couches: number
  smStRoom: number
  dblOccMark: number
  highPass: number
  midPass: number
  lowPass: number
  cargo: number
  shpTrpMark: number
  bk2Captain: boolean
  frozWatch: number
  alternateCrewRules: number
  crewRules: number
  flagship: boolean
  engCmdCrew: number
  avionicsCmdCrew: number
  spinalCmdCrew: number
  bigBaysCmdCrew: number
  littleBaysCmdCrew: number
  turretsCmdCrew: number
  screensCmdCrew: number
  craftCmdCrew: number
  accomCmdCrew: number
  userDefCmdCrew: number
  marines: number
  engCrew: number
  avionicsCrew: number
  spinalCrew: number
  bigBaysCrew: number
  littleBaysCrew: number
  turretsCrew: number
  screensCrew: number
  craftCrew: number
  accomCrew: number
  shipsTroops: number
  otherCrew: number
  userDefCrew: number
  engShop: number
  vehicleShop: number
  labs: number
  sickBay: number
  autoDoc: number
  airlock: number
  fresher: number
  missileMag: number
  numCrewSections: number
}

/** A single user-defined component row with tonnage, crew, EP, cost, and hardpoint requirements. */
export interface UserDefItem {
  num: number
  size: number
  crew: number
  ep: number
  cost: number
  hp: number
  desc: string
}

/** User inputs for the user-defined components panel (up to 8 rows). */
export interface UserDefInputs {
  items: UserDefItem[]
}

/** A single small craft or vehicle carried aboard the ship. */
export interface CraftItem {
  num: number
  tonnage: number
  crew: number
  vehicle: number
  price: number
  desc: string
}

/** User inputs for the small craft facilities panel: craft items and launch catapults. */
export interface CraftInputs {
  items: CraftItem[]
  ftrSqd: number
  lf1Num: number
  lf1Size: number
  lf2Num: number
  lf2Size: number
}

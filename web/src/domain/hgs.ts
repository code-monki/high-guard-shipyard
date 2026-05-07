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
  UserDefInputs,
  WeaponInputs,
} from '../types'

const MIN_HGS_LINES = 16

const DEFAULT_HGS_TEMPLATE_LINES: string[] = [
  '20000',
  '"Fatima al-Fihri","Kuniko Inoguchi","Ketch","Andrea Vallance","AK",9,100.0000,39.0000,0,0,1,0,8,0.0000,0,0,0,0,0,0,0',
  '6,0,1,1,0.0000,0,0',
  '1,1,1,0,0,0,0,0,0,3.0000,0.0000,0,0,1,8,0,1,8,0,1,8,0,0,8,0,0,8,0,0,8,0,0,0,0,1.000,8,0,0.000,8,0,0.000,0,0,0,0,0,0,0,0,0',
  '28,2,0,0,0,0,0.0000,0.0000,0,0,0,0,0,0.0000,0,0',
  '4,0,0,0,1,0,2,0,0,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0',
  '0,0,0.0000,0,0,0,0,0,0,0,0,0,0,0,0,0,0',
  '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0',
  '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0',
  '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-42,0,0,0,0,0,0,0,0',
  '0,0,0,0,0,0,0,0,0,0.0000',
  '0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0,0.0000,0,0.0000,0,0,0',
  '1,1,0,0,0,1.0,0.0,0,0,0,0.0000,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0000,0,0',
  '0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0,0',
  '0,0,0,0,0.0000,0,0,0,0',
  'Reserved for future expansion',
  'Reserved for future expansion',
  'Reserved for future expansion',
]

const parseCsvLine = (line: string): string[] => {
  const out: string[] = []
  let current = ''
  let inQuotes = false
  for (let i = 0; i < line.length; i += 1) {
    const ch = line[i]
    if (ch === '"') {
      if (inQuotes && line[i + 1] === '"') {
        current += '"'
        i += 1
      } else {
        inQuotes = !inQuotes
      }
    } else if (ch === ',' && !inQuotes) {
      out.push(current)
      current = ''
    } else {
      current += ch
    }
  }
  out.push(current)
  return out
}

const csvEscape = (value: string): string => {
  if (/[",\n]/.test(value)) return `"${value.replace(/"/g, '""')}"`
  return value
}

const writeCsvLinePreserving = (originalLine: string | undefined, tokens: string[]): string => {
  if (!originalLine) return tokens.map(csvEscape).join(',')
  const originalTokens = parseCsvLine(originalLine)
  if (originalTokens.length === tokens.length && originalTokens.every((token, i) => token === tokens[i])) {
    return originalLine
  }
  return tokens.map(csvEscape).join(',')
}

const withLen = (arr: string[], len: number): string[] => {
  const next = [...arr]
  while (next.length < len) next.push('0')
  return next
}

export interface ParsedHgs {
  rawLines: string[]
  design: ShipDesign
  hull: HullInputs
  engine: EngineInputs
  fuel: FuelInputs
  avionics: AvionicsInputs
  weapons: WeaponInputs
  screens: ScreenInputs
  accom: AccomInputs
  userDef: UserDefInputs
  craft: CraftInputs
  /** Present after `parseHgsText`; optional so callers may omit when constructing `ParsedHgs` by hand. */
  legacyOptions?: LegacyOptionsInputs
}

export const defaultLegacyOptionsInputs = (): LegacyOptionsInputs => ({
  chargeForHardpoints: false,
  autoCalcAccom: false,
  optPowerTon: false,
  milStdMod: 0,
})

export const parseHgsText = (text: string): ParsedHgs => {
  const lines = text.replace(/\r\n/g, '\n').split('\n').filter((l) => l.length > 0)
  if (lines.length < MIN_HGS_LINES) throw new Error('Invalid .hgs: too few lines')

  const ship = withLen(parseCsvLine(lines[1]), 16)
  const optTok = withLen(parseCsvLine(lines[14] ?? ''), 9)
  const hull = withLen(parseCsvLine(lines[2]), 5)
  const engine = withLen(parseCsvLine(lines[3]), 43)
  const fuel = withLen(parseCsvLine(lines[4]), 14)
  const avionics = withLen(parseCsvLine(lines[5]), 56)
  const spinal = withLen(parseCsvLine(lines[6]), 7)
  const bigBays = withLen(parseCsvLine(lines[7]), 19)
  const littleBays = withLen(parseCsvLine(lines[8]), 25)
  const turrets = withLen(parseCsvLine(lines[9]), 28)
  const screens = withLen(parseCsvLine(lines[10]), 10)
  const craft = withLen(parseCsvLine(lines[11]), 53)
  const accom = withLen(parseCsvLine(lines[12]), 27)
  const userDef = withLen(parseCsvLine(lines[13]), 77)

  const design: ShipDesign = {
    shipName: ship[0] ?? '',
    shipClass: ship[1] ?? '',
    hullCode: ship[4] ?? '',
    tonnage: Number(ship[6] ?? 0),
    budgetMcr: Number(ship[7] ?? 0),
    techLevel: Number(ship[5] ?? 0),
    race: Number(ship[8] ?? 0),
    designSystem: Number(ship[10] ?? 1),
    isRefitted: ship[11] === '1',
    refitTechLevel: Number(ship[12] ?? 0),
    refitBudgetMcr: Number(ship[13] ?? 0),
    notes: lines.slice(15).filter((line) => !/^Reserved for future expansion$/i.test(line)).join('\n'),
    avionics: { type: 'avionics', name: 'Avionics', techLevel: Number(ship[5] ?? 0), tonnage: 0, costMcr: 0 },
  }

  return {
    rawLines: lines,
    design,
    hull: {
      config: Number(hull[0] ?? 0),
      armour: Number(hull[1] ?? 0),
      streamLining: Number(hull[2] ?? 0),
      airframe: Number(hull[3] ?? 0),
      structure: Number(hull[4] ?? 0),
    },
    engine: {
      mDrive: Number(engine[0] ?? 0),
      jDrive: Number(engine[1] ?? 0),
      pPlant: Number(engine[2] ?? 0),
      bakMDrive: Number(engine[3] ?? 0),
      bakJDrive: Number(engine[4] ?? 0),
      bakPPlant: Number(engine[5] ?? 0),
      bakMDriveNum: Number(engine[6] ?? 1),
      bakJDriveNum: Number(engine[7] ?? 1),
      bakPPlantNum: Number(engine[8] ?? 1),
      powerTons: Number(engine[9] ?? 0),
      bakPowerTons: Number(engine[10] ?? 0),
      bakPowerTonsNum: Number(engine[11] ?? 1),
      mDriveIsRefitted: engine[12] === '1',
      newMDrive: Number(engine[13] ?? 0),
      jDriveIsRefitted: engine[15] === '1',
      newJDrive: Number(engine[16] ?? 0),
      pPlantIsRefitted: engine[18] === '1',
      newPPlant: Number(engine[19] ?? 0),
      pPlantRefitTech: Number(engine[20] ?? 0),
      bakMDriveIsRefitted: engine[21] === '1',
      bakNewMDrive: Number(engine[22] ?? 0),
      bakJDriveIsRefitted: engine[24] === '1',
      bakNewJDrive: Number(engine[25] ?? 0),
      bakPPlantIsRefitted: engine[27] === '1',
      bakNewPPlant: Number(engine[28] ?? 0),
      bakPPlantRefitTech: Number(engine[29] ?? 0),
      bakNewMDriveNum: Number(engine[30] ?? 1),
      bakNewJDriveNum: Number(engine[31] ?? 1),
      bakNewPPlantNum: Number(engine[32] ?? 1),
      powerTonsIsRefitted: engine[33] === '1',
      newPowerTons: Number(engine[34] ?? 0),
      powerTonsRefitTech: Number(engine[35] ?? 0),
      bakPowerTonsIsRefitted: engine[36] === '1',
      bakNewPowerTons: Number(engine[37] ?? 0),
      bakPowerTonsRefitTech: Number(engine[38] ?? 0),
      bakNewPowerTonsNum: Number(engine[39] ?? 1),
      upgradeSpace: Number(engine[40] ?? 0),
      singleEngSpace: engine[41] === '1',
      driveUpgradesAllowed: engine[42] === '1',
      milStdJump: optTok[3] === '1',
    },
    fuel: {
      pFuel: Number(fuel[0] ?? 0),
      jFuel: Number(fuel[1] ?? 0),
      scoops: Number(fuel[2] ?? 0),
      purifier: Number(fuel[3] ?? 0),
      lhydPFuel: Number(fuel[4] ?? 0),
      lhydJFuel: Number(fuel[5] ?? 0),
      extraFuel: Number(fuel[6] ?? 0),
      lhydExtraFuel: Number(fuel[7] ?? 0),
      purifyLHyd: fuel[8] === '1',
      refitPurif: fuel[9] === '1',
      refitPurifTech: Number(fuel[10] ?? 0),
      basePFuel: Number(fuel[11] ?? 0),
      baseJFuel: Number(fuel[12] ?? 0),
      baseEFuel: Number(fuel[13] ?? 0),
    },
    avionics: {
      mainComp: Number(avionics[0] ?? 0),
      bakComp: Number(avionics[1] ?? 0),
      bakCompNum: Number(avionics[2] ?? 0),
      bridge: Number(avionics[3] ?? 0),
      bakBridge: Number(avionics[4] ?? 0),
      bakBridgeNum: Number(avionics[5] ?? 0),
      fltAvionics: Number(avionics[6] ?? 0),
      bakFltAvionics: Number(avionics[7] ?? 0),
      bakFltAvionicsNum: Number(avionics[8] ?? 0),
      sensors: Number(avionics[9] ?? 0),
      bakSensors: Number(avionics[10] ?? 0),
      bakSensorsNum: Number(avionics[11] ?? 0),
      comms: Number(avionics[12] ?? 0),
      bakComms: Number(avionics[13] ?? 0),
      bakCommsNum: Number(avionics[14] ?? 0),
      commsType: Number(avionics[15] ?? 0),
      flagBridge: avionics[16] === '1',
      flagComp: Number(avionics[17] ?? 0),
    },
    weapons: {
      spinalType: Number(spinal[0] ?? 0),
      spinalMount: Number(spinal[1] ?? 0),
      bigEmptyBays: Number(bigBays[0] ?? 0),
      bigMesonBays: Number(bigBays[1] ?? 0),
      bigPaBays: Number(bigBays[2] ?? 0),
      bigRepulsorBays: Number(bigBays[3] ?? 0),
      bigMissileBays: Number(bigBays[4] ?? 0),
      littleEmptyBays: Number(littleBays[0] ?? 0),
      littleMesonBays: Number(littleBays[1] ?? 0),
      littlePaBays: Number(littleBays[2] ?? 0),
      littleRepulsorBays: Number(littleBays[3] ?? 0),
      littleMissileBays: Number(littleBays[4] ?? 0),
      littleEnergyBays: Number(littleBays[5] ?? 0),
      littleEnergyType: Number(littleBays[6] ?? 0),
      emptyTurrets: Number(turrets[0] ?? 0),
      emptyTurretStyle: Number(turrets[1] ?? 0),
      missileTurrets: Number(turrets[2] ?? 0),
      missileTurretStyle: Number(turrets[3] ?? 0),
      missileTurretBatteries: Number(turrets[4] ?? 0),
      laserTurrets: Number(turrets[5] ?? 0),
      laserTurretStyle: Number(turrets[6] ?? 0),
      laserTurretBatteries: Number(turrets[7] ?? 0),
      laserType: Number(turrets[8] ?? 0),
      energyTurrets: Number(turrets[9] ?? 0),
      energyTurretStyle: Number(turrets[10] ?? 0),
      energyTurretBatteries: Number(turrets[11] ?? 0),
      energyType: Number(turrets[12] ?? 0),
      sandTurrets: Number(turrets[13] ?? 0),
      sandTurretStyle: Number(turrets[14] ?? 0),
      sandTurretBatteries: Number(turrets[15] ?? 0),
      paTurrets: Number(turrets[16] ?? 0),
      paTurretStyle: Number(turrets[17] ?? 0),
      paTurretBatteries: Number(turrets[18] ?? 0),
      mixedTurrets: Number(turrets[19] ?? 1),
      numMixTurrets: Number(turrets[20] ?? 0),
      emptyMixTurrets: Number(turrets[21] ?? 0),
      mixTurretStyle: Number(turrets[22] ?? 0),
      mixTurretMissiles: Number(turrets[23] ?? 0),
      mixTurretLasers: Number(turrets[24] ?? 0),
      mixTurretSand: Number(turrets[26] ?? 0),
      mixTurretEnergy: Number(turrets[27] ?? 0),
    },
    screens: {
      nucDamp: Number(screens[0] ?? 0),
      mesScrn: Number(screens[1] ?? 0),
      blkGlb: Number(screens[2] ?? 0),
      bakNucDamp: Number(screens[3] ?? 0),
      bakMesScrn: Number(screens[4] ?? 0),
      bakBlkGlb: Number(screens[5] ?? 0),
      bakNucDampNum: Number(screens[6] ?? 0),
      bakMesScrnNum: Number(screens[7] ?? 0),
      bakBlkGlbNum: Number(screens[8] ?? 0),
      extraCaps: Number(screens[9] ?? 0),
    },
    craft: {
      items: Array.from({ length: 8 }, (_, i) => {
        const o = i * 6
        return {
          num: Number(craft[o] ?? 0),
          tonnage: Number(craft[o + 1] ?? 0),
          desc: craft[o + 2] ?? '',
          crew: Number(craft[o + 3] ?? 0),
          vehicle: Number(craft[o + 4] ?? 0),
          price: Number(craft[o + 5] ?? 0),
        }
      }),
      ftrSqd: Number(craft[48] ?? 0),
      lf1Num: Number(craft[49] ?? 0),
      lf1Size: Number(craft[50] ?? 0),
      lf2Num: Number(craft[51] ?? 0),
      lf2Size: Number(craft[52] ?? 0),
    },
    accom: {
      dblOccMark: Number(accom[0] ?? 0),
      shpTrpMark: Number(accom[1] ?? 1),
      highPass: Number(accom[2] ?? 0),
      midPass: Number(accom[3] ?? 0),
      lowPass: Number(accom[4] ?? 0),
      stRoom: Number(accom[5] ?? 0),
      smStRoom: Number(accom[6] ?? 0),
      couches: Number(accom[7] ?? 0),
      lowBerth: Number(accom[8] ?? 0),
      emLowBerth: Number(accom[9] ?? 0),
      cargo: Number(accom[10] ?? 0),
      marines: Number(accom[12] ?? 0),
      otherCrew: Number(accom[13] ?? 0),
      dropCaps: Number(accom[14] ?? 0),
      readyDropCaps: Number(accom[15] ?? 0),
      storedDropCaps: Number(accom[16] ?? 0),
      frozWatch: Number(accom[17] ?? 0),
      engShop: Number(accom[18] ?? 0),
      vehicleShop: Number(accom[19] ?? 0),
      labs: Number(accom[20] ?? 0),
      sickBay: Number(accom[21] ?? 0),
      autoDoc: Number(accom[22] ?? 0),
      airlock: Number(accom[23] ?? 0),
      fresher: Number(accom[24] ?? 0),
      missileMag: Number(accom[25] ?? 0),
      bk2Captain: accom[26] === '1',
      alternateCrewRules: Number(ship[14] ?? 0),
      crewRules: Number(ship[9] ?? 1),
      flagship: ship[15] === '1',
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
      userDefCrew: 0,
      numCrewSections: 1,
    },
    userDef: {
      items: Array.from({ length: 8 }, (_, i) => {
        const o = i * 10
        return {
          num: Number(userDef[o] ?? 0),
          size: Number(userDef[o + 1] ?? 0),
          desc: userDef[o + 2] ?? '',
          crew: Number(userDef[o + 3] ?? 0),
          ep: Number(userDef[o + 4] ?? 0),
          cost: Number(userDef[o + 5] ?? 0),
          hp: Number(userDef[o + 6] ?? 0),
        }
      }),
    },
    legacyOptions: {
      chargeForHardpoints: optTok[0] === '1',
      autoCalcAccom: optTok[1] === '1',
      optPowerTon: optTok[2] === '1',
      milStdMod: Number(optTok[4] ?? 0),
    },
  }
}

export const serializeHgsText = (parsed: ParsedHgs): string => {
  const lines = [...DEFAULT_HGS_TEMPLATE_LINES]
  for (let i = 0; i < parsed.rawLines.length; i += 1) lines[i] = parsed.rawLines[i]
  while (lines.length < DEFAULT_HGS_TEMPLATE_LINES.length) {
    lines.push(DEFAULT_HGS_TEMPLATE_LINES[lines.length] ?? 'Reserved for future expansion')
  }

  const ship = withLen(parseCsvLine(lines[1]), 21)
  ship[0] = parsed.design.shipName
  ship[1] = parsed.design.shipClass
  ship[4] = parsed.design.hullCode
  ship[5] = String(parsed.design.techLevel)
  ship[6] = parsed.design.tonnage.toFixed(4)
  ship[7] = parsed.design.budgetMcr.toFixed(4)
  ship[8] = String(parsed.design.race)
  ship[9] = String(parsed.accom.crewRules)
  ship[10] = String(parsed.design.designSystem)
  ship[11] = parsed.design.isRefitted ? '1' : '0'
  ship[12] = String(parsed.design.refitTechLevel)
  ship[13] = parsed.design.refitBudgetMcr.toFixed(4)
  ship[14] = String(parsed.accom.alternateCrewRules)
  ship[15] = parsed.accom.flagship ? '1' : '0'
  lines[1] = writeCsvLinePreserving(parsed.rawLines[1], ship)

  const hull = withLen(parseCsvLine(lines[2]), 7)
  hull[0] = String(parsed.hull.config)
  hull[1] = String(parsed.hull.armour)
  hull[2] = String(parsed.hull.streamLining)
  hull[3] = String(parsed.hull.airframe)
  hull[4] = parsed.hull.structure.toFixed(4)
  lines[2] = writeCsvLinePreserving(parsed.rawLines[2], hull)

  const eng = withLen(parseCsvLine(lines[3]), 50)
  eng[0] = String(parsed.engine.mDrive)
  eng[1] = String(parsed.engine.jDrive)
  eng[2] = String(parsed.engine.pPlant)
  eng[3] = String(parsed.engine.bakMDrive)
  eng[4] = String(parsed.engine.bakJDrive)
  eng[5] = String(parsed.engine.bakPPlant)
  eng[6] = String(parsed.engine.bakMDriveNum)
  eng[7] = String(parsed.engine.bakJDriveNum)
  eng[8] = String(parsed.engine.bakPPlantNum)
  eng[9] = parsed.engine.powerTons.toFixed(3)
  eng[10] = parsed.engine.bakPowerTons.toFixed(3)
  eng[11] = String(parsed.engine.bakPowerTonsNum)
  eng[12] = parsed.engine.mDriveIsRefitted ? '1' : '0'
  eng[13] = String(parsed.engine.newMDrive)
  eng[15] = parsed.engine.jDriveIsRefitted ? '1' : '0'
  eng[16] = String(parsed.engine.newJDrive)
  eng[18] = parsed.engine.pPlantIsRefitted ? '1' : '0'
  eng[19] = String(parsed.engine.newPPlant)
  eng[20] = String(parsed.engine.pPlantRefitTech)
  eng[21] = parsed.engine.bakMDriveIsRefitted ? '1' : '0'
  eng[22] = String(parsed.engine.bakNewMDrive)
  eng[24] = parsed.engine.bakJDriveIsRefitted ? '1' : '0'
  eng[25] = String(parsed.engine.bakNewJDrive)
  eng[27] = parsed.engine.bakPPlantIsRefitted ? '1' : '0'
  eng[28] = String(parsed.engine.bakNewPPlant)
  eng[29] = String(parsed.engine.bakPPlantRefitTech)
  eng[30] = String(parsed.engine.bakNewMDriveNum)
  eng[31] = String(parsed.engine.bakNewJDriveNum)
  eng[32] = String(parsed.engine.bakNewPPlantNum)
  eng[33] = parsed.engine.powerTonsIsRefitted ? '1' : '0'
  eng[34] = parsed.engine.newPowerTons.toFixed(3)
  eng[35] = String(parsed.engine.powerTonsRefitTech)
  eng[36] = parsed.engine.bakPowerTonsIsRefitted ? '1' : '0'
  eng[37] = parsed.engine.bakNewPowerTons.toFixed(3)
  eng[38] = String(parsed.engine.bakPowerTonsRefitTech)
  eng[39] = String(parsed.engine.bakNewPowerTonsNum)
  eng[40] = parsed.engine.upgradeSpace.toFixed(3)
  eng[41] = parsed.engine.singleEngSpace ? '1' : '0'
  eng[42] = parsed.engine.driveUpgradesAllowed ? '1' : '0'
  lines[3] = writeCsvLinePreserving(parsed.rawLines[3], eng)

  const fuel = withLen(parseCsvLine(lines[4]), 16)
  fuel[0] = String(parsed.fuel.pFuel)
  fuel[1] = String(parsed.fuel.jFuel)
  fuel[2] = String(parsed.fuel.scoops)
  fuel[3] = String(parsed.fuel.purifier)
  fuel[4] = String(parsed.fuel.lhydPFuel)
  fuel[5] = String(parsed.fuel.lhydJFuel)
  fuel[6] = parsed.fuel.extraFuel.toFixed(4)
  fuel[7] = parsed.fuel.lhydExtraFuel.toFixed(4)
  fuel[8] = parsed.fuel.purifyLHyd ? '1' : '0'
  fuel[9] = parsed.fuel.refitPurif ? '1' : '0'
  fuel[10] = String(parsed.fuel.refitPurifTech)
  fuel[11] = String(parsed.fuel.basePFuel)
  fuel[12] = String(parsed.fuel.baseJFuel)
  fuel[13] = parsed.fuel.baseEFuel.toFixed(4)
  lines[4] = writeCsvLinePreserving(parsed.rawLines[4], fuel)

  const av = withLen(parseCsvLine(lines[5]), 56)
  av[0] = String(parsed.avionics.mainComp)
  av[1] = String(parsed.avionics.bakComp)
  av[2] = String(parsed.avionics.bakCompNum)
  av[3] = String(parsed.avionics.bridge)
  av[4] = String(parsed.avionics.bakBridge)
  av[5] = String(parsed.avionics.bakBridgeNum)
  av[6] = String(parsed.avionics.fltAvionics)
  av[7] = String(parsed.avionics.bakFltAvionics)
  av[8] = String(parsed.avionics.bakFltAvionicsNum)
  av[9] = String(parsed.avionics.sensors)
  av[10] = String(parsed.avionics.bakSensors)
  av[11] = String(parsed.avionics.bakSensorsNum)
  av[12] = String(parsed.avionics.comms)
  av[13] = String(parsed.avionics.bakComms)
  av[14] = String(parsed.avionics.bakCommsNum)
  av[15] = String(parsed.avionics.commsType)
  av[16] = parsed.avionics.flagBridge ? '1' : '0'
  av[17] = String(parsed.avionics.flagComp)
  lines[5] = writeCsvLinePreserving(parsed.rawLines[5], av)

  const spinal = withLen(parseCsvLine(lines[6]), 7)
  spinal[0] = String(parsed.weapons.spinalType)
  spinal[1] = String(parsed.weapons.spinalMount)
  lines[6] = writeCsvLinePreserving(parsed.rawLines[6], spinal)

  const big = withLen(parseCsvLine(lines[7]), 19)
  big[0] = String(parsed.weapons.bigEmptyBays)
  big[1] = String(parsed.weapons.bigMesonBays)
  big[2] = String(parsed.weapons.bigPaBays)
  big[3] = String(parsed.weapons.bigRepulsorBays)
  big[4] = String(parsed.weapons.bigMissileBays)
  lines[7] = writeCsvLinePreserving(parsed.rawLines[7], big)

  const little = withLen(parseCsvLine(lines[8]), 25)
  little[0] = String(parsed.weapons.littleEmptyBays)
  little[1] = String(parsed.weapons.littleMesonBays)
  little[2] = String(parsed.weapons.littlePaBays)
  little[3] = String(parsed.weapons.littleRepulsorBays)
  little[4] = String(parsed.weapons.littleMissileBays)
  little[5] = String(parsed.weapons.littleEnergyBays)
  little[6] = String(parsed.weapons.littleEnergyType)
  lines[8] = writeCsvLinePreserving(parsed.rawLines[8], little)

  const tur = withLen(parseCsvLine(lines[9]), 28)
  tur[0] = String(parsed.weapons.emptyTurrets)
  tur[1] = String(parsed.weapons.emptyTurretStyle)
  tur[2] = String(parsed.weapons.missileTurrets)
  tur[3] = String(parsed.weapons.missileTurretStyle)
  tur[4] = String(parsed.weapons.missileTurretBatteries)
  tur[5] = String(parsed.weapons.laserTurrets)
  tur[6] = String(parsed.weapons.laserTurretStyle)
  tur[7] = String(parsed.weapons.laserTurretBatteries)
  tur[8] = String(parsed.weapons.laserType)
  tur[9] = String(parsed.weapons.energyTurrets)
  tur[10] = String(parsed.weapons.energyTurretStyle)
  tur[11] = String(parsed.weapons.energyTurretBatteries)
  tur[12] = String(parsed.weapons.energyType)
  tur[13] = String(parsed.weapons.sandTurrets)
  tur[14] = String(parsed.weapons.sandTurretStyle)
  tur[15] = String(parsed.weapons.sandTurretBatteries)
  tur[16] = String(parsed.weapons.paTurrets)
  tur[17] = String(parsed.weapons.paTurretStyle)
  tur[18] = String(parsed.weapons.paTurretBatteries)
  tur[19] = String(parsed.weapons.mixedTurrets)
  tur[20] = String(parsed.weapons.numMixTurrets)
  tur[21] = String(parsed.weapons.emptyMixTurrets)
  tur[22] = String(parsed.weapons.mixTurretStyle)
  tur[23] = String(parsed.weapons.mixTurretMissiles)
  tur[24] = String(parsed.weapons.mixTurretLasers)
  tur[25] = String(parsed.weapons.laserType)
  tur[26] = String(parsed.weapons.mixTurretSand)
  tur[27] = String(parsed.weapons.mixTurretEnergy)
  lines[9] = writeCsvLinePreserving(parsed.rawLines[9], tur)

  const scr = withLen(parseCsvLine(lines[10]), 10)
  scr[0] = String(parsed.screens.nucDamp)
  scr[1] = String(parsed.screens.mesScrn)
  scr[2] = String(parsed.screens.blkGlb)
  scr[3] = String(parsed.screens.bakNucDamp)
  scr[4] = String(parsed.screens.bakMesScrn)
  scr[5] = String(parsed.screens.bakBlkGlb)
  scr[6] = String(parsed.screens.bakNucDampNum)
  scr[7] = String(parsed.screens.bakMesScrnNum)
  scr[8] = String(parsed.screens.bakBlkGlbNum)
  scr[9] = parsed.screens.extraCaps.toFixed(4)
  lines[10] = writeCsvLinePreserving(parsed.rawLines[10], scr)

  const cr = withLen(parseCsvLine(lines[11]), 53)
  parsed.craft.items.forEach((item, i) => {
    const o = i * 6
    cr[o] = String(item.num)
    cr[o + 1] = item.tonnage.toFixed(4)
    cr[o + 2] = item.desc ?? ''
    cr[o + 3] = String(item.crew)
    cr[o + 4] = String(item.vehicle)
    cr[o + 5] = item.price.toFixed(4)
  })
  cr[48] = String(parsed.craft.ftrSqd)
  cr[49] = String(parsed.craft.lf1Num)
  cr[50] = parsed.craft.lf1Size.toFixed(4)
  cr[51] = String(parsed.craft.lf2Num)
  cr[52] = parsed.craft.lf2Size.toFixed(4)
  lines[11] = writeCsvLinePreserving(parsed.rawLines[11], cr)

  const ac = withLen(parseCsvLine(lines[12]), 27)
  ac[0] = String(parsed.accom.dblOccMark)
  ac[1] = String(parsed.accom.shpTrpMark)
  ac[2] = String(parsed.accom.highPass)
  ac[3] = String(parsed.accom.midPass)
  ac[4] = String(parsed.accom.lowPass)
  ac[5] = parsed.accom.stRoom.toFixed(1)
  ac[6] = parsed.accom.smStRoom.toFixed(1)
  ac[7] = String(parsed.accom.couches)
  ac[8] = String(parsed.accom.lowBerth)
  ac[9] = String(parsed.accom.emLowBerth)
  ac[10] = parsed.accom.cargo.toFixed(4)
  ac[12] = String(parsed.accom.marines)
  ac[13] = String(parsed.accom.otherCrew)
  ac[14] = String(parsed.accom.dropCaps)
  ac[15] = String(parsed.accom.readyDropCaps)
  ac[16] = String(parsed.accom.storedDropCaps)
  ac[17] = String(parsed.accom.frozWatch)
  ac[18] = String(parsed.accom.engShop)
  ac[19] = String(parsed.accom.vehicleShop)
  ac[20] = String(parsed.accom.labs)
  ac[21] = String(parsed.accom.sickBay)
  ac[22] = String(parsed.accom.autoDoc)
  ac[23] = String(parsed.accom.airlock)
  ac[24] = String(parsed.accom.fresher)
  ac[25] = parsed.accom.missileMag.toFixed(4)
  ac[26] = parsed.accom.bk2Captain ? '1' : '0'
  lines[12] = writeCsvLinePreserving(parsed.rawLines[12], ac)

  const ud = withLen(parseCsvLine(lines[13]), 77)
  parsed.userDef.items.forEach((item, i) => {
    const o = i * 10
    ud[o] = String(item.num)
    ud[o + 1] = item.size.toFixed(4)
    ud[o + 2] = item.desc ?? ''
    ud[o + 3] = String(item.crew)
    ud[o + 4] = item.ep.toFixed(4)
    ud[o + 5] = item.cost.toFixed(4)
    ud[o + 6] = String(item.hp)
  })
  lines[13] = writeCsvLinePreserving(parsed.rawLines[13], ud)

  const lo = parsed.legacyOptions ?? defaultLegacyOptionsInputs()
  const opt = withLen(parseCsvLine(lines[14] ?? ''), 9)
  opt[0] = lo.chargeForHardpoints ? '1' : '0'
  opt[1] = lo.autoCalcAccom ? '1' : '0'
  opt[2] = lo.optPowerTon ? '1' : '0'
  opt[3] = parsed.engine.milStdJump ? '1' : '0'
  opt[4] = lo.milStdMod.toFixed(4)
  lines[14] = writeCsvLinePreserving(parsed.rawLines[14], opt)

  const notes = parsed.design.notes
    .split('\n')
    .map((line) => line.trimEnd())
    .filter((line) => line.length > 0)
  const trailing = lines.slice(15)
  const reserved = trailing.filter((line) => /^Reserved for future expansion$/i.test(line))
  const extra = trailing.filter((line) => !/^Reserved for future expansion$/i.test(line))
  const mergedTrailing = [...notes, ...extra]
  while (mergedTrailing.length < 3) mergedTrailing.push(reserved[mergedTrailing.length] ?? 'Reserved for future expansion')
  return [...lines.slice(0, 15), ...mergedTrailing].join('\n')
}


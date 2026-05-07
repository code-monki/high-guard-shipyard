/* validation.ts — Design rule validation matching the original High Guard Shipyard desktop application, producing a list of ValidationIssue codes with descriptive messages. */

import type {
  AccomInputs,
  AvionicsInputs,
  EngineInputs,
  FuelInputs,
  HullInputs,
  ScreenInputs,
  ShipDesign,
  ValidationIssue,
  UserDefInputs,
  WeaponInputs,
} from '../types'

/** Minimum tech level required for each computer index (0 = none; indices 1–20 map to Model/1 through Model/9fib). */
const COMPUTER_TL = [0, 5, 6, 7, 7, 7, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15]
/** Human-readable label for each computer index, used in validation error messages (format: "index name"). */
const COMPUTER_DESC = [
  '0 None',
  '1 Model/1',
  'A Model/1fib',
  'R Model/1bis',
  '2 Model/2',
  'B Model/2fib',
  'S Model/2bis',
  '3 Model/3',
  'C Model/3fib',
  '4 Model/4',
  'D Model/4fib',
  '5 Model/5',
  'E Model/5fib',
  '6 Model/6',
  'F Model/6fib',
  '7 Model/7',
  'G Model/7fib',
  '8 Model/8',
  'H Model/8fib',
  '9 Model/9',
  'J Model/9fib',
]

/** Labels for spinal meson gun mount indices A–T (index 0 = none); used in validation messages. */
const SPINAL_MESON_DESC = [
  '0 None', 'A Meson', 'B Meson', 'C Meson', 'D Meson', 'E Meson', 'F Meson', 'G Meson', 'H Meson',
  'J Meson', 'K Meson', 'L Meson', 'M Meson', 'N Meson', 'P Meson', 'Q Meson', 'R Meson', 'S Meson', 'T Meson',
]
/** Labels for spinal particle accelerator mount indices A–T (index 0 = none); used in validation messages. */
const SPINAL_PA_DESC = [
  '0 None', 'A PA', 'B PA', 'C PA', 'D PA', 'E PA', 'F PA', 'G PA', 'H PA',
  'J PA', 'K PA', 'L PA', 'M PA', 'N PA', 'P PA', 'Q PA', 'R PA', 'S PA', 'T PA',
]
/** Minimum TL for each spinal meson gun mount index (A–T). */
const SPINAL_MESON_MIN_TL = [0, 11, 11, 12, 12, 13, 13, 14, 14, 15, 12, 13, 14, 15, 13, 14, 15, 14, 15]
/** Minimum TL for each spinal particle accelerator mount index (A–T). */
const SPINAL_PA_MIN_TL = [0, 8, 9, 10, 11, 12, 13, 14, 15, 10, 11, 12, 13, 14, 15, 12, 13, 14, 15]
/** Computer index values that are legal on small craft (vessels under 100t); fib/bis computers are excluded. */
const SMALL_CRAFT_ALLOWED = new Set([0, 1, 4, 7, 9, 11, 13, 15, 17, 19])
/** Minimum TL for nuclear damper factors 1–9 (index 0 = none). */
const NUC_DAMP_MIN_TL = [0, 12, 13, 13, 14, 14, 14, 15, 15, 15]
/** Minimum TL for meson screen factors 1–9 (index 0 = none). */
const MESON_SCREEN_MIN_TL = [0, 12, 13, 13, 14, 14, 14, 15, 15, 15]
/** Minimum TL for black globe factors 1–9 (index 0 = none). */
const BLACK_GLOBE_MIN_TL = [0, 15, 15, 15, 15, 16, 16, 16, 17, 18]

const computerModel = (computer: number): number => {
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

const minModelByJump = (jump: number): number => {
  if (jump <= 0) return 0
  if (jump === 1) return 1
  if (jump === 2) return 2
  if (jump === 3) return 3
  if (jump === 4) return 4
  if (jump === 5) return 5
  return 6
}

const minComputerByTonnage = (tonnage: number): number => {
  if (tonnage >= 1_000_000) return 15
  if (tonnage >= 100_000) return 13
  if (tonnage >= 50_000) return 11
  if (tonnage >= 10_000) return 9
  if (tonnage >= 4_000) return 7
  if (tonnage >= 1_000) return 4
  if (tonnage >= 600) return 1
  if (tonnage >= 100) return 1
  return 0
}

const minFlightAvionics = (tonnage: number, hull: HullInputs): number => {
  let model = 1
  if (tonnage > 100_000) model = 7
  else if (tonnage > 50_000) model = 6
  else if (tonnage > 10_000) model = 5
  else if (tonnage > 4_000) model = 4
  else if (tonnage > 1_000) model = 3
  else if (tonnage > 600) model = 2

  const streamlined = hull.streamLining === 0
  const airframe = hull.airframe === 0
  const streamlinedHull = hull.config < 3 || hull.config === 6
  if (streamlined && !streamlinedHull) model += 1
  if (airframe && streamlinedHull) model += 1
  if (airframe && !streamlinedHull) model += 2
  return model
}

const intUp = (n: number): number => Math.ceil(n)

/**
 * Minimum staterooms / couches / low berths from the same formulas embedded in `validateDesign`,
 * matching desktop behaviour when `Options.AutoCalcAccom` adjusts accommodations (`ShipPas.DesignIsValid`).
 * Expects `accom` to already include derived command and crew counts (`engCmdCrew`, `engCrew`, …).
 */
export const computeLegacyAutoAccomMinimums = (
  design: ShipDesign,
  avionics: AvionicsInputs,
  accom: AccomInputs,
): { minStRoom: number; minCouches: number; minLowBerth: number } => {
  const getTotalCmdCrew = (): number => {
    const medicalCmdCrew = accom.crewRules === 1 && design.tonnage >= 100 ? 1 : 0
    const moduleCmd =
      accom.engCmdCrew +
      accom.avionicsCmdCrew +
      Math.min(
        1,
        accom.spinalCmdCrew +
          accom.bigBaysCmdCrew +
          accom.littleBaysCmdCrew +
          accom.turretsCmdCrew +
          accom.screensCmdCrew,
      ) +
      accom.craftCmdCrew +
      accom.accomCmdCrew +
      Math.min(1, accom.marines) +
      accom.userDefCmdCrew
    return moduleCmd + medicalCmdCrew
  }
  const getTotalCrew = (): number => {
    const totalCmd = getTotalCmdCrew()
    const iCrew =
      accom.engCrew +
      accom.avionicsCrew +
      accom.spinalCrew +
      accom.bigBaysCrew +
      accom.littleBaysCrew +
      accom.turretsCrew +
      accom.screensCrew +
      accom.craftCrew +
      accom.accomCrew +
      accom.shipsTroops +
      Math.max(0, accom.marines - 1) +
      accom.otherCrew +
      accom.userDefCrew +
      totalCmd +
      accom.highPass +
      accom.midPass +
      accom.lowBerth
    let medicalCrew = 0
    if (accom.crewRules === 1 && design.tonnage >= 100) {
      medicalCrew = Math.floor(iCrew / 240)
      while (Math.floor((iCrew + medicalCrew) / 240) > medicalCrew) {
        medicalCrew = Math.floor((iCrew + medicalCrew) / 240)
      }
    }
    return (
      accom.engCrew +
      accom.avionicsCrew +
      accom.spinalCrew +
      accom.bigBaysCrew +
      accom.littleBaysCrew +
      accom.turretsCrew +
      accom.screensCrew +
      accom.craftCrew +
      accom.accomCrew +
      accom.shipsTroops +
      Math.max(0, accom.marines - 1) +
      accom.otherCrew +
      accom.userDefCrew +
      medicalCrew
    )
  }
  const calcSizeCrewSections = (): number => {
    const sections = Math.max(1, accom.numCrewSections)
    return intUp((getTotalCmdCrew() + getTotalCrew()) / sections)
  }
  const calcStRoomRequired = (): number => {
    let result =
      accom.dblOccMark === 0
        ? getTotalCmdCrew() + getTotalCrew() / 2 + accom.highPass + accom.midPass
        : getTotalCmdCrew() + getTotalCrew() + accom.highPass + accom.midPass
    if (accom.flagship) {
      result += accom.dblOccMark === 0 ? 6 : 11
    }
    return result
  }
  const calcCouchesRequired = (): number => {
    const base = getTotalCmdCrew() + getTotalCrew() + accom.highPass + accom.midPass
    return avionics.bridge === 0 ? Math.max(0, base - 2) : base
  }
  const calcLowBerthRequired = (): number => {
    if (accom.alternateCrewRules > 1) {
      return accom.lowPass + intUp(((getTotalCmdCrew() + getTotalCrew()) * accom.frozWatch) / 2)
    }
    return accom.lowPass + intUp(calcSizeCrewSections() * accom.frozWatch)
  }
  return {
    minStRoom: calcStRoomRequired(),
    minCouches: calcCouchesRequired(),
    minLowBerth: calcLowBerthRequired(),
  }
}

/**
 * Validates the full ship design against all High Guard rules and returns a list of violations.
 * @param summary - Optional pre-computed remaining tonnage, budget, and EP totals used for budget/overload checks.
 * @returns Array of `ValidationIssue` objects; empty array means the design is rule-compliant.
 */
export const validateDesign = (
  design: ShipDesign,
  hull: HullInputs,
  engine: EngineInputs,
  fuel: FuelInputs,
  avionics: AvionicsInputs,
  weapons: WeaponInputs,
  screens: ScreenInputs,
  accom: AccomInputs,
  userDef: UserDefInputs,
  summary?: { remainingTonnage: number; remainingBudget: number; remainingEp: number },
): ValidationIssue[] => {
  const issues: ValidationIssue[] = []
  const addIssue = (code: number, message: string) => issues.push({ code, message })
  const accomMins = computeLegacyAutoAccomMinimums(design, avionics, accom)
  const legacyMessage = (code: number): string => {
    switch (code) {
      case 33:
        return 'Ships with Jump Drive require a Computer.'
      case 34:
        return 'A Model/1bis computer or better is required for Jump 2.'
      case 35:
        return 'A Model/2bis computer or better is required for Jump 3.'
      case 36:
        return 'A Model/4 computer or better is required for Jump 4.'
      case 37:
        return 'A Model/5 computer or better is required for Jump 5.'
      case 38:
        return 'A Model/6 computer or better is required for Jump 6.'
      case 39:
        return 'Small Craft (Vessels under 100T) must be fitted with either a Bridge or a Computer.'
      case 40:
        return 'Ships of 100T and over must be fitted with a Bridge.'
      case 41:
        return 'Ships of 100T and over must be fitted with a Computer.'
      case 42:
        return 'Ships of 600T and over must be fitted with a Model/1 Computer or better.'
      case 43:
        return 'Ships of 1000T and over must be fitted with a Model/2 Computer or better.'
      case 44:
        return 'Ships of 4000T and over must be fitted with a Model/3 Computer or better.'
      case 45:
        return 'Ships of 10,000T and over must be fitted with a Model/4 Computer or better.'
      case 46:
        return 'Ships of 50,000T and over must be fitted with a Model/5 Computer or better.'
      case 47:
        return 'Ships of 100,000T and over must be fitted with a Model/6 Computer or better.'
      case 48:
        return 'Ships of 1,000,000T and over must be fitted with a Model/7 Computer or better.'
      case 49: {
        const comp = COMPUTER_DESC[mainComp] ?? 'Unknown'
        const tl = COMPUTER_TL[mainComp] ?? 0
        return `${comp.slice(2)} Main Computers require a minimum Tech Level of ${tl}.`
      }
      case 50: {
        const comp = COMPUTER_DESC[avionics.bakComp] ?? 'Unknown'
        const tl = COMPUTER_TL[avionics.bakComp] ?? 0
        return `${comp.slice(2)} Main Computers require a minimum Tech Level of ${tl}.`
      }
      case 107:
        return 'Small Craft may not be fitted with Fib or Bis Computers.'
      case 108:
        return 'Small Craft may not be fitted with Fib or Bis Backup Computers..'
      case 51:
        return 'There are not enough hardpoints available for the weapons fitted.'
      case 73:
        return 'Mixed Turrets are not permitted for ships in excess of 1000 Tons.'
      case 74:
        return 'Spinal Meson Guns and 100T Meson Bays may not be included.'
      case 75:
        return 'Spinal Meson Guns and 50T Meson Bays may not be included.'
      case 76:
        return 'Spinal Particle Accelerators and 100T Particle Accelerator Bays may not be included.'
      case 77:
        return 'Spinal Particle Accelerators and 50T Particle Accelerator Bays may not be included.'
      case 78:
        return 'Spinal Particle Accelerators and Particle Accelerator Turrets may not be included.'
      case 79:
        return '100T and 50T Meson Bays may not be mixed.'
      case 80:
        return '100T and 50T Particle Accelerator Bays may not be mixed.'
      case 81:
        return '100T and 50T Repulsor Bays may not be mixed.'
      case 82:
        return '100T and 50T Missile Bays may not be mixed.'
      case 83:
        return '100T Particle Accelerator Bays and Particle Accelerator Turrets may not be mixed.'
      case 84:
        return '100T Missile Bays and Missile Turrets may not be mixed.'
      case 85:
        return '100T Missile Bays and Missile Turrets may not be mixed.'
      case 86:
        return '50T Particle Accelerator Bays and Particle Accelerator Turrets may not be mixed.'
      case 87:
        return '50T Missile Bays and Missile Turrets may not be mixed.'
      case 88:
        return '50T Missile Bays and Missile Turrets may not be mixed.'
      case 89:
        return '50T Energy Bays and Energy Turrets may not be mixed.'
      case 52:
        return 'Spinal Meson Guns require a minimum Tech Level of 11.'
      case 53:
        return 'Spinal Particle Accelerators require a minimum Tech Level of 8.'
      case 56:
        return '100T Bays require a minimum hull size of 1000T.'
      case 57:
        return '100T Meson Gun Bays require a minimum Tech Level of 13.'
      case 58:
        return '100T Particle Accelorator Bays require a minimum Tech Level of 8.'
      case 59:
        return '100T Repulsor Bays require a minimum Tech Level of 10.'
      case 60:
        return '50T Bays require a minimum hull size of 1000T.'
      case 61:
        return '50T Bays require a minimum Tech Level of 10.'
      case 62:
        return '50T Meson Gun Bays require a minimum Tech Level of 15.'
      case 63:
        return '50T Particle Accelorator Bays require a minimum Tech Level of 10.'
      case 64:
        return '50T Repulsor Bays require a minimum Tech Level of 14.'
      case 65:
        return '50T Missile Bays require a minimum Tech Level of 10.'
      case 66:
        return '50T Plasma Gun Bays require a minimum Tech Level of 10.'
      case 67:
        return '50T Fusion Gun Bays require a minimum Tech Level of 12.'
      case 68:
      case 72:
        return 'Beam Laser Turrets require a minimum Tech Level of 9.'
      case 69:
        return 'Plasma Gun Turrets require a minimum Tech Level of 10.'
      case 70:
        return 'Fusion Gun Turrets require a minimum Tech Level of 12.'
      case 71:
        return 'Particle Accelerator Barbettes require a minimum Tech Level of 14.'
      case 90:
        return `Factor ${screens.nucDamp} Nuclear Dampers require a minimum Tech Level of ${NUC_DAMP_MIN_TL[screens.nucDamp] ?? 0}.`
      case 91:
        return `Factor ${screens.mesScrn} Meson Screens require a minimum Tech Level of ${MESON_SCREEN_MIN_TL[screens.mesScrn] ?? 0}.`
      case 92:
        return `Factor ${screens.blkGlb} Black Globes require a minimum Tech Level of ${BLACK_GLOBE_MIN_TL[screens.blkGlb] ?? 0}.`
      case 93:
        return `Factor ${screens.bakNucDamp} Backup Nuclear Dampers require a minimum Tech Level of ${NUC_DAMP_MIN_TL[screens.bakNucDamp] ?? 0}.`
      case 94:
        return `Factor ${screens.bakMesScrn} BackUp Meson Screens require a minimum Tech Level of ${MESON_SCREEN_MIN_TL[screens.bakMesScrn] ?? 0}.`
      case 95:
        return `Factor ${screens.bakBlkGlb} Backup Black Globes require a minimum Tech Level of ${BLACK_GLOBE_MIN_TL[screens.bakBlkGlb] ?? 0}.`
      case 96:
        return 'Low Berths require a minimum Tech Level of 9.'
      case 97:
        return 'Emergancy Low Berths require a minimum Tech Level of 9.'
      case 98:
        return 'Drop Capsules require a minimum Tech Level of 10.'
      case 99:
        return 'Insufficent Staterooms.'
      case 100:
        return 'Insufficent Couches.'
      case 101:
        return 'Insufficent Low Berths.'
      case 102:
        return 'Ready Drop Capsules are fitted with no Drop Casules Launchers.'
      case 103:
        return 'Stored Drop Capsules are fitted with no Drop Casules Launchers.'
      case 104:
        return 'Small Craft Staterooms are not permitted on Non-Small Craft (Vessels under 100T).'
      case 105:
        return 'Small Craft Couches are not permitted on Non-Small Craft (Vessels under 100T).'
      case 106:
        return 'Staterooms are not permitted on Small Craft (Vessels under 100T).'
      case 25:
        return 'Your Power Plant is Smaller than Your Maneuver Drive.'
      case 1:
        return 'The hull is too small.'
      case 2:
        return 'You are over budget.'
      case 3:
        return 'Book 2 Crew Rules are only allowed for ships under 1000 Tons.'
      case 5:
        return 'There are not enough Energy Points (EP).'
      case 6:
        return 'Small Craft may not use Planetoid Hulls.'
      case 7:
        return 'Armour Added to the hull may not exceed Tech Level.'
      case 8:
        return 'Small Craft (Vessels smaller than 100T) may not be fitted with Jump Drive.'
      case 9:
        return 'Ships at Tech Level 7 are restricted to Maneuver Drive 2.'
      case 10:
        return 'Ships at Tech Level 8 are restricted to Maneuver Drive 5.'
      case 11:
        return 'Ships at Tech Level 7 are restricted to Backup Maneuver Drive 2.'
      case 12:
        return 'Ships at Tech Level 8 are restricted to Backup Maneuver Drive 5.'
      case 13:
        return 'Ships Below Tech Level 9 May Not Have Jump Drive.'
      case 14:
        return 'Ships Below Tech Level 11 are Restricted to Jump 1.'
      case 15:
        return 'Ships Below Tech Level 12 are Restricted to Jump 2.'
      case 16:
        return 'Ships Below Tech Level 13 are Restricted to Jump 3.'
      case 17:
        return 'Ships Below Tech Level 14 are Restricted to Jump 4.'
      case 18:
        return 'Ships Below Tech Level 15 are Restricted to Jump 5.'
      case 19:
        return 'Ships Below Tech Level 9 May Not Have Backup Jump Drive.'
      case 20:
        return 'Ships Below Tech Level 11 are Restricted to Backup Jump 1.'
      case 21:
        return 'Ships Below Tech Level 12 are Restricted to Backup Jump 2.'
      case 22:
        return 'Ships Below Tech Level 13 are Restricted to Backup Jump 3.'
      case 23:
        return 'Ships Below Tech Level 14 are Restricted to Backup Jump 4.'
      case 24:
        return 'Ships Below Tech Level 15 are Restricted to Backup Jump 5.'
      case 26:
        return 'Your Power Plant is Smaller than Your Jump Drive.'
      case 27:
        return 'Unstreamlined Ships may not be Fitted with Fuel Scoops.'
      case 28:
        return 'Fuel Purification requires a minimum Tech Level of 8.'
      case 29:
        return 'Under Standard Rules, ships require at least 28 days Power Plant Fuel.'
      case 30:
        return 'Under Standard Rules, Power Plant Fuel must be in multiples of 28 days.'
      case 31:
        return 'Under Standard Rules, ships require at least 28 days Lhyd Power Plant Fuel if it is included.'
      case 32:
        return 'Under Standard Rules, Power Plant Fuel must be in multiples of 28 days if it is included.'
      default:
        return ''
    }
  }
  const mainComp = avionics.mainComp
  const compModel = computerModel(mainComp)
  const flightCompModel = mainComp === 3 || mainComp === 6 ? compModel + 1 : compModel
  const mDrive = engine.mDriveIsRefitted ? engine.newMDrive : engine.mDrive
  const bakMDrive = engine.bakMDriveIsRefitted ? engine.bakNewMDrive : engine.bakMDrive
  const jDrive = engine.jDriveIsRefitted ? engine.newJDrive : engine.jDrive
  const bakJDrive = engine.bakJDriveIsRefitted ? engine.bakNewJDrive : engine.bakJDrive
  const pPlant = engine.pPlantIsRefitted ? engine.newPPlant : engine.pPlant

  if ((summary?.remainingTonnage ?? 0) < 0) addIssue(1, legacyMessage(1))
  if ((summary?.remainingBudget ?? 0) < 0 && !design.isRefitted) addIssue(2, legacyMessage(2))
  if (accom.crewRules === 0 && design.tonnage > 1000) addIssue(3, legacyMessage(3))
  if ((summary?.remainingEp ?? 0) < 0) addIssue(5, legacyMessage(5))
  if (hull.config > 7 && design.tonnage < 100) addIssue(6, legacyMessage(6))
  if (hull.armour > design.techLevel) addIssue(7, legacyMessage(7))
  if (design.tonnage < 100 && jDrive > 0) addIssue(8, legacyMessage(8))
  if (mDrive > 2 && design.techLevel < 8) addIssue(9, legacyMessage(9))
  if (mDrive > 5 && design.techLevel < 9) addIssue(10, legacyMessage(10))
  if (bakMDrive > 2 && design.techLevel < 8) addIssue(11, legacyMessage(11))
  if (bakMDrive > 5 && design.techLevel < 9) addIssue(12, legacyMessage(12))
  if (jDrive > 0 && design.techLevel < 9) addIssue(13, legacyMessage(13))
  if (jDrive > 1 && design.techLevel < 11) addIssue(14, legacyMessage(14))
  if (jDrive > 2 && design.techLevel < 12) addIssue(15, legacyMessage(15))
  if (jDrive > 3 && design.techLevel < 13) addIssue(16, legacyMessage(16))
  if (jDrive > 4 && design.techLevel < 14) addIssue(17, legacyMessage(17))
  if (jDrive > 5 && design.techLevel < 15) addIssue(18, legacyMessage(18))
  if (bakJDrive > 0 && design.techLevel < 9) addIssue(19, legacyMessage(19))
  if (bakJDrive > 1 && design.techLevel < 11) addIssue(20, legacyMessage(20))
  if (bakJDrive > 2 && design.techLevel < 12) addIssue(21, legacyMessage(21))
  if (bakJDrive > 3 && design.techLevel < 13) addIssue(22, legacyMessage(22))
  if (bakJDrive > 4 && design.techLevel < 14) addIssue(23, legacyMessage(23))
  if (bakJDrive > 5 && design.techLevel < 15) addIssue(24, legacyMessage(24))

  if (pPlant < mDrive) {
    addIssue(25, legacyMessage(25))
  }
  if (pPlant < jDrive) {
    addIssue(26, legacyMessage(26))
  }
  if (fuel.scoops === 0 && hull.config > 6) {
    addIssue(27, legacyMessage(27))
  }
  if (fuel.purifier === 0 && design.techLevel < 8) {
    addIssue(28, legacyMessage(28))
  }
  if (fuel.pFuel > 0 && fuel.pFuel < 28 && design.tonnage >= 100) {
    addIssue(29, legacyMessage(29))
  }
  if (fuel.pFuel > 0 && fuel.pFuel % 28 !== 0 && design.tonnage >= 100) {
    addIssue(30, legacyMessage(30))
  }
  if (fuel.lhydPFuel > 0 && fuel.lhydPFuel < 28 && design.tonnage >= 100) {
    addIssue(31, legacyMessage(31))
  }
  if (fuel.lhydPFuel > 0 && fuel.lhydPFuel % 28 !== 0 && design.tonnage >= 100) {
    addIssue(32, legacyMessage(32))
  }

  const totalBigBays =
    weapons.bigEmptyBays +
    weapons.bigMesonBays +
    weapons.bigPaBays +
    weapons.bigRepulsorBays +
    weapons.bigMissileBays
  const totalLittleBays =
    weapons.littleEmptyBays +
    weapons.littleMesonBays +
    weapons.littlePaBays +
    weapons.littleRepulsorBays +
    weapons.littleMissileBays +
    weapons.littleEnergyBays

  if (design.techLevel < 11 && weapons.spinalType === 1) addIssue(52, legacyMessage(52))
  if (design.techLevel < 8 && weapons.spinalType === 2) addIssue(53, legacyMessage(53))

  const mesonMinTl = SPINAL_MESON_MIN_TL[weapons.spinalMount] ?? 0
  const paMinTl = SPINAL_PA_MIN_TL[weapons.spinalMount] ?? 0
  if (weapons.spinalType === 1 && design.techLevel < mesonMinTl) {
    const mountDesc = SPINAL_MESON_DESC[weapons.spinalMount] ?? 'Meson'
    addIssue(54, `${mountDesc} Gun Spinal Mounts require a minimum Tech Level of ${mesonMinTl}.`)
  }
  if (weapons.spinalType === 2 && design.techLevel < paMinTl) {
    const mountDesc = SPINAL_PA_DESC[weapons.spinalMount] ?? 'PA'
    const label = mountDesc.includes(' ') ? mountDesc.split(' ')[0] : mountDesc
    addIssue(55, `${label} Particle Accelerator Spinal Mounts require a minimum Tech Level of ${paMinTl}.`)
  }

  if (totalBigBays > 0 && design.tonnage < 1000) addIssue(56, legacyMessage(56))
  if (weapons.bigMesonBays > 0 && design.techLevel < 13) addIssue(57, legacyMessage(57))
  if (weapons.bigPaBays > 0 && design.techLevel < 8) addIssue(58, legacyMessage(58))
  if (weapons.bigRepulsorBays > 0 && design.techLevel < 10) addIssue(59, legacyMessage(59))
  if (totalLittleBays > 0 && design.tonnage < 1000) addIssue(60, legacyMessage(60))
  // Error 61 is disabled in the original code and intentionally not enforced.
  if (weapons.littleMesonBays > 0 && design.techLevel < 15) addIssue(62, legacyMessage(62))
  if (weapons.littlePaBays > 0 && design.techLevel < 10) addIssue(63, legacyMessage(63))
  if (weapons.littleRepulsorBays > 0 && design.techLevel < 14) addIssue(64, legacyMessage(64))
  if (weapons.littleMissileBays > 0 && design.techLevel < 10) addIssue(65, legacyMessage(65))
  if (weapons.littleEnergyBays > 0 && weapons.littleEnergyType === 0 && design.techLevel < 10) {
    addIssue(66, legacyMessage(66))
  }
  if (weapons.littleEnergyBays > 0 && weapons.littleEnergyType === 1 && design.techLevel < 12) {
    addIssue(67, legacyMessage(67))
  }
  if (weapons.laserTurrets > 0 && weapons.laserType === 0 && design.techLevel < 9) {
    addIssue(68, legacyMessage(68))
  }
  if (weapons.energyTurrets > 0 && weapons.energyType === 0 && design.techLevel < 10) {
    addIssue(69, legacyMessage(69))
  }
  if (weapons.energyTurrets > 0 && weapons.energyType === 1 && design.techLevel < 12) {
    addIssue(70, legacyMessage(70))
  }
  if (weapons.paTurrets > 0 && design.techLevel < 14) addIssue(71, legacyMessage(71))
  if (weapons.mixTurretLasers > 0 && weapons.laserType === 0 && design.techLevel < 9) {
    addIssue(72, legacyMessage(72))
  }
  if (design.techLevel < (NUC_DAMP_MIN_TL[screens.nucDamp] ?? 0)) addIssue(90, legacyMessage(90))
  if (design.techLevel < (MESON_SCREEN_MIN_TL[screens.mesScrn] ?? 0)) addIssue(91, legacyMessage(91))
  if (design.techLevel < (BLACK_GLOBE_MIN_TL[screens.blkGlb] ?? 0)) addIssue(92, legacyMessage(92))
  if (design.techLevel < (NUC_DAMP_MIN_TL[screens.bakNucDamp] ?? 0)) addIssue(93, legacyMessage(93))
  if (design.techLevel < (MESON_SCREEN_MIN_TL[screens.bakMesScrn] ?? 0)) addIssue(94, legacyMessage(94))
  if (design.techLevel < (BLACK_GLOBE_MIN_TL[screens.bakBlkGlb] ?? 0)) addIssue(95, legacyMessage(95))
  if (design.techLevel < 9 && accom.lowBerth > 0) addIssue(96, legacyMessage(96))
  if (design.techLevel < 9 && accom.emLowBerth > 0) addIssue(97, legacyMessage(97))
  if (design.techLevel < 10 && accom.dropCaps + accom.readyDropCaps + accom.storedDropCaps > 0) {
    addIssue(98, legacyMessage(98))
  }
  if (design.tonnage >= 100 && accom.stRoom < accomMins.minStRoom) addIssue(99, legacyMessage(99))
  if (design.tonnage < 100 && accom.couches < accomMins.minCouches) addIssue(100, legacyMessage(100))
  if (accom.lowBerth < accomMins.minLowBerth) addIssue(101, legacyMessage(101))
  if (accom.dropCaps < 1 && accom.readyDropCaps > 0) addIssue(102, legacyMessage(102))
  if (accom.dropCaps < 1 && accom.storedDropCaps > 0) addIssue(103, legacyMessage(103))
  if (accom.smStRoom > 0 && design.tonnage >= 100) addIssue(104, legacyMessage(104))
  // Errors 105 and 106 are disabled in the original code and intentionally not enforced.

  const shipHardPoints = Math.max(1, Math.floor(design.tonnage / 100))
  const turretHardPoints =
    weapons.mixedTurrets === 0
      ? weapons.numMixTurrets
      : weapons.emptyTurrets +
        weapons.missileTurrets +
        weapons.laserTurrets +
        weapons.energyTurrets +
        weapons.sandTurrets +
        weapons.paTurrets
  const usedHardPoints =
    weapons.bigEmptyBays * 10 +
    weapons.bigMesonBays * 10 +
    weapons.bigPaBays * 10 +
    weapons.bigRepulsorBays * 10 +
    weapons.bigMissileBays * 10 +
    weapons.littleEmptyBays * 10 +
    weapons.littleMesonBays * 10 +
    weapons.littlePaBays * 10 +
    weapons.littleRepulsorBays * 10 +
    weapons.littleMissileBays * 10 +
    weapons.littleEnergyBays * 10 +
    turretHardPoints +
    userDef.items.reduce((sum, item) => sum + item.num * item.hp, 0)
  if (shipHardPoints - usedHardPoints < 0) {
    addIssue(51, legacyMessage(51))
  }
  if (weapons.mixedTurrets === 0 && design.tonnage > 1000) {
    addIssue(73, legacyMessage(73))
  }
  if (weapons.spinalType === 1 && weapons.bigMesonBays > 0) addIssue(74, legacyMessage(74))
  if (weapons.spinalType === 1 && weapons.littleMesonBays > 0) addIssue(75, legacyMessage(75))
  if (weapons.spinalType === 2 && weapons.bigPaBays > 0) addIssue(76, legacyMessage(76))
  if (weapons.spinalType === 2 && weapons.littlePaBays > 0) addIssue(77, legacyMessage(77))
  if (weapons.spinalType === 2 && weapons.paTurrets > 0) addIssue(78, legacyMessage(78))
  if (weapons.bigMesonBays > 0 && weapons.littleMesonBays > 0) addIssue(79, legacyMessage(79))
  if (weapons.bigPaBays > 0 && weapons.littlePaBays > 0) addIssue(80, legacyMessage(80))
  if (weapons.bigRepulsorBays > 0 && weapons.littleRepulsorBays > 0) addIssue(81, legacyMessage(81))
  if (weapons.bigMissileBays > 0 && weapons.littleMissileBays > 0) addIssue(82, legacyMessage(82))
  if (weapons.bigPaBays > 0 && weapons.paTurrets > 0) addIssue(83, legacyMessage(83))
  if (weapons.bigMissileBays > 0 && weapons.missileTurrets > 0) addIssue(84, legacyMessage(84))
  if (weapons.bigMissileBays > 0 && weapons.mixTurretMissiles > 0) addIssue(85, legacyMessage(85))
  if (weapons.littlePaBays > 0 && weapons.paTurrets > 0) addIssue(86, legacyMessage(86))
  if (weapons.littleMissileBays > 0 && weapons.missileTurrets > 0) addIssue(87, legacyMessage(87))
  if (weapons.bigMissileBays > 0 && weapons.mixTurretMissiles > 0) addIssue(88, legacyMessage(88))
  if (weapons.littleEnergyBays > 0 && weapons.energyTurrets > 0) addIssue(89, legacyMessage(89))

  const minJumpModel = minModelByJump(jDrive)
  if (compModel < minJumpModel) {
    const jumpCodeMap: Record<number, number> = { 1: 33, 2: 34, 3: 35, 4: 36, 5: 37, 6: 38 }
    const code = jumpCodeMap[jDrive] ?? 33
    addIssue(code, legacyMessage(code))
  }

  const minCompIndex = minComputerByTonnage(design.tonnage)
  if (mainComp < minCompIndex) {
    let code = 41
    if (design.tonnage >= 1_000_000) code = 48
    else if (design.tonnage >= 100_000) code = 47
    else if (design.tonnage >= 50_000) code = 46
    else if (design.tonnage >= 10_000) code = 45
    else if (design.tonnage >= 4_000) code = 44
    else if (design.tonnage >= 1_000) code = 43
    else if (design.tonnage >= 600) code = 42
    addIssue(code, legacyMessage(code))
  }

  if (design.tonnage < 100 && avionics.bridge === 1 && mainComp < 1) {
    addIssue(39, legacyMessage(39))
  }
  if (design.tonnage >= 100 && avionics.bridge === 1) {
    addIssue(40, legacyMessage(40))
  }

  if ((COMPUTER_TL[mainComp] ?? 99) > design.techLevel) {
    addIssue(49, legacyMessage(49))
  }
  if ((COMPUTER_TL[avionics.bakComp] ?? 99) > design.techLevel) {
    addIssue(50, legacyMessage(50))
  }

  if (design.tonnage < 100 && !SMALL_CRAFT_ALLOWED.has(mainComp)) {
    addIssue(107, legacyMessage(107))
  }
  if (design.tonnage < 100 && !SMALL_CRAFT_ALLOWED.has(avionics.bakComp)) {
    addIssue(108, legacyMessage(108))
  }

  const minFltAvi = minFlightAvionics(design.tonnage, hull)
  if (avionics.fltAvionics < minFltAvi) {
    addIssue(2001, `Flight avionics must be at least model ${minFltAvi}.`)
  }
  if (flightCompModel < avionics.fltAvionics) {
    addIssue(2002, 'Flight avionics model cannot exceed effective computer model.')
  }
  if (compModel < avionics.sensors) {
    addIssue(2003, 'Sensors model cannot exceed computer model.')
  }
  if (compModel < avionics.comms + avionics.commsType) {
    addIssue(2004, 'Comms model/type combination exceeds computer capability.')
  }

  return issues
}

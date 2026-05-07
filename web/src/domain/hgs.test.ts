import { describe, expect, it } from 'vitest'
import { parseHgsText, serializeHgsText } from './hgs'

describe('.hgs parse/serialize', () => {
  it('parses legacy-formatted core lines', () => {
    const text = [
      '20000',
      '"Ship","Class","Type","Arch","SC",12,5000.0000,2500.0000,1,1,1,0,0,0.0000,0,0,0,0,0,0,0',
      '3,2,0,1,0.0000,0,0',
      '4,3,7,1,0,0,2,1,1,300.0000,0.0000,1,1,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.000,0,0,0.000,0,0,0.000,1,0,0,0,0,0,0,0,0,0',
      '28,3,0,0,0,0,0.0000,0.0000,0,0,0,0,0,0.0000,0,0',
      '13,7,1,0,1,0,6,4,1,5,3,1,5,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0',
      '0,0,0.0000,0,0,0,0,0,0,0,0,0,0,0,0,0,0',
      '0,0,0,0,0,0,0,0,0',
      '0,0,0,0,0,0,0,0,0',
      '0,0,0,0,0,0,0,0,0',
      '0,0,0,0,0,0,0,0,0,0.0000',
      '0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0,0.0000,0,0.0000,0,0,0',
      '1,1,0,0,0,1.0,0.0,0,0,0,0.0000,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0000,0,0',
      '0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0,0',
      '0,0,0,1,0.0000,0,0,0,0',
      'Reserved for future expansion',
      'Reserved for future expansion',
      'Reserved for future expansion',
    ].join('\n')

    const parsed = parseHgsText(text)
    expect(parsed.design.shipName).toBe('Ship')
    expect(parsed.design.techLevel).toBe(12)
    expect(parsed.engine.mDrive).toBe(4)
    expect(parsed.engine.bakMDriveNum).toBe(2)
    expect(parsed.fuel.pFuel).toBe(28)
    expect(parsed.avionics.mainComp).toBe(13)
    expect(parsed.weapons.spinalType).toBe(0)
    expect(parsed.screens.nucDamp).toBe(0)
    expect(parsed.legacyOptions?.chargeForHardpoints).toBe(false)
    expect(parsed.engine.milStdJump).toBe(true)
    expect(parsed.engine.upgradeSpace).toBe(1)
  })

  it('parses legacy options row (line index 14) and syncs MilStd jump from options token', () => {
    const lines = [
      '20000',
      '"Ship","Class","Type","Arch","SC",12,5000.0000,2500.0000,1,1,1,0,0,0.0000,0,0,0,0,0,0,0',
      '3,2,0,1,0.0000,0,0',
      '4,3,7,1,0,0,2,1,1,300.0000,0.0000,1,1,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.000,0,0,0.000,0,0,0.000,0,0,0,0,0,0,0,0,0,0',
      '28,3,0,0,0,0,0.0000,0.0000,0,0,0,0,0,0.0000,0,0',
      '13,7,1,0,1,0,6,4,1,5,3,1,5,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0',
      '0,0,0.0000,0,0,0,0,0,0,0,0,0,0,0,0,0,0',
      '0,0,0,0,0,0,0,0,0',
      '0,0,0,0,0,0,0,0,0',
      '0,0,0,0,0,0,0,0,0',
      '0,0,0,0,0,0,0,0,0,0.0000',
      '0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0.0000,"None",0,0,0.0000,0,0,0.0000,0,0.0000,0,0,0',
      '1,1,0,0,0,1.0,0.0,0,0,0,0.0000,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0000,0,0',
      '0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0.0000,"None",0,0.0000,0.0000,0,0,0,0,0,0,0',
      '1,1,1,1,3.1415,5,6,7,8',
      'Reserved for future expansion',
      'Reserved for future expansion',
      'Reserved for future expansion',
    ]
    const parsed = parseHgsText(lines.join('\n'))
    expect(parsed.legacyOptions?.chargeForHardpoints).toBe(true)
    expect(parsed.legacyOptions?.autoCalcAccom).toBe(true)
    expect(parsed.legacyOptions?.optPowerTon).toBe(true)
    expect(parsed.legacyOptions?.milStdMod).toBeCloseTo(3.1415, 4)
    expect(parsed.engine.milStdJump).toBe(true)
    parsed.engine.milStdJump = false
    const out = serializeHgsText(parsed)
    expect(out.split('\n')[14]).toContain('0')
    expect(out.split('\n')[14]).toContain('3.1415')
  })

  it('serializes while preserving untouched legacy lines', () => {
    const parsed = parseHgsText(
      [
        '20000',
        '"Ship","Class","Type","Arch","SC",12,5000.0000,2500.0000,1,1,1,0,0,0.0000,0,0,0,0,0,0,0',
        '3,2,0,1,0.0000,0,0',
        '4,3,7,1,0,0,2,1,1,300.0000,0.0000,1,1,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.000,0,0,0.000,0,0,0.000,1,0,0,0,0,0,0,0,0,0',
        '28,3,0,0,0,0,0.0000,0.0000,0,0,0,0,0,0.0000,0,0',
        '13,7,1,0,1,0,6,4,1,5,3,1,5,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0',
        'x',
        'y',
        'z',
        'a',
        'b',
        'c',
        'd',
        'e',
        'f',
        'keep-this-line',
      ].join('\n'),
    )
    parsed.design.shipName = 'Renamed'
    parsed.engine.newJDrive = 6
    parsed.engine.jDriveIsRefitted = true
    parsed.weapons.spinalType = 2
    parsed.weapons.spinalMount = 3
    parsed.screens.nucDamp = 2
    const out = serializeHgsText(parsed)
    const lines = out.split('\n')
    expect(lines[1]).toContain('Renamed,Class')
    expect(lines[3]).toContain(',1,6,')
    expect(lines[6]).toContain('2,3')
    expect(lines[10]).toContain('2,')
    expect(lines[15]).toBe('keep-this-line')
  })

  it('maps trailing .hgs comments to notes and writes them back', () => {
    const parsed = parseHgsText(
      [
        '20000',
        '"Ship","Class","Type","Arch","SC",12,5000.0000,2500.0000,1,1,1,0,0,0.0000,0,0,0,0,0,0,0',
        '3,2,0,1,0.0000,0,0',
        '4,3,7,1,0,0,2,1,1,300.0000,0.0000,1,1,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.000,0,0,0.000,0,0,0.000,1,0,0,0,0,0,0,0,0,0',
        '28,3,0,0,0,0,0.0000,0.0000,0,0,0,0,0,0.0000,0,0',
        '13,7,1,0,1,0,6,4,1,5,3,1,5,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0',
        'x',
        'y',
        'z',
        'a',
        'b',
        'c',
        'd',
        'e',
        'f',
        'legacy comment one',
        'legacy comment two',
      ].join('\n'),
    )
    expect(parsed.design.notes).toContain('legacy comment one')
    parsed.design.notes = 'updated note A\nupdated note B'
    const out = serializeHgsText(parsed)
    const lines = out.split('\n')
    expect(lines[15]).toBe('updated note A')
    expect(lines[16]).toBe('updated note B')
  })

  it('round-trips crew rules and flagship via ship header', () => {
    const parsed = parseHgsText(
      [
        '20000',
        '"Ship","Class","Type","Arch","SC",12,5000.0000,2500.0000,1,0,1,0,0,0.0000,2,1,0,0,0,0,0',
        '3,2,0,1,0.0000,0,0',
        '4,3,7,1,0,0,2,1,1,300.0000,0.0000,1,1,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.000,0,0,0.000,0,0,0.000,1,0,0,0,0,0,0,0,0,0',
        '28,3,0,0,0,0,0.0000,0.0000,0,0,0,0,0,0.0000,0,0',
        '13,7,1,0,1,0,6,4,1,5,3,1,5,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0',
        'x',
        'y',
        'z',
        'a',
        'b',
        'c',
        'd',
        'e',
        'f',
        'Reserved for future expansion',
        'Reserved for future expansion',
        'Reserved for future expansion',
      ].join('\n'),
    )
    expect(parsed.accom.crewRules).toBe(0)
    expect(parsed.accom.alternateCrewRules).toBe(2)
    expect(parsed.accom.flagship).toBe(true)

    parsed.accom.crewRules = 1
    parsed.accom.alternateCrewRules = 3
    parsed.accom.flagship = false
    const out = serializeHgsText(parsed)
    const ship = out.split('\n')[1].split(',')
    expect(ship[9]).toBe('1')
    expect(ship[14]).toBe('3')
    expect(ship[15]).toBe('0')
  })
})


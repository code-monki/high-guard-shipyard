import { readFileSync } from 'node:fs'
import { resolve } from 'node:path'
import { fileURLToPath } from 'node:url'
import { describe, expect, it } from 'vitest'
import { parseHgsText, serializeHgsText } from './hgs'

const THIS_DIR = fileURLToPath(new URL('.', import.meta.url))
const samplePath = (name: string): string =>
  resolve(THIS_DIR, '../../../archive/original-lazarus/src', name)

describe('.hgs legacy sample compatibility', () => {
  it('is semantically stable for Noble.hgs when no mapped values change', () => {
    const source = readFileSync(samplePath('Noble.hgs'), 'utf8')
    const parsed = parseHgsText(source)
    const output = serializeHgsText(parsed)
    const reparsed = parseHgsText(output)
    expect(reparsed.design.shipName).toBe(parsed.design.shipName)
    expect(reparsed.design.shipClass).toBe(parsed.design.shipClass)
    expect(reparsed.design.tonnage).toBe(parsed.design.tonnage)
    expect(reparsed.engine.mDrive).toBe(parsed.engine.mDrive)
    expect(reparsed.engine.jDrive).toBe(parsed.engine.jDrive)
    expect(reparsed.avionics.mainComp).toBe(parsed.avionics.mainComp)
  })

  it('is semantically stable for Kuniko Inoguchi.hgs when no mapped values change', () => {
    const source = readFileSync(samplePath('Kuniko Inoguchi.hgs'), 'utf8')
    const parsed = parseHgsText(source)
    const output = serializeHgsText(parsed)
    const reparsed = parseHgsText(output)
    expect(reparsed.design.shipName).toBe(parsed.design.shipName)
    expect(reparsed.design.shipClass).toBe(parsed.design.shipClass)
    expect(reparsed.design.tonnage).toBe(parsed.design.tonnage)
    expect(reparsed.engine.mDrive).toBe(parsed.engine.mDrive)
    expect(reparsed.engine.jDrive).toBe(parsed.engine.jDrive)
    expect(reparsed.avionics.mainComp).toBe(parsed.avionics.mainComp)
  })

  it('parses Noble.hgs and preserves trailing legacy lines on export', () => {
    const source = readFileSync(samplePath('Noble.hgs'), 'utf8')
    const parsed = parseHgsText(source)

    expect(parsed.design.shipName).toBe('Norman')
    expect(parsed.design.shipClass).toBe('Noble')
    expect(parsed.design.tonnage).toBe(2000)
    expect(parsed.hull.config).toBe(2)
    expect(parsed.engine.mDrive).toBe(6)
    expect(parsed.fuel.pFuel).toBe(28)

    const output = serializeHgsText(parsed)
    const sourceLines = source.replace(/\r\n/g, '\n').split('\n').filter((l: string) => l.length > 0)
    const outputLines = output.replace(/\r\n/g, '\n').split('\n')

    // Keep trailing lines (comments/reserved extension region) untouched.
    expect(outputLines.slice(15)).toEqual(sourceLines.slice(15))

    // Round-trip mapped state should remain stable.
    const reparsed = parseHgsText(output)
    expect(reparsed.design.shipName).toBe(parsed.design.shipName)
    expect(reparsed.design.tonnage).toBe(parsed.design.tonnage)
    expect(reparsed.engine.mDrive).toBe(parsed.engine.mDrive)
    expect(reparsed.avionics.mainComp).toBe(parsed.avionics.mainComp)
  })

  it('parses Kuniko Inoguchi.hgs with expected mapped values', () => {
    const source = readFileSync(samplePath('Kuniko Inoguchi.hgs'), 'utf8')
    const parsed = parseHgsText(source)

    expect(parsed.design.shipClass).toBe('Kuniko Inoguchi')
    expect(parsed.design.tonnage).toBe(100)
    expect(parsed.engine.jDrive).toBe(1)
    expect(parsed.avionics.mainComp).toBe(4)
    expect(parsed.accom.stRoom).toBe(2)
  })
})


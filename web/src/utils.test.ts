import { describe, expect, it } from 'vitest'
import { fuelDaysToWeeks, fuelWeeksToDays } from './utils'

describe('fuel unit conversions', () => {
  it('converts displayed weeks to persisted days', () => {
    expect(fuelWeeksToDays(4)).toBe(28)
  })

  it('converts persisted days to displayed weeks', () => {
    expect(fuelDaysToWeeks(28)).toBe(4)
  })
})

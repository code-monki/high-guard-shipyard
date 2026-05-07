import { describe, expect, it } from 'vitest'
import { readFileSync } from 'node:fs'
import { dirname, resolve } from 'node:path'
import { fileURLToPath } from 'node:url'

type ThemeName = 'light' | 'dark' | 'sepia'

const currentDir = dirname(fileURLToPath(import.meta.url))
const css = readFileSync(resolve(currentDir, 'style.css'), 'utf8')

const extractBlock = (selector: string): string => {
  const escaped = selector.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')
  const match = css.match(new RegExp(`${escaped}\\s*\\{([\\s\\S]*?)\\}`, 'm'))
  if (!match) throw new Error(`Missing CSS block: ${selector}`)
  return match[1]
}

const parseVars = (block: string): Record<string, string> => {
  const vars: Record<string, string> = {}
  for (const line of block.split('\n')) {
    const trimmed = line.trim()
    if (!trimmed.startsWith('--')) continue
    const [name, value] = trimmed.split(':').map((part) => part.trim())
    if (!name || !value) continue
    vars[name] = value.replace(/;$/, '')
  }
  return vars
}

const toRgb = (hex: string): [number, number, number] => {
  const value = hex.trim().replace('#', '')
  if (!/^[0-9a-fA-F]{6}$/.test(value)) {
    throw new Error(`Expected 6-digit hex color, got: ${hex}`)
  }
  return [
    Number.parseInt(value.slice(0, 2), 16),
    Number.parseInt(value.slice(2, 4), 16),
    Number.parseInt(value.slice(4, 6), 16),
  ]
}

const linearize = (channel: number): number => {
  const srgb = channel / 255
  return srgb <= 0.03928 ? srgb / 12.92 : ((srgb + 0.055) / 1.055) ** 2.4
}

const luminance = (hex: string): number => {
  const [r, g, b] = toRgb(hex)
  return 0.2126 * linearize(r) + 0.7152 * linearize(g) + 0.0722 * linearize(b)
}

const contrastRatio = (fgHex: string, bgHex: string): number => {
  const fg = luminance(fgHex)
  const bg = luminance(bgHex)
  const lighter = Math.max(fg, bg)
  const darker = Math.min(fg, bg)
  return (lighter + 0.05) / (darker + 0.05)
}

const rootVars = parseVars(extractBlock(':root'))
const darkVars = parseVars(extractBlock("[data-theme='dark']"))
const sepiaVars = parseVars(extractBlock("[data-theme='sepia']"))

const varsByTheme: Record<ThemeName, Record<string, string>> = {
  light: rootVars,
  dark: { ...rootVars, ...darkVars },
  sepia: { ...rootVars, ...sepiaVars },
}

const aaPairs: Array<[string, string]> = [
  ['--color-text-primary', '--color-surface'],
  ['--color-text-secondary', '--color-surface'],
  ['--color-text-primary', '--color-bg-page'],
  ['--color-nav-active-fg', '--color-nav-active-bg'],
  ['--color-results-head-text', '--color-results-head-bg'],
  ['--color-danger', '--color-surface'],
]

describe('theme token contrast ratios', () => {
  for (const [theme, vars] of Object.entries(varsByTheme) as Array<[ThemeName, Record<string, string>]>) {
    it(`${theme} theme passes WCAG AA for key text pairs`, () => {
      for (const [fgToken, bgToken] of aaPairs) {
        const fg = vars[fgToken]
        const bg = vars[bgToken]
        expect(fg, `Missing token ${fgToken} for ${theme}`).toBeTypeOf('string')
        expect(bg, `Missing token ${bgToken} for ${theme}`).toBeTypeOf('string')
        expect(contrastRatio(fg, bg), `${theme} ${fgToken} on ${bgToken}`).toBeGreaterThanOrEqual(4.5)
      }
    })
  }
})

/* utils.ts — Shared display-formatting helpers used throughout templates and the Results panel. */

/** Formats a number to up to 3 decimal places, trimming trailing zeros. */
export const format = (value: number): string => value.toFixed(3).replace(/\.?0+$/, '')

/** Formats a number to up to 4 decimal places (MilStd modifier precision), trimming trailing zeros. */
export const formatMStd = (value: number): string => value.toFixed(4).replace(/\.?0+$/, '')

/** Returns "Yes" or "No" for a boolean value. */
export const boolLabel = (value: boolean): string => (value ? 'Yes' : 'No')

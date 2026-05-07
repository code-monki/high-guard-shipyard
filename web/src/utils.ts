export const format = (value: number): string => value.toFixed(3).replace(/\.?0+$/, '')
export const formatMStd = (value: number): string => value.toFixed(4).replace(/\.?0+$/, '')
export const boolLabel = (value: boolean): string => (value ? 'Yes' : 'No')

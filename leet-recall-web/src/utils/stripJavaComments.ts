/** Remove Java comments for the dictation display while preserving line structure and literals. */
export function stripJavaComments(code: string): string {
  const output: string[] = []
  let quote: '"' | "'" | null = null
  let inTextBlock = false

  for (let index = 0; index < code.length;) {
    const current = code[index] ?? ''
    const next = code[index + 1] ?? ''

    if (quote) {
      output.push(current)
      if (current === '\\' && index + 1 < code.length) {
        output.push(next)
        index += 2
        continue
      }
      if (current === quote) quote = null
      index += 1
      continue
    }

    if (inTextBlock) {
      if (code.startsWith('"""', index)) {
        output.push('"""')
        index += 3
        inTextBlock = false
      } else if (current === '\\' && index + 1 < code.length) {
        output.push(current, next)
        index += 2
      } else {
        output.push(current)
        index += 1
      }
      continue
    }

    if (code.startsWith('"""', index)) {
      output.push('"""')
      index += 3
      inTextBlock = true
      continue
    }

    if (current === '"' || current === "'") {
      quote = current
      output.push(current)
      index += 1
      continue
    }

    if (current === '/' && next === '/') {
      index += 2
      while (index < code.length && code[index] !== '\n' && code[index] !== '\r') index += 1
      continue
    }

    if (current === '/' && next === '*') {
      index += 2
      while (index < code.length && !(code[index] === '*' && code[index + 1] === '/')) {
        const character = code[index] ?? ''
        if (character === '\n' || character === '\r') output.push(character)
        index += 1
      }
      if (index < code.length) index += 2
      const previous = output[output.length - 1] ?? ''
      const following = code[index] ?? ''
      if (previous && following && !/\s/.test(previous) && !/\s/.test(following)) output.push(' ')
      continue
    }

    output.push(current)
    index += 1
  }

  return output.join('')
}

import { describe, expect, it } from 'vitest'
import { stripJavaComments } from '@/utils/stripJavaComments'

describe('stripJavaComments', () => {
  it('removes line and block comments without changing line breaks', () => {
    const code = 'int left = 0; // skip this\n/* keep line structure\n   but remove text */ return left;'

    expect(stripJavaComments(code)).toBe('int left = 0; \n\n return left;')
  })

  it('preserves comment markers inside strings, chars, and Java text blocks', () => {
    const code = [
      'String url = "https://example.com/a/*b*/"; // remove this',
      "char slash = '/'; char star = '*'; /* remove this */",
      'String notes = """',
      '// keep this',
      '/* keep this too */',
      '"""; // remove this',
    ].join('\n')
    const expected = [
      'String url = "https://example.com/a/*b*/"; ',
      "char slash = '/'; char star = '*'; ",
      'String notes = """',
      '// keep this',
      '/* keep this too */',
      '"""; ',
    ].join('\n')

    expect(stripJavaComments(code)).toBe(expected)
  })
})

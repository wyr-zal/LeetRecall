import type { LocationQuery, RouteLocationNormalizedLoaded } from 'vue-router'

export const WORKSPACE_SECTIONS = ['description', 'notes', 'recall', 'dictation', 'solution'] as const
export type WorkspaceSection = (typeof WORKSPACE_SECTIONS)[number]
export interface WorkspaceLocation {
  leetcodeNumber: number | null
  section: WorkspaceSection
  answer: boolean
}

type Location = Pick<RouteLocationNormalizedLoaded, 'params' | 'query'>

export function readWorkspaceLocation(location: Location, fallback: WorkspaceSection = 'notes'): WorkspaceLocation {
  const { params, query } = location
  if (params.pathMatch !== undefined) throw new Error('链接中的页面不存在。')
  const pathNumber = params.leetcodeNumber || undefined
  const rawNumber = pathNumber ?? query.problem
  let leetcodeNumber: number | null = null
  if (rawNumber !== undefined) {
    if (typeof rawNumber !== 'string' || !/^[1-9]\d*$/.test(rawNumber) || !Number.isSafeInteger(Number(rawNumber))) {
      throw new Error('链接中的 LeetCode 题号无效。')
    }
    leetcodeNumber = Number(rawNumber)
  }
  const pathSection = params.section || undefined
  const rawSection = pathSection ?? (pathNumber ? 'description' : query.panel ?? fallback)
  if (Array.isArray(rawSection) || (pathSection && !WORKSPACE_SECTIONS.includes(pathSection as WorkspaceSection))) {
    throw new Error('链接中的页面不存在。')
  }
  const section = WORKSPACE_SECTIONS.includes(rawSection as WorkspaceSection) ? rawSection as WorkspaceSection : fallback
  if (Array.isArray(query.answer)) throw new Error('链接中的答案状态无效。')
  return { leetcodeNumber, section, answer: section === 'recall' && query.answer === '1' }
}

export function workspaceTarget(leetcodeNumber: number, section: WorkspaceSection, currentQuery: LocationQuery = {}) {
  const query = { ...currentQuery }
  delete query.problem
  delete query.panel
  if (section !== 'recall' || query.answer !== '1') delete query.answer
  return { path: `/problems/${leetcodeNumber}/${section}`, query }
}

import { readWorkspaceLocation, workspaceTarget } from '../workspaceLocation'

function location(params = {}, query = {}) {
  return { params, query }
}

describe('可分享工作台地址', () => {
  it('读取路径中的 LeetCode 题号及完整代码状态', () => {
    expect(readWorkspaceLocation(location({ leetcodeNumber: '5', section: 'solution' })))
      .toEqual({ leetcodeNumber: 5, section: 'solution', answer: false })
  })

  it('路径优先于旧 query，旧入口仍可指定题目和面板', () => {
    expect(readWorkspaceLocation(location({ leetcodeNumber: '5', section: 'notes' }, { problem: '49', panel: 'dictation' })))
      .toEqual({ leetcodeNumber: 5, section: 'notes', answer: false })
    expect(readWorkspaceLocation(location({}, { problem: '5', panel: 'recall', answer: '1' })))
      .toEqual({ leetcodeNumber: 5, section: 'recall', answer: true })
  })

  it('无题号留给本地回退，有题号无 section 默认题面', () => {
    expect(readWorkspaceLocation(location(), 'notes').leetcodeNumber).toBeNull()
    expect(readWorkspaceLocation(location({ leetcodeNumber: '5' }), 'notes').section).toBe('description')
  })

  it.each(['0', '-1', '1.5', '5x', '1e2', '9007199254740992', ['5', '49']])('拒绝非法题号 %j', (leetcodeNumber) => {
    expect(() => readWorkspaceLocation(location({ leetcodeNumber, section: 'notes' }))).toThrow()
  })

  it('拒绝未知路径内容与重复旧参数', () => {
    expect(() => readWorkspaceLocation(location({ leetcodeNumber: '5', section: 'oops' }))).toThrow()
    expect(() => readWorkspaceLocation(location({}, { problem: ['5', '49'] }))).toThrow()
    expect(() => readWorkspaceLocation(location({ pathMatch: ['5', 'notes', 'extra'] }))).toThrow()
  })

  it('生成路径只消费定位参数，不吞抽屉参数，不传播会话', () => {
    expect(workspaceTarget(5, 'solution', { problem: '49', panel: 'dictation', answer: '1', import: '1' }))
      .toEqual({ path: '/problems/5/solution', query: { import: '1' } })
    expect(workspaceTarget(5, 'recall', { answer: '1', picker: '1' }))
      .toEqual({ path: '/problems/5/recall', query: { answer: '1', picker: '1' } })
  })
})

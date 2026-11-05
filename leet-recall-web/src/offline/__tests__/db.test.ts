import 'fake-indexeddb/auto'
import {
  PENDING_ANSWER_VIEW_KEY,
  clearOfflineData,
  readAllProblems,
  readMeta,
  readProblem,
  readQueueSnapshot,
  replacePack,
  searchOfflineProblems,
  updateProblem,
  writeQueueSnapshot,
} from '@/offline/db'
import { createMeta, createPack, createProblem } from '@/tests/offlineFixtures'

describe('offline db', () => {
  beforeEach(async () => {
    await clearOfflineData()
  })

  it('写入资料包时同步保存题目与元数据', async () => {
    await replacePack(
      createPack([createProblem(1, '两数之和'), createProblem(2, '两数相加')]),
      createMeta(2),
    )

    expect((await readAllProblems()).map((problem) => problem.problemId).sort()).toEqual([1, 2])
    expect((await readMeta())?.problemCount).toBe(2)
  })

  it('整包替换而不是合并，旧题目不会残留', async () => {
    await replacePack(createPack([createProblem(1, '两数之和')]), createMeta(1))
    await replacePack(createPack([createProblem(3, '无重复字符的最长子串')]), createMeta(1, '"pack-v2"'))

    expect((await readAllProblems()).map((problem) => problem.problemId)).toEqual([3])
    expect(await readProblem(1)).toBeNull()
    expect((await readMeta())?.etag).toBe('"pack-v2"')
  })

  it('清除离线资料时保留待补记的答案查看记录', async () => {
    await replacePack(createPack([createProblem(1, '两数之和')]), createMeta(1))
    await writeQueueSnapshot(PENDING_ANSWER_VIEW_KEY, [1])

    await clearOfflineData()

    expect(await readAllProblems()).toEqual([])
    expect(await readMeta()).toBeNull()
    expect((await readQueueSnapshot<number[]>(PENDING_ANSWER_VIEW_KEY))?.data).toEqual([1])
  })

  it('不为不在资料包中的题目写入局部记录', async () => {
    await updateProblem(999, () => ({ title: '不应写入' }))

    expect(await readProblem(999)).toBeNull()
  })

  it('按标题或题号搜索，结果按 Hot100 顺序排列', async () => {
    await replacePack(
      createPack([
        createProblem(236, '二叉树的最近公共祖先'),
        createProblem(2, '两数相加'),
        createProblem(1, '两数之和'),
      ]),
      createMeta(3),
    )

    expect((await searchOfflineProblems('两数')).map((item) => item.problemId)).toEqual([1, 2])
    expect((await searchOfflineProblems('2')).map((item) => item.problemId)).toEqual([2, 236])
    expect(await searchOfflineProblems('   ')).toEqual([])
  })
})

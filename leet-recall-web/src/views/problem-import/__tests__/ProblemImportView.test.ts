import { flushPromises, mount } from '@vue/test-utils'
import { problemImportApi } from '@/api/problemImport'
import ProblemImportView from '@/views/problem-import/ProblemImportView.vue'
import type { ExternalImportTaskPack, Hot100Manifest } from '@/types/import'

const manifest: Hot100Manifest = {
  sourceStudyPlanUrl: 'https://leetcode.cn/studyplan/top-100-liked/',
  sourceVersion: 'test',
  generatedAt: '2026-08-13T00:00:00Z',
  problems: [{
    order: 1,
    group: '哈希',
    leetcodeNumber: 1,
    slug: 'two-sum',
    title: '两数之和',
    englishTitle: 'Two Sum',
    difficulty: 'EASY',
    problemUrl: 'https://leetcode.cn/problems/two-sum/',
  }],
}

const task: ExternalImportTaskPack = {
  leetcodeNumber: 1,
  title: '两数之和',
  difficulty: 'EASY',
  problemUrl: 'https://leetcode.cn/problems/two-sum/',
  descriptionMarkdown: '题面',
  javaStarterCode: 'class Solution {}',
  instructionMarkdown: '任务说明',
  exampleJson: '{"leetcodeNumber":1}',
}

const invalidDraft = {
  id: 1,
  status: 'INVALID' as const,
  leetcodeNumber: 1,
  validationErrors: ['只接受纯 JSON 对象，不能包含 Markdown 代码围栏或说明文字'],
  compilePassed: false,
  impact: { overwriteExisting: false, preserved: [], replaced: [], requiresConfirmation: false },
  createdAt: '2026-08-13T00:00:00Z',
  updatedAt: '2026-08-13T00:00:00Z',
}

function createFile(name: string, content: string, type = 'application/json'): File {
  const file = new File([content], name, { type })
  Object.defineProperty(file, 'text', { configurable: true, value: vi.fn().mockResolvedValue(content) })
  return file
}

async function selectFirstProblem(wrapper: ReturnType<typeof mount>): Promise<void> {
  await wrapper.get('#hot100-search').setValue('两数之和')
  await wrapper.get('.search-result').trigger('click')
  await flushPromises()
}

async function chooseFile(wrapper: ReturnType<typeof mount>, file: File): Promise<void> {
  const input = wrapper.get('[data-test="json-file-input"]')
  Object.defineProperty(input.element, 'files', { configurable: true, value: [file] })
  await input.trigger('change')
  await flushPromises()
}

describe('ProblemImportView', () => {
  beforeEach(() => {
    vi.spyOn(problemImportApi, 'getHot100Manifest').mockResolvedValue(manifest)
    vi.spyOn(problemImportApi, 'getExternalImportTask').mockResolvedValue(task)
  })

  afterEach(() => vi.restoreAllMocks())

  it('keeps task preview collapsed by default and provides a local JSON file picker', async () => {
    const wrapper = mount(ProblemImportView, {
      global: { stubs: { MarkdownContent: true, ConfirmDialog: true } },
    })
    await flushPromises()
    await selectFirstProblem(wrapper)

    expect(wrapper.get('details.preview').attributes('open')).toBeUndefined()
    expect(wrapper.get('details.format-help').attributes('open')).toBeUndefined()
    expect(wrapper.get('[data-test="json-file-input"]').attributes('accept')).toBe('.json,application/json')
    expect(wrapper.get('[data-test="json-file-picker"]').text()).toContain('选择 JSON 文件')
    expect(wrapper.get('details.preview pre').text()).toContain('完整导入规则（必须遵守）')
    expect(wrapper.get('details.preview pre').text()).toContain('至少有 1 个唯一 `{{blank_n}}`')
    expect(wrapper.get('details.preview pre').text()).toContain('额外字段不会阻断')
  })

  it('reads a selected JSON file locally and replaces the pasted JSON without submitting it', async () => {
    const createDraft = vi.spyOn(problemImportApi, 'createExternalDraft')
    const wrapper = mount(ProblemImportView, {
      global: { stubs: { MarkdownContent: true, ConfirmDialog: true } },
    })
    await flushPromises()
    await selectFirstProblem(wrapper)

    const editor = wrapper.get('textarea.json-editor')
    await editor.setValue('{"previous":true}')
    await chooseFile(wrapper, createFile('two-sum.json', '{"fromFile":true}'))

    expect((wrapper.get('textarea.json-editor').element as HTMLTextAreaElement).value).toBe('{"fromFile":true}')
    expect(wrapper.get('.section-heading .primary').text()).toContain('保存并校验')
    expect(createDraft).not.toHaveBeenCalled()
  })

  it('submits non-empty malformed content for server-side validation instead of silently disabling the button', async () => {
    const createDraft = vi.spyOn(problemImportApi, 'createExternalDraft').mockResolvedValue(invalidDraft)
    const wrapper = mount(ProblemImportView, {
      global: { stubs: { MarkdownContent: true, ConfirmDialog: true } },
    })
    await flushPromises()
    await selectFirstProblem(wrapper)

    await wrapper.get('textarea.json-editor').setValue('```json\n{}\n```')
    const validateButton = wrapper.get('.section-heading .primary')
    expect(validateButton.attributes('disabled')).toBeUndefined()
    await validateButton.trigger('click')
    await flushPromises()

    expect(createDraft).toHaveBeenCalledWith({ hot100Number: 1, content: '```json\n{}\n```' })
    expect(wrapper.text()).toContain('只接受纯 JSON 对象，不能包含 Markdown 代码围栏或说明文字')
  })

  it.each([
    ['非 JSON 文件', createFile('two-sum.txt', '{}', 'text/plain'), '仅支持选择 .json 文件或 application/json 类型文件。'],
    ['空 JSON 文件', createFile('empty.json', ''), 'JSON 文件不能为空。'],
    ['超限 JSON 文件', createFile('large.json', 'x'.repeat(200_001)), 'JSON 文件不能超过 200 KB。'],
  ])('rejects %s before any validation request', async (_label, file, expectedError) => {
    const createDraft = vi.spyOn(problemImportApi, 'createExternalDraft')
    const wrapper = mount(ProblemImportView, {
      global: { stubs: { MarkdownContent: true, ConfirmDialog: true } },
    })
    await flushPromises()
    await selectFirstProblem(wrapper)

    await chooseFile(wrapper, file)

    expect(wrapper.text()).toContain(expectedError)
    expect(createDraft).not.toHaveBeenCalled()
  })

  it('shows a read error when the browser cannot read the selected JSON file', async () => {
    const file = createFile('broken.json', '{"value":true}')
    Object.defineProperty(file, 'text', { value: vi.fn().mockRejectedValue(new Error('read failed')) })
    const wrapper = mount(ProblemImportView, {
      global: { stubs: { MarkdownContent: true, ConfirmDialog: true } },
    })
    await flushPromises()
    await selectFirstProblem(wrapper)

    await chooseFile(wrapper, file)

    expect(wrapper.text()).toContain('JSON 文件读取失败，请重新选择。')
  })
})

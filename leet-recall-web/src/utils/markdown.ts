import MarkdownIt from 'markdown-it'

const renderer = new MarkdownIt({
  html: false,
  breaks: true,
  linkify: true,
  typographer: false,
})

export function renderMarkdown(markdown: string): string {
  return renderer.render(markdown)
}

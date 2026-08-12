export interface ApiResponse<T> {
  code: number
  message: string
  data: T
}

export interface PageResult<T> {
  page: number
  pageSize: number
  total: number
  items: T[]
}


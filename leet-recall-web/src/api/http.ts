import axios, { AxiosError } from 'axios'
import type { ApiResponse } from '@/types/api'

export class ApiError extends Error {
  constructor(
    message: string,
    public readonly code?: number,
  ) {
    super(message)
    this.name = 'ApiError'
  }
}

export const http = axios.create({
  baseURL: '/api',
  timeout: 12_000,
  headers: {
    'Content-Type': 'application/json',
  },
})

http.interceptors.response.use(
  (response) => response,
  (error: AxiosError<ApiResponse<unknown>>) => {
    const message = error.response?.data?.message || (error.code === 'ECONNABORTED'
      ? '请求超时，请重试'
      : '加载失败，请重试')
    return Promise.reject(new ApiError(message, error.response?.data?.code))
  },
)

export async function unwrap<T>(request: Promise<{ data: ApiResponse<T> }>): Promise<T> {
  const response = await request
  if (response.data.code !== 0) {
    throw new ApiError(response.data.message, response.data.code)
  }
  return response.data.data
}


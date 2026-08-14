import { createRouter, createWebHistory } from 'vue-router'
import AppLayout from '@/layouts/AppLayout.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: '/', redirect: '/quick-review' },
    {
      path: '/',
      component: AppLayout,
      children: [
        {
          path: 'quick-review',
          meta: { keepAlive: true },
          component: () => import('@/views/quick-review/QuickReviewView.vue'),
        },
        {
          path: 'dictation',
          meta: { keepAlive: true },
          component: () => import('@/views/dictation/DictationView.vue'),
        },
        {
          path: 'problem-import',
          component: () => import('@/views/problem-import/ProblemImportView.vue'),
        },
        {
          path: 'settings',
          component: () => import('@/views/settings/SettingsView.vue'),
        },
      ],
    },
    { path: '/:pathMatch(.*)*', redirect: '/quick-review' },
  ],
})

export default router

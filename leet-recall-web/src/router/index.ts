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
          component: () => import('@/views/quick-review/QuickReviewView.vue'),
        },
        {
          path: 'dictation',
          redirect: (to) => ({ path: '/quick-review', query: { ...to.query, panel: 'dictation' } }),
        },
        {
          path: 'problem-import',
          redirect: (to) => ({ path: '/quick-review', query: { ...to.query, import: '1' } }),
        },
        {
          path: 'settings',
          redirect: (to) => ({ path: '/quick-review', query: { ...to.query, settings: '1' } }),
        },
      ],
    },
    { path: '/:pathMatch(.*)*', redirect: '/quick-review' },
  ],
})

export default router

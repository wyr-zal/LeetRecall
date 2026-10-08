import { createRouter, createWebHistory } from 'vue-router'
import AppLayout from '@/layouts/AppLayout.vue'

const workspace = () => import('@/views/quick-review/QuickReviewView.vue')
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: '/', redirect: to => ({ path: '/problems', query: to.query }) },
    {
      path: '/',
      component: AppLayout,
      children: [
        { path: 'problems/:leetcodeNumber?/:section?', name: 'workspace', component: workspace, meta: { workspace: true } },
        { path: 'problems/:pathMatch(.*)*', component: workspace, meta: { workspace: true } },
        { path: 'quick-review', redirect: to => ({ path: '/problems', query: to.query }) },
        { path: 'dictation', redirect: to => ({ path: '/problems', query: { ...to.query, panel: 'dictation' } }) },
        { path: 'problem-import', redirect: to => ({ path: '/problems', query: { ...to.query, import: '1' } }) },
        { path: 'settings', redirect: to => ({ path: '/problems', query: { ...to.query, settings: '1' } }) },
      ],
    },
    { path: '/:pathMatch(.*)*', redirect: '/problems' },
  ],
})

export default router

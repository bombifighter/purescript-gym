import { createRouter, createWebHistory } from 'vue-router'
import HomePage from './pages/HomePage.vue'
import GuestsPage from './pages/GuestsPage.vue'
import LockersPage from './pages/LockersPage.vue'
import DashboardPage from './pages/DashboardPage.vue'
import GuestDetailPage from './pages/GuestDetailPage.vue'


const router = createRouter({
    history: createWebHistory(),
    routes: [
        { path: '/', component: HomePage },
        { path: '/dashboard', component: DashboardPage },
        { path: '/guests', component: GuestsPage },
        { path: '/lockers', component: LockersPage },
        { path: '/guests/details/:id', component: GuestDetailPage }
    ]
});

export default router;
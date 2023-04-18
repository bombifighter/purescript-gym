import { createRouter, createWebHistory } from 'vue-router'
import HomePage from './pages/HomePage.vue'
import GuestsPage from './pages/GuestsPage.vue'
import LockersPage from './pages/LockersPage.vue'
import DashboardPage from './pages/DashboardPage.vue'
import GuestDetailPage from './pages/GuestDetailPage.vue'
import NewGuestPage from './pages/NewGuestPage.vue'
import GuestMembershipPage from './pages/GuestMembershipPage.vue'


const router = createRouter({
    history: createWebHistory(),
    routes: [
        { path: '/', component: HomePage },
        { path: '/dashboard', component: DashboardPage },
        { path: '/guests', component: GuestsPage },
        { path: '/lockers', component: LockersPage },
        { path: '/guests/details/:id', component: GuestDetailPage },
        { path: '/guests/newGuest', component: NewGuestPage },
        { path: '/guests/guestMembership/:id', component: GuestMembershipPage }
    ]
});

export default router;
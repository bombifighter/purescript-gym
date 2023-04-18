<template>
    <HeaderNav></HeaderNav>
    <PageTitle title="Guest memberships"></PageTitle>
    <GuestMembership :selectedGuestId="guestId"></GuestMembership>
</template>

<script>
import PageTitle from '../components/PageTitle.vue'
import HeaderNav from '../components/HeaderNav.vue'
import GuestMembership from '../components/GuestMembership.vue'

export default {
    components: {
        PageTitle,
        GuestMembership,
        HeaderNav
    },
    data() {
        return {
            guestId: this.$route.params.id
        }
    }
}
</script>
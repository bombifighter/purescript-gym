<template>
    <HeaderNav></HeaderNav>
    <PageTitle title="Guest details"></PageTitle>
    <GuestDetails :selectedGuestId="guestId"></GuestDetails>
</template>

<script>
import GuestDetails from '../components/GuestDetails.vue';
import PageTitle from '../components/PageTitle.vue'
import HeaderNav from '../components/HeaderNav.vue'

export default {
    components: {
        PageTitle,
        GuestDetails,
        HeaderNav
    },
    data() {
        return {
            guestId: this.$route.params.id
        }
    }
}
</script>
<template>
    <PageTitle title="Guest details"></PageTitle>
    <GuestDetails :selectedGuestId="guestId"></GuestDetails>
</template>

<script>
import GuestDetails from '../components/GuestDetails.vue';
import PageTitle from '../components/PageTitle.vue'

export default {
    components: {
        PageTitle,
        GuestDetails
    },
    data() {
        return {
            guestId: this.$route.params.id
        }
    }
}
</script>
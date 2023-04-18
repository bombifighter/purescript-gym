<template>
    <HeaderNav></HeaderNav>
    <PageTitle title="New guest"></PageTitle>
    <NewGuest></NewGuest>
</template>

<script>
import GuestDetails from '../components/GuestDetails.vue';
import PageTitle from '../components/PageTitle.vue'
import HeaderNav from '../components/HeaderNav.vue'
import NewGuest from '../components/NewGuest.vue';

export default {
    components: {
        PageTitle,
        GuestDetails,
        HeaderNav,
        NewGuest
    }
}
</script>
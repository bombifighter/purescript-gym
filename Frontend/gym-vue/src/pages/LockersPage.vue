<template>
    <HeaderNav></HeaderNav>
    <PageTitle title="Lockers"></PageTitle>
    <LockerMaps></LockerMaps>
</template>

<script>
import PageTitle from '../components/PageTitle.vue'
import HeaderNav from '../components/HeaderNav.vue'
import LockerMaps from '../components/LockerMaps.vue';

export default {
    components: {
        PageTitle,
        HeaderNav,
        LockerMaps
    }
}
</script>
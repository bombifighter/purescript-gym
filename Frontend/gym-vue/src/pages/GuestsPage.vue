<template>
    <HeaderNav></HeaderNav>
    <PageTitle title="Guests"></PageTitle>
    <GuestsTable></GuestsTable>
</template>

<script>
import PageTitle from '../components/PageTitle.vue'
import GuestsTable from '../components/GuestsTable.vue';
import HeaderNav from '../components/HeaderNav.vue'

export default {
    components: {
        PageTitle, GuestsTable, HeaderNav
    }
}
</script>
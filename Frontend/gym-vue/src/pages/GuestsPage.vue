<template>
    <PageTitle title="Guests"></PageTitle>
    <GuestsTable></GuestsTable>
</template>

<script>
import PageTitle from '../components/PageTitle.vue'
import GuestsTable from '../components/GuestsTable.vue';

export default {
    components: {
        PageTitle, GuestsTable
    }
}
</script>
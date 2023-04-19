<template>
    <HeaderNav></HeaderNav>
    <PageTitle title="Locker history"></PageTitle>
    <LockerHistory :gender="gender" :lockerId="lockerId"></LockerHistory>
</template>

<script>
import PageTitle from '../components/PageTitle.vue'
import HeaderNav from '../components/HeaderNav.vue'
import LockerHistory from '../components/LockerHistory.vue'

export default {
    components: {
        PageTitle,
        HeaderNav,
        LockerHistory
    },
    data() {
        return {
            gender: this.$route.params.gender,
            lockerId: this.$route.params.id
        }
    }
}
</script>
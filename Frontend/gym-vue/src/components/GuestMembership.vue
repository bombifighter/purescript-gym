<template>
    <div class="container">
        <h2>{{ guest.name }}</h2>
        <div class="clubContainer">
            <p>Club Membership Status</p>
            <p>{{ clubStatus }}</p>
            <p v-if="clubStatusEnd">End date: {{ clubStatusEnd }}</p>
            <div v-if="clubStatus == 'inactive'">
                <button class="btn btn-success" @click.prevent="addClubMemberShip"><i class="bi bi-plus-circle"></i>Add Club
                    Membership</button>
            </div>
        </div>
        <div class="membershipContainer">
            <p>Membership Status</p>
            <p>{{ membershipStatus }}</p>
            <div v-if="membershipStatus == 'active'" class="membershipData">
                <p>Name: {{ membershipName }}</p>
                <p>Type: {{ membershipType }}</p>
                <p>End Date: {{ membershipEndDate }}</p>
                <p v-if="membershipType == 'occasional'"> Occasions left: {{ occasionsLeft }}</p>
            </div>
        </div>
        <div>
            <button class="btn btn-danger" @click.prevent="exit">Exit</button>
        </div>
    </div>
</template>

<script>
export default {
    props: ['selectedGuestId'],
    data() {
        return {
            guest: {},
            clubStatus: 'inactive',
            clubStatusEnd: '',
            membershipStatus: 'inactive',
            membershipName: '',
            membershipType: '',
            membershipEndDate: '',
            occasionsLeft: 0
        }
    },
    methods: {
        async getData() {
            const res = await fetch(`http://localhost:3000/guest/getById/${this.selectedGuestId}`)
            const finalRes = await res.json()
            this.guest = finalRes[0]
        },
        async getClubStatus() {
            const res = await fetch(`http://localhost:3000/clubmember/findMembershipsById/${this.selectedGuestId}`)
            const clubMemberships = await res.json()
            console.log(clubMemberships);
            for (let clubMembership of clubMemberships) {
                if (Date.parse(clubMembership.endDate) >= Date.now()) {
                    this.clubStatus = 'active'
                    this.clubStatusEnd = clubMembership.endDate
                }
            }
        },
        async getMembershipStatus() {
            const res = await fetch(`http://localhost:3000/member/findMembershipsById/${this.selectedGuestId}`)
            const memberships = await res.json()
            console.log(memberships);
            for (let membership of memberships) {
                if (Date.parse(membership.endDate) >= Date.now()) {
                    this.membershipStatus = 'active'
                    this.membershipEndDate = membership.endDate
                    const typeRes = await fetch(`http://localhost:3000/membershipType/getMembershipById/${membership.membershipTypeId}`)
                    const membershipTypeData = (await typeRes.json())[0]
                    this.membershipName = membershipTypeData.name
                    this.membershipType = membershipTypeData.isPass == "true" ? "pass" : "occasional"
                    this.occasionsLeft = membership.occasionsLeft
                }
            }
        },
        exit() {
            this.$router.push({ path: '/guests' })
        },
        async addClubMemberShip() {
            const newId = await this.getLastClubMemberId() + 1
            const newEndDate = await this.calculateEndDate(30)

            const newClubmembership = { id: newId, guestId: this.guest.id, endDate: newEndDate }
            console.log(newClubmembership);
            const options = {
                method: "POST",
                header: { "Content-Type": "application/json" },
                body: JSON.stringify(newClubmembership)
            }
            const response = await fetch("http://localhost:3000/clubmember/insertClubMember", options)
            const data = await response.json()
            console.log(data)
            this.$router.go()
        },
        async getLastClubMemberId() {
            const response = await fetch("http://localhost:3000/clubmember/getLastId")
            const data = await response.json()
            return data[0].lastId
        },
        async calculateEndDate(plusDays) {
            let now = new Date()
            now.setDate(now.getDate() + plusDays)
            return now.getFullYear() + "/" + (now.getMonth() + 1) + "/" + now.getDate()
        }
    },
    created() {
        this.getData()
        this.getClubStatus()
        this.getMembershipStatus()
    }
}
</script>

<style scoped>
.container {
    width: 50vw;
}
</style>
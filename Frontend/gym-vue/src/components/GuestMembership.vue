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
            <div v-if="membershipStatus == 'inactive'">
                <button class="btn btn-success" @click.prevent="openMembershipSelector"><i class="bi bi-plus-circle"></i>Add
                    Membership</button>
            </div>
        </div>
        <div>
            <button class="btn btn-danger" @click.prevent="exit">Exit</button>
        </div>
        <div class="pageOverlay" :class="tableClasses">
            <div class="membershipTable" :class="tableClasses">
                <a class="closeButton" @click="closeMembershipSelector"><i class="bi bi-x-circle"></i></a>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Name</th>
                            <th scope="col">Type</th>
                            <th v-if="membershipType.isPass == 'false'" scope="col">Occasions</th>
                            <th v-if="clubStatus == 'inactive'" scope="col">Full price</th>
                            <th v-if="clubStatus == 'inactive'" scope="col">Student price</th>
                            <th v-if="clubStatus == 'active'" scope="col">Club price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="membershipType in membershipTypes">
                            <td>{{ membershipType.name }}</td>
                            <td>{{ calculatePasstype(membershipType.isPass) }}</td>
                            <td v-if="membershipType.isPass == 'false'">{{ membershipType.occasions }}</td>
                            <td v-if="clubStatus == 'inactive'"><a class="priceButton"
                                    @click="addMembership(membershipType.id, membershipType.occasions, 30)">{{
                                        membershipType.fullPrice }}</a></td>
                            <td v-if="clubStatus == 'inactive'"><a class="priceButton"
                                    @click="addMembership(membershipType.id, membershipType.occasions, 30)">{{
                                        membershipType.studentPrice }}</a></td>
                            <td v-if="clubStatus == 'active'"><a class="priceButton"
                                    @click="addMembership(membershipType.id, membershipType.occasions, 30)">{{
                                        membershipType.clubPrice }}</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</template>

<script>
export default {
    props: ['selectedGuestId'],
    data() {
        return {
            membershipTypes: [],
            guest: {},
            clubStatus: 'inactive',
            clubStatusEnd: '',
            membershipStatus: 'inactive',
            membershipName: '',
            membershipType: '',
            membershipEndDate: '',
            occasionsLeft: 0,
            tableClasses: 'invisible'
        }
    },
    methods: {
        async getData() {
            const res = await fetch(`http://localhost:3000/guest/getById/${this.selectedGuestId}`)
            const data = await res.json()
            this.guest = data[0]
        },
        async getMembershipTypes() {
            const res = await fetch("http://localhost:3000/membershipTypes/getAll")
            const data = await res.json()
            this.membershipTypes = data
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
                    this.membershipType = this.calculatePasstype(membershipTypeData.isPass)
                    this.occasionsLeft = membership.occasionsLeft
                }
            }
        },
        exit() {
            this.$router.push({ path: '/guests' })
        },
        async addMembership(typeId, occasions, days) {
            const newId = await this.getLastMemberId() + 1
            const newEndDate = await this.calculateEndDate(days)

            const newMembership = { id: newId, guestId: this.guest.id, membershipTypeId: typeId, endDate: newEndDate, occasionsLeft: occasions }
            const options = {
                method: "POST",
                header: { "Content-Type": "application/json" },
                body: JSON.stringify(newMembership)
            }
            const response = await fetch("http://localhost:3000/membership/insertMembership", options)
            const data = await response.json()
            console.log(data)
            // TODO - close dialog
            this.$router.go()
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
        async getLastMemberId() {
            const response = await fetch("http://localhost:3000/member/getLastId")
            const data = await response.json()
            return data[0].lastId
        },
        async calculateEndDate(plusDays) {
            return moment().add(plusDays, 'days').format("YYYY/MM/DD")
        },
        calculatePasstype(isPassValue) {
            return isPassValue == "true" ? "pass" : "occasional"
        },
        openMembershipSelector() {
            this.tableClasses = 'visible'
        },
        closeMembershipSelector() {
            this.tableClasses = 'invisible'
        }
    },
    created() {
        this.getData()
        this.getClubStatus()
        this.getMembershipStatus()
        this.getMembershipTypes()
    }
}
</script>

<style scoped>
.container {
    width: 50vw;
}

.priceButton {
    background-color: aqua;
    border-radius: 10px;
    cursor: pointer;
}

.invisible {
    display: none;
}

.visible {
    display: block;
}

.membershipTable {
    position: fixed;
    top: 50%;
    left: 50%;
    width: 700px;
    height: 600px;
    margin-top: -300px;
    margin-left: -350px;
    background-color: whitesmoke;
    padding: 30px;
    border-radius: 30px;
}

.pageOverlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.2);
}

.closeButton {
    color: red;
    cursor: pointer;
}
</style>
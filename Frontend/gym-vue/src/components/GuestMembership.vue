<template>
    <div class="statusContainer">
        <h2>{{ guest.name }}</h2>
        <div class="statusTableWrapper">
            <table class="statusTable">
                <tbody>
                    <tr>
                        <td>Club Membership Status:</td>
                        <td>{{ clubStatus }}</td>
                    </tr>
                    <tr v-if="clubStatusEnd">
                        <td>End date:</td>
                        <td>{{ clubStatusEnd }}</td>
                    </tr>
                    <tr v-if="clubStatus == 'inactive'">
                        <td colspan="2" class="buttonCell"><button class="btn btnAdd" @click.prevent="addClubMemberShip"><i
                                    class="bi bi-plus-circle"></i> Add
                                Club
                                Membership</button></td>
                    </tr>
                    <tr class="dividerRow">
                        <td>Membership Status:</td>
                        <td>{{ membershipStatus }}</td>
                    </tr>
                    <tr v-if="membershipStatus == 'active'">
                        <td>Name:</td>
                        <td>{{ membershipName }}</td>
                    </tr>
                    <tr v-if="membershipStatus == 'active'">
                        <td>Type:</td>
                        <td>{{ membershipType }}</td>
                    </tr>
                    <tr v-if="membershipStatus == 'active'">
                        <td>End Date:</td>
                        <td>{{ membershipEndDate }}</td>
                    </tr>
                    <tr v-if="membershipType == 'occasional' && membershipStatus == 'active'">
                        <td>Occasions left:</td>
                        <td>{{ occasionsLeft }}</td>
                    </tr>
                    <tr v-if="membershipStatus == 'inactive'">
                        <td colspan="2" class="buttonCell"><button class="btn btnAdd"
                                @click.prevent="openMembershipSelector"><i class="bi bi-plus-circle"></i> Add
                                Membership</button></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div>
            <button class="btn btnExit" @click.prevent="exit">Exit</button>
        </div>
        <div class="pageOverlay" :class="tableClasses">
            <div class="membershipTable">
                <div class="closeButtonContainer">
                    <a class="closeButton" @click="closeMembershipSelector"><i class="bi bi-x-circle"></i></a>
                </div>
                <table class="table priceTable">
                    <thead>
                        <tr>
                            <th scope="col">Name</th>
                            <th scope="col">Type</th>
                            <th scope="col">Occasions</th>
                            <th v-if="clubStatus == 'inactive'" scope="col">Full price</th>
                            <th v-if="clubStatus == 'inactive'" scope="col">Student price</th>
                            <th v-if="clubStatus == 'active'" scope="col">Club price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="membershipType in membershipTypes">
                            <td>{{ membershipType.name }}</td>
                            <td>{{ calculatePasstype(membershipType.isPass) }}</td>
                            <td>{{ getOccasions(membershipType.isPass, membershipType.occasions) }}</td>
                            <td v-if="clubStatus == 'inactive'"><button class="btn btnAdd"
                                    @click.prevent="addMembership(membershipType.id, membershipType.occasions, 30)">{{
                                        membershipType.fullPrice }}</button></td>
                            <td v-if="clubStatus == 'inactive'"><button class="btn btnAdd"
                                    @click.prevent="addMembership(membershipType.id, membershipType.occasions, 30)">{{
                                        membershipType.studentPrice }}</button></td>
                            <td v-if="clubStatus == 'active'"><button class="btn btnAdd"
                                    @click.prevent="addMembership(membershipType.id, membershipType.occasions, 30)">{{
                                        membershipType.clubPrice }}</button></td>
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
            for (let membership of memberships) {
                if (Date.parse(membership.endDate) >= Date.now() && membership.occasionsLeft != 0) {
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
            this.$router.go()
        },
        async addClubMemberShip() {
            const newId = await this.getLastClubMemberId() + 1
            const newEndDate = await this.calculateEndDate(30)

            const newClubmembership = { id: newId, guestId: this.guest.id, endDate: newEndDate }
            const options = {
                method: "POST",
                header: { "Content-Type": "application/json" },
                body: JSON.stringify(newClubmembership)
            }
            const response = await fetch("http://localhost:3000/clubmember/insertClubMember", options)
            const data = await response.json()
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
        },
        getOccasions(isPass, occasions) {
            return isPass == 'true' ? 'unlimited' : occasions
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
h2 {
    text-align: center;
    margin-bottom: 30px;
}

.statusContainer {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.statusTableWrapper {
    width: 40%;
    margin-bottom: 40px;
    border: 2px solid #354649;
    border-radius: 20px;
    padding: 10px 40px;
}

.statusTable {
    width: 100%;
}

.statusTable tr {
    height: 60px;
}

.statusTable tr td:first-of-type {
    font-weight: bold;
}

table .priceButton {
    background-color: aqua;
    border-radius: 10px;
    cursor: pointer;
}

.priceTable td,
.priceTable th {
    vertical-align: middle;
    border-color: #354649;
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
    background-color: #E0E7E9;
    color: #354649;
    padding: 30px;
    border-radius: 30px;
    border: 3px solid #354649;
}

.pageOverlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.2);
}

.btnAdd {
    background-color: #6C7A89;
    border-color: #354649;
    color: #E0E7E9;
    font-weight: 600;
}

.btnAdd:hover {
    background-color: #354649;
}

.btnExit {
    background-color: #ab7575;
    color: #E0E7E9;
    font-weight: 600;
    border-color: #354649;
    margin-bottom: 50px;
}

.btnExit:hover {
    background-color: #583a3a;
}

.buttonCell {
    text-align: center;
}

.dividerRow {
    border-top: 1px solid #354649;
}

.closeButton {
    color: #ab7575;
    cursor: pointer;
}

.closeButton:hover {
    color: #583a3a;
}

.closeButtonContainer {
    display: flex;
    justify-content: flex-end;
}
</style>
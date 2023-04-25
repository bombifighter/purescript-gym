<template>
    <div v-if="activeGuests.length == 0" class="noActiveGuests">There are no active guests in the gym.</div>
    <table v-if="activeGuests.length != 0" class="table">
        <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Name</th>
                <th scope="col">Gender</th>
                <th scope="col">Locker Number</th>
                <th scope="col">Check-in time</th>
                <th scope="col"></th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="(guest, index) in activeGuests">
                <th scope="row">{{ index + 1 }}</th>
                <td>{{ guest.guestName }}</td>
                <td>{{ guest.gender }}</td>
                <td>{{ guest.lockerId }}</td>
                <td>{{ guest.startTime }}</td>
                <td><button class="btn checkoutBtn"
                        @click.prevent="checkoutGuest(guest.guestId, guest.gender, guest.lockerId)">Check-out</button></td>
            </tr>
        </tbody>
    </table>
</template>

<script>
export default {
    data() {
        return {
            activeGuests: []
        }
    },
    methods: {
        async getActiveGuests() {
            const res = await fetch("http://127.0.0.1:3000/guest/getActive")
            const data = await res.json()
            this.activeGuests = data;
        },
        async checkoutGuest(guestId, gender, lockerId) {
            const dateTime = moment().format("YYYY/MM/DD HH:mm")
            const checkout = { guestId: guestId, gender: gender, lockerId: lockerId, dateTime: dateTime }
            const options = {
                method: "POST",
                headers: new Headers({ "Content-Type": "application/json" }),
                body: JSON.stringify(checkout)
            }
            await fetch("http://127.0.0.1:3000/guest/checkout", options)
            this.$router.go()
        }
    },
    created() {
        this.getActiveGuests();
    }
}
</script>

<style scoped>
.checkoutBtn {
    background-color: #ab7575;
    color: #E0E7E9;
    font-weight: 600;
    border-color: #354649;
}

.checkoutBtn:hover {
    background-color: #583a3a;
}

td,
th {
    vertical-align: middle;
    border-color: #354649;
}

.noActiveGuests {
    text-align: center;
    margin-top: 50px;
    font-weight: bold;
}
</style>
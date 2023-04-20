<template>
    <table class="table">
        <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Name</th>
                <th scope="col">Gender</th>
                <th scope="col">Locker Number</th>
                <th scope="col">Check-in time</th>
                <th scope="col">Check-out</th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="(guest, index) in activeGuests">
                <th scope="row">{{ index + 1 }}</th>
                <td>{{ guest.guestName }}</td>
                <td>{{ guest.gender }}</td>
                <td>{{ guest.lockerId }}</td>
                <td>{{ guest.startTime }}</td>
                <td><button class="btn btn-danger"
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
            const res = await fetch("http://localhost:3000/guest/getActive")
            const data = await res.json()
            this.activeGuests = data;
        },
        async checkoutGuest(guestId, gender, lockerId) {
            const checkout = { guestId: guestId, gender: gender, lockerId: lockerId }
            const options = {
                method: "POST",
                header: { "Content-Type": "application/json" },
                body: JSON.stringify(checkout)
            }
            const res = await fetch("http://localhost:3000/guest/checkout", options)
            const data = await res.json()
            console.log(data);
            this.$router.go()
        }
    },
    created() {
        this.getActiveGuests();
    }
}
</script>
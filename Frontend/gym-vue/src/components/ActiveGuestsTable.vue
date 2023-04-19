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
                <td><button class="btn btn-danger" @click.prevent="checkoutGuest">Check-out</button></td>
            </tr>
        </tbody>
    </table>
</template>

<script>
export default {
    data() {
        return {
            activeGuests: [],
            inactiveGuests: []
        }
    },
    methods: {
        async getActiveGuests() {
            const res = await fetch("http://localhost:3000/guest/getActive");
            const data = await res.json();
            this.activeGuests = data;
        },
        async checkoutGuest() {

        }
    },
    created() {
        this.getActiveGuests();
    }
}
</script>
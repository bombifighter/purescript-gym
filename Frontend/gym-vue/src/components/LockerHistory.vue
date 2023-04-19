<template>
    <div class="container">
        <div class="statusContainer">
            <div>Gender: {{ gender }}, Number: {{ lockerId }}</div>
            <div>Status: {{ status }}</div>
        </div>
        <div class="historyContainer">
            <div v-if="history.length == 0">There is no history recorded related to this locker.</div>
            <table v-if="history.length != 0" class="table">
                <thead>
                    <tr>
                        <th scope="col">Start Time</th>
                        <th scope="col">End Time</th>
                        <th scope="col">Guest Details</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="historyEntry in history">
                        <td>{{ historyEntry.startTime }}</td>
                        <td>{{ historyEntry.endTime == "0" ? "In Use" : historyEntry.endTime }}</td>
                        <td><a class="guestDetailButton" :href="'/guests/details/' + historyEntry.guestId">Details</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>

<script>

export default {
    props: ['gender', 'lockerId'],
    data() {
        return {
            status: 'free',
            history: []
        }
    },
    methods: {
        async checkStatus() {
            const res = await fetch(`http://localhost:3000/lockers/get/${this.gender}/${this.lockerId}`)
            const data = await res.json()
            this.status = data[0].isFree == 'true' ? 'free' : 'occupied'
        },
        async getHistory() {
            const res = await fetch(`http://localhost:3000/guestLocker/getHistory/${this.gender}/${this.lockerId}`)
            const data = await res.json()
            this.history = data
        }
    },
    created() {
        this.checkStatus()
        this.getHistory()
    }
}

</script>

<style scoped>
.guestDetailButton {
    background-color: aliceblue;
    cursor: pointer;
}
</style>
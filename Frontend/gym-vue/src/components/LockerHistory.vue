<template>
    <div class="container">
        <div class="statusContainer">
            <div class="cardElement">
                <div><b>Gender:</b> {{ gender }}</div>
                <div><b>Number:</b> {{ lockerId }}</div>
                <div><b>Status:</b> {{ status }}</div>
            </div>
        </div>
        <div class="historyContainer">
            <div v-if="history.length == 0" class="noHistory">There is no history recorded related to this locker.</div>
            <table v-if="history.length != 0" class="table">
                <thead>
                    <tr>
                        <th scope="col">Start Time</th>
                        <th scope="col">End Time</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="historyEntry in history">
                        <td>{{ historyEntry.startTime }}</td>
                        <td>{{ historyEntry.endTime == "0" ? "In Use" : historyEntry.endTime }}</td>
                        <td><button class="btn btnAdd"
                                @click.prevent="goToGuestDetailsPage(historyEntry.guestId)">Details</button>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div>
                <button class="btn btnExit" @click.prevent="exit">Exit</button>
            </div>
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
        },
        goToGuestDetailsPage(guestId) {
            this.$router.push({ path: `/guests/details/${guestId}` })
        },
        exit() {
            this.$router.push({ path: '/lockers' })
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

.statusContainer {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.cardElement {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 25px;
    padding: 15px 30px;
    border: 2px solid #354649;
    border-radius: 20px;
}

.historyContainer {
    margin-top: 50px;
    display: flex;
    flex-direction: column;
    align-items: center;
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

table {
    width: 40%;
}

td,
th {
    vertical-align: middle;
    border-color: #354649;
}

.noHistory {
    text-align: center;
    margin: 30px;
    font-weight: bold;
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
</style>
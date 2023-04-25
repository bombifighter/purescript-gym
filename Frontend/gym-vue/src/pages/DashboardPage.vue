<template>
    <HeaderNav></HeaderNav>
    <PageTitle title="Dashboard"></PageTitle>
    <div class="pageContainer">
        <div class="addButtonContainer">
            <button class="btn btnAdd" @click.prevent="openOverlay"><i class="bi bi-plus-circle"></i> Check-in
                Guest</button>
        </div>
        <div class="activeGuests">
            <h3>Active guests</h3>
            <ActiveGuestsTable></ActiveGuestsTable>
        </div>
    </div>
    <div class="pageOverlay" :class="tableClasses">
        <div class="inactiveGuestsTable">
            <div class="closeButtonContainer">
                <a class="closeButton" @click="closeOverlay"><i class="bi bi-x-circle"></i></a>
            </div>
            <div v-if="inactiveGuests.length == 0" class="noInactiveGuests">There are no inactive guests left.</div>
            <table v-if="inactiveGuests.length != 0" class="table">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Name</th>
                        <th scope="col">Gender</th>
                        <th scope="col">Birthdate</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(guest, index) in inactiveGuests">
                        <th scope="row">{{ index + 1 }}</th>
                        <td>{{ guest.guestName }}</td>
                        <td>{{ guest.gender }}</td>
                        <td>{{ guest.bdate }}</td>
                        <td><button class="btn btnAdd" @click.prevent="checkinGuest(guest.guestId, guest.gender)"><i
                                    class="bi bi-plus-circle"></i> Check-in</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>

<script>
import PageTitle from '../components/PageTitle.vue'
import HeaderNav from '../components/HeaderNav.vue'
import ActiveGuestsTable from '../components/ActiveGuestsTable.vue';

export default {
    components: {
        PageTitle,
        HeaderNav,
        ActiveGuestsTable
    },
    data() {
        return {
            inactiveGuests: [],
            tableClasses: 'invisible'
        }
    },
    methods: {
        async getInactiveGuests() {
            const date = encodeURIComponent(moment().format("YYYY/MM/DD"))
            const res = await fetch(`http://127.0.0.1:3000/guest/getInactive/${date}`);
            const data = await res.json();
            this.inactiveGuests = data;
        },
        async checkinGuest(guestId, gender) {
            const date = moment().format("YYYY/MM/DD")
            const time = moment().format("HH:mm")
            const checkin = { guestId: guestId, gender: gender, date: date, time: time }
            const options = {
                method: "POST",
                headers: new Headers({ "Content-Type": "application/json" }),
                body: JSON.stringify(checkin)
            }
            await fetch("http://127.0.0.1:3000/guest/checkin", options)
            this.$router.go()
        },
        openOverlay() {
            this.tableClasses = 'visible'
        },
        closeOverlay() {
            this.tableClasses = 'invisible'
        }
    },
    created() {
        this.getInactiveGuests()
    }
}
</script>

<style scoped>
.pageContainer {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.activeGuests {
    width: 60%;
    margin-top: 50px;
    display: flex;
    flex-direction: column;
    align-items: center;
}

h3 {
    text-decoration: underline;
    margin-bottom: 20px;
}

.invisible {
    display: none;
}

.visible {
    display: block;
}

.inactiveGuestsTable {
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

td,
th {
    vertical-align: middle;
    border-color: #354649;
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

.btnAdd {
    background-color: #6C7A89;
    border-color: #354649;
    color: #E0E7E9;
    font-weight: 600;
}

.btnAdd:hover {
    background-color: #354649;
}

.noInactiveGuests {
    text-align: center;
    margin-top: 50px;
    font-weight: bold;
}
</style>
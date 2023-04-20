<template>
    <HeaderNav></HeaderNav>
    <PageTitle title="Dashboard"></PageTitle>
    <div class="pageContainer">
        <div class="activeGuests">
            <h3>Active guests</h3>
            <ActiveGuestsTable></ActiveGuestsTable>
        </div>
        <div class="stats">
            <button class="btn btn-success" @click.prevent="openOverlay"><i class="bi bi-plus-circle"></i> Check-in
                Guest</button>
        </div>
    </div>
    <div class="pageOverlay" :class="tableClasses">
        <div class="inactiveGuestsTable">
            <a class="closeButton" @click="closeOverlay"><i class="bi bi-x-circle"></i></a>
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Name</th>
                        <th scope="col">Gender</th>
                        <th scope="col">Birthdate</th>
                        <th scope="col">Check-in</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(guest, index) in inactiveGuests">
                        <th scope="row">{{ index + 1 }}</th>
                        <td>{{ guest.guestName }}</td>
                        <td>{{ guest.gender }}</td>
                        <td>{{ guest.bdate }}</td>
                        <td><button class="btn btn-success"
                                @click.prevent="checkinGuest(guest.guestId, guest.gender)">Check-in</button>
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
            const res = await fetch("http://localhost:3000/guest/getInactive");
            const data = await res.json();
            this.inactiveGuests = data;
        },
        async checkinGuest(guestId, gender) {
            const checkin = { guestId: guestId, gender: gender }
            const options = {
                method: "POST",
                header: { "Content-Type": "application/json" },
                body: JSON.stringify(checkin)
            }
            const res = await fetch("http://localhost:3000/guest/checkin", options)
            const data = await res.json()
            console.log(data);
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
.activeGuests {
    width: 60%;
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
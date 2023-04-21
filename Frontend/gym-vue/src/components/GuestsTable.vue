<template>
    <div class="myContainer">
        <div class="buttonContainer">
            <button class="btn btnAdd" @click.prevent="goToNewGuestPage"><i class="bi bi-person-plus"></i> Add
                Guest</button>
        </div>
        <div v-if="guests.length == 0" class="noGuests">There are no guests in the database.</div>
        <table v-if="guests.length != 0" class="table">
            <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Name</th>
                    <th scope="col">Gender</th>
                    <th scope="col">Birthdate</th>
                    <th scope="col">Phone</th>
                    <th scope="col">Email</th>
                    <th scope="col"></th>
                    <th scope="col"></th>
                    <th scope="col"></th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(guest, index) in guests">
                    <th scope="row">{{ index + 1 }}</th>
                    <td>{{ guest.name }}</td>
                    <td>{{ guest.gender }}</td>
                    <td>{{ guest.bdate }}</td>
                    <td>{{ guest.phone }}</td>
                    <td>{{ guest.email }}</td>
                    <td>
                        <a id="passButton" :href="'/guests/guestMembership/' + guest.id"><i class="bi bi-journal"></i></a>
                    </td>
                    <td>
                        <a :href="'/guests/details/' + guest.id"><i class="bi bi-gear"></i></a>
                    </td>
                    <td><a id="deleteButton" @click="openOverlay(guest.id)"><i class="bi bi-trash"></i></a></td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="pageOverlay" :class="confirmClasses">
        <div class="confirmContainer">
            <div class="question">Are you sure you want to delete this user?</div>
            <div class="confirmButtonContainer">
                <button class="btn btnAdd" @click.prevent="closeOverlay()">Cancel</button>
                <button class="btn btnExit" @click.prevent="deleteUser(userIdToDelete)">Confrim delete</button>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            guests: [],
            userIdToDelete: 0,
            confirmClasses: 'invisible'
        }
    },
    methods: {
        async getData() {
            const res = await fetch("http://localhost:3000/guest/getAll");
            const finalRes = await res.json();
            this.guests = finalRes;
        },
        async deleteUser(id) {
            const options = {
                method: "DELETE"
            }
            await fetch(`http://localhost:3000/guest/deleteGuest/${id}`, options)
            this.$router.go()
        },
        openOverlay(idToDelete) {
            this.confirmClasses = 'visible'
            this.userIdToDelete = idToDelete
        },
        closeOverlay() {
            this.confirmClasses = 'invisible'
        },
        goToNewGuestPage() {
            this.$router.push({ path: "/guests/newGuest" })
        }
    },
    created() {
        this.getData()
    }
}
</script>

<style scoped>
table {
    width: 70%;
    margin-top: 50px;
}

th,
td {
    vertical-align: middle;
    border-color: #354649;
}

.myContainer {
    display: flex;
    flex-direction: column;
    align-items: center;
}

#deleteButton {
    color: red;
    cursor: pointer;
}

#passButton {
    color: green;
}

.buttonContainer a {
    background-color: #2da9cd;
    color: white;
    width: 40px;
    height: 40px;
    border-radius: 10px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.confirmContainer {
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
    display: flex;
    flex-direction: column;
    padding: 200px 100px;
}

.confirmContainer .question {
    text-align: center;
    margin-bottom: 50px;
    font-weight: bold;
}

.confirmButtonContainer {
    display: flex;
    justify-content: center;
    gap: 40px;
}

.invisible {
    display: none;
}

.visible {
    display: block;
}

.pageOverlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.2);
}

.confirmContainer a {
    cursor: pointer;
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
}

.btnExit:hover {
    background-color: #583a3a;
}

.noGuests {
    text-align: center;
    margin: 30px;
    font-weight: bold;
}
</style>
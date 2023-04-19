<template>
    <div class="myContainer">
        <div class="buttonContainer">
            <a href="/guests/newGuest"><i class="bi bi-person-plus"></i></a>
        </div>
        <table class="table table-striped-columns">
            <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Name</th>
                    <th scope="col">Gender</th>
                    <th scope="col">Birthdate</th>
                    <th scope="col">Phone</th>
                    <th scope="col">Email</th>
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
            <div>Are you sure you want to delete this user?</div>
            <a @click="closeOverlay()">Cancel</a>
            <a @click="deleteUser(userIdToDelete)">Confrim delete</a>
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
            const response = await fetch(`http://localhost:3000/guest/deleteGuest/${id}`, options)
            const data = await response.json()
            console.log(data)
            this.$router.go()
        },
        openOverlay(idToDelete) {
            this.confirmClasses = 'visible'
            this.userIdToDelete = idToDelete
        },
        closeOverlay() {
            this.confirmClasses = 'invisible'
        }
    },
    created() {
        this.getData()
    }
}
</script>

<style scoped>
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
    background-color: whitesmoke;
    padding: 30px;
    border-radius: 30px;
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
</style>
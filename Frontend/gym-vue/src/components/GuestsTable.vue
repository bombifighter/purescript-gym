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
                        <a :href="'/guests/details/' + guest.id"><i class="bi bi-gear"></i></a>
                    </td>
                    <td><a id="deleteButton" @click="deleteUser(guest.id)"><i class="bi bi-trash"></i></a></td>
                </tr>
            </tbody>
        </table>
    </div>
</template>

<script>
export default {
    data() {
        return {
            guests: []
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
</style>
<template>
    <table class="table table-striped-columns">
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
            </tr>
        </thead>
        <tbody>
            <tr v-for="guest in guests">
                <th scope="row">{{ guest.id }}</th>
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
</style>
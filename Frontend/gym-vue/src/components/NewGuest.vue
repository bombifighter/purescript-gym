<template>
    <div class="container">
        <form class="row g-3 needs-validation" novalidate>
            <div>
                <label for="validationCustom01" class="form-label">Name</label>
                <input type="text" class="form-control" id="validationCustom01" v-model="guest.name" required>
            </div>
            <div>
                <label for="validationCustom02" class="form-label">Gender</label>
                <input type="text" class="form-control" id="validationCustom02" v-model="guest.gender" required>
            </div>
            <div>
                <label for="validationCustomUsername" class="form-label">Birthdate</label>
                <input type="text" class="form-control" id="validationCustomUsername" v-model="guest.bdate" required>
            </div>
            <div>
                <label for="validationCustom03" class="form-label">Phone number</label>
                <input type="text" class="form-control" id="validationCustom03" v-model="guest.phone" required>
            </div>
            <div>
                <label for="validationCustom05" class="form-label">Email adress</label>
                <input type="text" class="form-control" id="validationCustom05" v-model="guest.email" required>
            </div>
            <div>
                <button class="btn btn-primary" @click.prevent="submit">Save changes</button>
            </div>
            <div>
                <button class="btn btn-danger" @click.prevent="exit">Exit</button>
            </div>
        </form>
    </div>
</template>

<script>
export default {
    data() {
        return {
            guest: { id: '', name: '', gender: '', bdate: '', phone: '', email: '' }
        }
    },
    methods: {
        async getNextId() {
            const response = await fetch("http://localhost:3000/guest/getLastId")
            const data = await response.json()
            this.guest.id = data[0].lastId + 1
        },
        async submit() {
            const options = {
                method: "POST",
                header: { "Content-Type": "application/json" },
                body: JSON.stringify(this.guest)
            }
            const response = await fetch(`http://localhost:3000/guest/insertGuest`, options)
            const data = await response.json()
            console.log(data)
            this.$router.push({ path: '/guests' })
        },
        exit() {
            this.$router.push({ path: '/guests' })
        }

    },
    created() {
        this.getNextId()
    }
}
</script>

<style scoped>
.container {
    width: 50vw;
}
</style>
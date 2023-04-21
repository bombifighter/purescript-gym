<template>
    <div class="container">
        <form class="row g-3 needs-validation" novalidate>
            <div>
                <label for="validationCustom01" class="form-label">Name</label>
                <input type="text" class="form-control" id="validationCustom01" v-model="guest.name" required>
            </div>
            <div>
                <label for="validationCustom02" class="form-label">Gender</label>
                <select class="form-select" v-model="guest.gender">
                    <option value="female">Female</option>
                    <option value="male">Male</option>
                </select>
            </div>
            <div>
                <label for="validationCustomUsername" class="form-label">Birthdate</label>
                <VueDatePicker v-model="guest.bdate" :enable-time-picker="false" :format="'yyyy/MM/dd'"
                    model-type="yyyy/MM/dd"></VueDatePicker>
            </div>
            <div>
                <label for="validationCustom03" class="form-label">Phone number</label>
                <input type="text" class="form-control" id="validationCustom03" v-model="guest.phone" required>
            </div>
            <div>
                <label for="validationCustom05" class="form-label">Email adress</label>
                <input type="text" class="form-control" id="validationCustom05" v-model="guest.email" required>
            </div>
            <div class="buttonContainer">
                <button class="btn btnAdd" @click.prevent="submit">Save changes</button>
            </div>
            <div class="buttonContainer">
                <button class="btn btnExit" @click.prevent="exit">Exit</button>
            </div>
        </form>
    </div>
</template>

<script>
import VueDatePicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css'

export default {
    components: {
        VueDatePicker
    },
    props: ['selectedGuestId'],
    data() {
        return {
            guest: {}
        }
    },
    methods: {
        async getData() {
            const res = await fetch(`http://localhost:3000/guest/getById/${this.selectedGuestId}`);
            const finalRes = await res.json();
            this.guest = finalRes[0];
        },
        async submit() {
            const options = {
                method: "PUT",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(this.guest)
            }
            await fetch(`http://localhost:3000/guest/updateGuest/${this.guest.id}`, options)
            this.$router.push({ path: '/guests' })
        },
        exit() {
            this.$router.push({ path: '/guests' })
        }
    },
    created() {
        this.getData()
    }
}
</script>

<style scoped>
.container {
    width: 50vw;
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
    margin-bottom: 50px;
}

.btnExit:hover {
    background-color: #583a3a;
}

.buttonContainer {
    display: flex;
    justify-content: center;
}
</style>
<template>
    <div class="lockerContainer">
        <div class="femalesLockers">
            <h2>Females</h2>
            <div class="lockerIcons">
                <a :href="'/lockers/history/female/' + locker.id" v-for="locker in femaleLockers"
                    :style="{ backgroundColor: calculateColor(locker.isFree) }">{{
                        locker.id }}</a>
            </div>
        </div>
        <div class="maleLockers">
            <h2>Males</h2>
            <div class="lockerIcons">
                <a :href="'/lockers/history/male/' + locker.id" v-for="locker in maleLockers"
                    :style="{ backgroundColor: calculateColor(locker.isFree) }">{{
                        locker.id }}</a>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            femaleLockers: [],
            maleLockers: []
        }
    },
    methods: {
        async getData() {
            const res = await fetch("http://localhost:3000/lockers/getAll");
            const data = await res.json();
            this.femaleLockers = data.filter(locker => locker.gender == 'female')
            this.maleLockers = data.filter(locker => locker.gender == 'male');
        },
        calculateColor(isFree) {
            return isFree == 'true' ? "green" : "red"
        }
    },
    created() {
        this.getData()
    }
}
</script>

<style scoped>
.lockerContainer {
    display: flex;
    width: 100%;
}

.femalesLockers,
.maleLockers {
    width: 50%;
}

.lockerIcons {
    display: flex;
    flex-wrap: wrap;
}

.lockerIcons a {
    display: flex;
    width: 65px;
    height: 65px;
    border-radius: 10px;
    margin: 10px;
    align-items: center;
    justify-content: center;
    color: white;
    font-weight: bold;
    cursor: pointer;
    text-decoration: none;
}
</style>
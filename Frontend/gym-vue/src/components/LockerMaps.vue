<template>
    <div class="lockerContainer">
        <div class="femalesLockers">
            <h2>Females</h2>
            <div class="lockerIcons">
                <a :href="'/lockers/history/female/' + locker.id" v-for="locker in femaleLockers"
                    :class="calculateColor(locker.isFree)">{{
                        locker.id }}</a>
            </div>
        </div>
        <div class="maleLockers">
            <h2>Males</h2>
            <div class="lockerIcons">
                <a :href="'/lockers/history/male/' + locker.id" v-for="locker in maleLockers"
                    :class="calculateColor(locker.isFree)">{{
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
            return isFree == 'true' ? "freeLocker" : "occupiedLocker"
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
    display: flex;
    flex-direction: column;
    align-items: center;
}

.maleLockers {
    border-left: 2px solid #354649;
}

.lockerIcons {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
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
    border: 2px solid #354649;
}

.lockerIcons a.freeLocker {
    background-color: #A3C6C4;
}

.lockerIcons a.occupiedLocker {
    background-color: #b98585;
}

.lockerIcons a.freeLocker:hover {
    background-color: #799997;
}

.lockerIcons a.occupiedLocker:hover {
    background-color: #8d6565;
}
</style>
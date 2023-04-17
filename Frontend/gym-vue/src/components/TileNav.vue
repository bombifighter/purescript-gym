<template>
    <div class="container">
        <div class="navElement">
            <a class="nav-link" href="/dashboard">Dashboard</a>
        </div>
        <div class="navElement">
            <a class="nav-link" href="/guests">Guests</a>
        </div>
        <div class="navElement">
            <a class="nav-link" href="/lockers">Lockers</a>
        </div>
    </div>
</template>

<style scoped>
.container {
    width: 50vw;
    display: flex;
    gap: 20px;
    justify-content: space-between;
}

.container .navElement {
    width: 33%;
    display: flex;
    justify-content: center;
}

.container a {
    width: 100%;
    height: 20vh;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 10px;
    color: white;
    background-color: green;
}
</style>
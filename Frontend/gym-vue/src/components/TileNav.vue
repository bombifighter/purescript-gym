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
    gap: 50px;
    justify-content: space-between;
}

.container .navElement {
    width: 33%;
    display: flex;
    justify-content: center;
}

.container a {
    width: 20vh;
    height: 20vh;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 10px;
    color: #E0E7E9;
    background-color: #6C7A89;
    font-size: large;
    border: 3px solid #354649;
}

.container a:hover {
    background-color: #354649;
}
</style>
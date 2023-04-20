<template>
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
        <div class="container-fluid">
            <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                <div class="navbar-nav">
                    <a class="nav-link" href="/">Home</a>
                    <a class="nav-link" href="/dashboard">Dashboard</a>
                    <a class="nav-link" href="/guests">Guests</a>
                    <a class="nav-link" href="/lockers">Lockers</a>
                </div>
            </div>
        </div>
    </nav>
</template>

<style scoped>
nav {
    background-color: #6C7A89 !important;
    position: sticky;
}

.nav-link {
    color: #E0E7E9;
    font-weight: bold;
}

.nav-link:hover {
    color: #A3C6C4;
}
</style>
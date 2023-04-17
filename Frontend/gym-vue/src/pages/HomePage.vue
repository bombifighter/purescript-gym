<template>
    <div class="container">
        <div class="logoContainer">
            <div class="titleContainer">
                <PageTitle title="Pure Power Gym"></PageTitle>
            </div>
            <img src="../assets/muscle.png" alt="logo" height="300">
        </div>
        <TileNav />
    </div>
</template>
  
<script>
import PageTitle from '../components/PageTitle.vue';
import TileNav from '../components/TileNav.vue'

export default {
    components: {
        TileNav,
        PageTitle
    }
}
</script>
  
<style scoped>
.container {
    margin-top: 100px;
}

.logoContainer {
    height: 40vh;
    display: flex;
    justify-content: center;
    flex-direction: column;
    align-items: center;
}

.titleContainer {
    width: 300px;
}
</style>
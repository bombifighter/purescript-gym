<template>
    <h1>{{ title }}</h1>
</template>

<script>
export default {
    props: ['title']
}
</script>

<style scoped>
h1 {
    margin-top: 50px;
    margin-bottom: 50px;
    text-align: center;
}
</style>
<template>
  <div>
    <h1>Welcome to the flyers website!</h1>
  </div>
</template>

<script>
export default {
    name: "Topic",
    created() {
        console.log("yes");
        console.log(this.$route.params.id);
    }
}
</script>

<style>

</style>
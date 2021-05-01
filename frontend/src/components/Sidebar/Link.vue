<template>
<!-- TODO: fix path here -->
  <router-link :to="{path:`/topic/${id}`}"><slot/></router-link>
</template>

<script>
export default {
    name: "AppLink",
    props: {
        title: {
            type: String,
            required: true
        },
        id: {
            type: Number,
            required: true
        }
    }
}
</script>

<style>

</style>
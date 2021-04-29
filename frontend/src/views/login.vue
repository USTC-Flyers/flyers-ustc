<template>
  <div>
    <h1>login page</h1>
  </div>
</template>

<script>
export default {
  name: "Login",
  data() {
    return {
      // loginForm: {
      //   username: "test",
      //   password: "test",
      // },
      ticket: "fake-ticket",
    };
  },
  created() {
    this.$store
      .dispatch("user/login", this.ticket)
      .then(() => {
        this.$router.push({ path: this.redirect || "/" });
      })
      .catch(() => {
        console.log("login error");
      });
  },
};
</script>

<style></style>

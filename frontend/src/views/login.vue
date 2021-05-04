<template>
  <div>
    <h1>login page</h1>
  </div>
</template>

<script>
import login from "@/api/user";
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
    // this.$store
    //   .dispatch("user/login", this.ticket)
    //   .then(() => {
    //     this.$router.push({ path: this.redirect || "/" });
    //   })
    //   .catch(() => {
    //     console.log("login error");
    //   });
    this.loadingInstance = this.$loading({
      fullscreen: true,
    });
    this.$router.push({ path: this.redirect || "/" });
  },
  beforeMount() {
    const currentUrl = window.location.href;
    const serviceUrl = `http://home.ustc.edu.cn/~kelleykuang/cas/index.html?id=1`;
    if (currentUrl.includes('ticket')) {
      const ticket = currentUrl.match(/ticket=([\s\S]+?)&/)[1];
      login(ticket)
        .then((res) => {
          if (res.status === 200) {
            this.token = res.data.access;
            this.$store.commit('setToken', res.data.access);
          }
        });
    } else if (!this.$store.state.token) {
      const casUrl = `http://passport.ustc.edu.cn/login?service=${serviceUrl}`;
      window.location.href = casUrl;
    }
    setTimeout(() => {
      this.loadingInstance.close();
    }, 1000);
  },
};
</script>

<style></style>

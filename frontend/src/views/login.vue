<template>
  <div>
    <h2>跳转至登录页面中 请等待...</h2>
    <!-- <router-view></router-view> -->
  </div>
</template>

<script>
// import login from "@/api/user";
export default {
  name: "Login",
  data() {
    return {
      // loginForm: {
      //   username: "test",
      //   password: "test",
      // },
      // ticket: 'fake-ticket',
      redirect: undefined,
    };
  },
  // watch: {
  //   $route: {
  //     handler: function(route) {
  //       const query = route.query
  //       if (query.redirect) {
  //         this.redirect = query.redirect
  //       }
  //     },
  //     immediate: true
  //   }
  // },
  created() {
    // this.$store
    //   .dispatch("user/login", this.ticket)
    //   .then(() => {
    //     this.$router.push({ path: this.redirect || "/" });
    //   })
    //   .catch(() => {
    //     console.log("login error");
    //   });
  },
  beforeMount() {
    try {
      this.redirect = this.$route.query.redirect.fullPath || "/";
    } catch (e) {
      this.redirect = "/";
    }
    const currentUrl = window.location.href;
    if (currentUrl.includes("ticket")) {
      // const ticket = currentUrl.match(/\?ticket=([\s\S]+?)#/)[1];
      const ticket = currentUrl.match(/ticket=([\s\S]+)/)[1];
      this.$store
        .dispatch("user/login", ticket)
        .then(() => {
          this.$router.push({ path: this.redirect });
        })
        .catch(() => {
          console.log("login error");
        });
    } else if (!this.$store.state.token) {
      const is_test =
        process.env.NODE_ENV === "production" ? "/index.html" : "/debug.html";
      // const serviceUrl = `http://home.ustc.edu.cn/~ztl223/ca${is_test}?redirect=${this.redirect}`;
      // const casUrl = `http://passport.ustc.edu.cn/login?service=${serviceUrl}`;

      const serviceUrl = `https://www.ustcflyer.com/api/login`;
      const casUrl = `https://sso-proxy.lug.ustc.edu.cn/auth/default?service=${encodeURIComponent(serviceUrl)}`;
      window.location.href = casUrl;
    }
  },
};
</script>

<style></style>

<template>
  <div>
    <h1>login page</h1>
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
  },
  beforeMount() {
    const currentUrl = window.location.href;
    console.log(currentUrl);
    const serviceUrl = `http://home.ustc.edu.cn/~kelleykuang/cas/index.html?id=1`;
    if (currentUrl.includes("ticket")) {
      // const ticket = currentUrl.match(/\?ticket=([\s\S]+?)#/)[1];
      const ticket = currentUrl.match(/ticket=([\s\S]+)/)[1];
      console.log("get ticket");
      this.$store
        .dispatch("user/login", ticket)
        .then(() => {
          console.log("resp 200");
          this.$router.push({ path: this.redirect || "/" });
        })
        .catch(() => {
          console.log("login error");
        });
  //     //   // login(ticket).then((res) => {
  //     //   //   console.log('get token');
  //     //   //   if (res.status === 200) {
  //     //   //     this.token = res.data.access;
  //     //   //     this.$store.commit("setToken", res.data.access);
  //     //   //     this.$router.push("/");
  //     //   //   }
  //     //   // });
    } else if (!this.$store.state.token) {
      console.log("!this.$store.state.token");
      const casUrl = `http://passport.ustc.edu.cn/login?service=${serviceUrl}`;
      window.location.href = casUrl;
    }
  },
};
</script>

<style></style>

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
  beforeMount() {
    //   const currentUrl = window.location.href;
    //   console.log(currentUrl);
    //   const serviceUrl = `http://home.ustc.edu.cn/~kelleykuang/cas/index.html?id=1`;
    //   if (currentUrl.includes("ticket")) {
    //     const ticket = currentUrl.match(/\?ticket=([\s\S]+?)#/)[1];
    //     console.log("get ticket");
    //     this.$store
    //       .dispatch("user/login", ticket)
    //       .then(() => {
    //         console.log("resp 200");
    //         this.$router.push({ path: this.redirect || "/" });
    //       })
    //       .catch(() => {
    //         console.log("login error");
    //       });
    // //     //   // login(ticket).then((res) => {
    // //     //   //   console.log('get token');
    // //     //   //   if (res.status === 200) {
    // //     //   //     this.token = res.data.access;
    // //     //   //     this.$store.commit("setToken", res.data.access);
    // //     //   //     this.$router.push("/");
    // //     //   //   }
    // //     //   // });
    //   } else if (!this.$store.state.token) {
    //     const casUrl = `http://passport.ustc.edu.cn/login?service=${serviceUrl}`;
    //     window.location.href = casUrl;
    //   }
  },
  // beforeMount() {
  //   const currentUrl = window.location.href;
  //   const serviceUrl = `http://home.ustc.edu.cn/~kelleykuang/cas/index.html?id=1`;
  //   console.log(currentUrl);
  //   if (currentUrl.includes('ticket')) {
  //     const ticket = currentUrl.match(/ticket=([\s\S]+?)&/)[1];
  //     login(ticket)
  //       .then((res) => {
  //         if (res.status === 200) {
  //           this.token = res.data.access;
  //           this.$store.commit('setToken', res.data.access);
  //         }
  //       });
  //   } else if (!this.$store.state.token) {
  //     const casUrl = `http://passport.ustc.edu.cn/login?service=${serviceUrl}`;
  //     window.location.href = casUrl;
  //   }
  //   setTimeout(() => {
  //     this.loadingInstance.close();
  //     console.log("loading close");
  //   }, 1000);
  // },
  // beforeRouteEnter(to, from, next) {
  //   console.log(to, from);
  //   var toHasParams = !!Object.keys(to.query).length;
  //   var fromHasParams = !!Object.keys(from.query).length;
  //   if (!toHasParams && fromHasParams) {
  //     var toWithQuery = Object.assign({}, to, {query: from.query});
  //     next(toWithQuery);
  //   } else {
  //     next();
  //   }
  // },
};
</script>

<style></style>

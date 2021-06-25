import router from "./router";
import store from "./store";
// import { Message } from "element-ui";
import NProgress from "nprogress"; // progress bar
import "nprogress/nprogress.css"; // progress bar style
import { getToken } from "@/utils/auth"; // get token from cookie

NProgress.configure({ showSpinner: false }); // NProgress Configuration

const whiteList = ["/login", "/welcome"]; // no redirect whitelist
// const whiteList = ["/login"]; // no redirect whitelist

router.beforeEach(async (to, from, next) => {
  console.log(to, from);
  // start progress bar
  NProgress.start();

  // set page title

  // determine whether the user has logged in
  const hasToken = getToken();

  if (hasToken) {
    if (to.path === "/login") {
      // if is logged in, redirect to the home page
      next({ path: "/" });
      NProgress.done();
    } else if (to.path === "/create_user/initial") {
      next();
    } else {
      const hasGetUserInfo = store.getters.name;
      if (hasGetUserInfo) {
        next();
      } else {
        try {
          // get user info
          await store.dispatch("user/getInfo");

          next();
        } catch (error) {
          if(error.response.status === 404 ){
            next({ path: "/create_user/initial" });
            NProgress.done();
          }
          next();
          // remove token and go to login page to re-login
          // await store.dispatch("user/resetToken");
          // Message.error(error || "Has Error");
          // next(`/login?redirect=${to.path}`);
          // NProgress.done();
        }
      }
    }
  } else {
    /* has no token*/

    if (whiteList.indexOf(to.path) !== -1) {
      // in the free login whitelist, go directly
      next();
    } else {
      // other pages that do not have permission to access are redirected to the login page.
      // next(`/login?redirect=${to.path}`);
      if(to.query.ticket){
        next(`/login?redirect=${to.path}&ticket=${to.query.ticket}`);
      }
      else {
        next(`/login?redirect=${to.path}`);
      }
      NProgress.done();
    }
  }
});

router.afterEach(() => {
  // finish progress bar
  NProgress.done();
});

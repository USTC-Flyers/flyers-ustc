import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";
import Welcome from "@/components/Welcome.vue";
import Admission from "@/components/Admission.vue";
import Wiki from "@/components/Wiki.vue";
import Report_Admission from "@/components/Report_Admission.vue";
import UserMain from "@/userviews/UserMain.vue"
Vue.use(VueRouter);
const routes = [
  {
    path: "/login",
    component: () => import("@/views/login.vue"),
  },
  {
    path: "/create_user",
    component: () => import("@/userviews/Create_User.vue"),
  },
  {
    path: "/",
    redirect: "/home",
  },
  {
    path: "/home",
    component: Home,
    redirect: "/welcome",
    children: [
      { path: "/welcome", component: Welcome },
      { path: "/admission", component: Admission },
      { path: "/wiki", component: Wiki },
      { path: "/report_admission", component: Report_Admission },
      { path: "/usermain", component: UserMain },
    ],
  },
  // {
  //   path: "/about",
  //   name: "About",
  //   // route level code-splitting
  //   // this generates a separate chunk (about.[hash].js) for this route
  //   // which is lazy-loaded when the route is visited.
  //   component: () =>
  //     import(/* webpackChunkName: "about" */ "../views/About.vue"),
  // },
];

const router = new VueRouter({
  routes,
});

export default router;

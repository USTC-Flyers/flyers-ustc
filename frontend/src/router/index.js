import Vue from "vue";
import VueRouter from "vue-router";
// import Home from "../views/Home.vue";
// import Welcome from "@/components/Welcome.vue";
// import Admission from "@/components/Admission.vue";
// import Notification from "@/components/Notification.vue";
// import Wiki from "@/components/Wiki.vue";
// import Report_Admission from "@/components/Report_Admission.vue";
// import Topic from "@/components/Topic.vue";
// import AddTopic from "@/components/AddTopic.vue";
// import Revision from "@/components/Revision.vue";
// import UserMain from "@/userviews/UserMain.vue";
// import Review from "@/components/Review";
// import Rules from "@/components/Rules";
// import Subhome from "../views/Subhome";

Vue.use(VueRouter);
const routes = [
  {
    path: "/login",
    component: () => import("@/views/login.vue"),
  },
  {
    path: "/create_user/:is_initial",
    component: () => import("@/userviews/Create_User.vue"),
  },
  {
    path: "/",
    redirect: "/home",
  },
  {
    path: "/home",
    component: () => import("../views/Home.vue"),
    redirect: "/subhome",
    children: [
      {
        path: "/subhome",
        component: () => import("../views/Subhome"),
        redirect: "/welcome",
        children: [
          { path: "/welcome", component: () => import("@/components/Welcome.vue") },
          { path: "/rules", component: () => import("@/components/Rules.vue") },
          {
            path: "/admission",
            component: () => import("@/components/Admission.vue"),
            name: "admission",
          },
          {
            path: "/report_admission/:is_initial",
            name: "admission",
            component: () => import("@/components/Report_Admission.vue"),
          },
          {
            path: "/usermain/:id",
            component: () => import("@/userviews/UserMain.vue"),
          },
          {
            path: "/notificaiton",
            component: () => import("@/components/Notification.vue"),
          },
          {
            path: "/review/:id",
            component: () => import("@/components/Review.vue"),
          },
        ],
      },
      {
        path: "/wiki",
        component: () => import("@/components/Wiki.vue"),
        redirect: "/topic/3",
        children: [
          {
            path: "/add_topic/",
            component: () => import("@/components/AddTopic.vue"),
            meta: { keepAlive: false },
          },
          {
            path: "/topic/:id",
            name: "wiki",
            component: () => import("@/components/Topic.vue"),
            meta: { keepAlive: false },
          },
          {
            path: "/revision/:id",
            component: () => import("@/components/Revision.vue"),
            meta: { keepAlive: false },
          },
        ],
      },
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
  mode: "history",
  scrollBehavior (to, from, savedPosition) {
    return { x: 0, y: 0 }
  }
});

export function resetRouter() {
  const newRouter = new VueRouter({
    routes,
  });
  router.matcher = newRouter.matcher; // reset router
}

export default router;

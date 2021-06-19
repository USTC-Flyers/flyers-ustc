import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";
import Welcome from "@/components/Welcome.vue";
import Admission from "@/components/Admission.vue";
import Notification from "@/components/Notification.vue";
import Wiki from "@/components/Wiki.vue";
import Report_Admission from "@/components/Report_Admission.vue";
import Topic from "@/components/Topic.vue";
import AddTopic from "@/components/AddTopic.vue";
import Revision from "@/components/Revision.vue";
import UserMain from "@/userviews/UserMain.vue";
import Review from '@/components/Review';

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
    component: Home,
    redirect: "/welcome",
    children: [
      { path: "/welcome", component: Welcome },
      { path: "/admission", component: Admission },
      {
        path: "/wiki",
        component: Wiki,
        children: [
          { path: "/add_topic/", component: AddTopic, meta: { keepAlive: false } },
          { path: "/topic/:id", component: Topic, meta: { keepAlive: false } },
          {
            path: "/revision/:id",
            component: Revision,
            meta: { keepAlive: false },
          },
        ],
      },
      { path: "/report_admission/:is_initial", component: Report_Admission },
      { path: "/usermain/:id", component: UserMain },
      {
        path: "/notificaiton",
        component: Notification,
        children: [
          { path: "/topic/:id", component: Topic, meta: { keepAlive: false } },
          {
            path: "/topic_revision/:id",
            component: Revision,
            meta: { keepAlive: false },
          },
        ],
      },
      {
        path: "/review/:id", component: Review
      }
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
  mode: "history"
});

export function resetRouter() {
  const newRouter = new VueRouter({
    routes,
  });
  router.matcher = newRouter.matcher // reset router
}

export default router;

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
import Subhome from '../views/Subhome';

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
    redirect: "/subhome",
    children: [
      {
        path: "/subhome",
        component: Subhome,
        redirect:"/welcome",
        children: [
          { path: "/welcome", component: Welcome },
          { path: "/admission", component: Admission },
          { path: "/report_admission/:is_initial", component: Report_Admission },
          { path: "/usermain/:id", component: UserMain },
          {
            path: "/notificaiton",
            component: Notification,
          },
          {
            path: "/review/:id", component: Review
          },
        ],
      },      
      {
        path: "/wiki",
        component: Wiki,
        redirect: "/topic/3",
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

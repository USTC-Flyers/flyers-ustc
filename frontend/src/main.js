import Vue from "vue";
//
import "./views/vue.css";
import ElementUI from "element-ui";
import "element-ui/lib/theme-chalk/index.css";
import locale from "element-ui/lib/locale/lang/en"; // lang i18n
// import this package's
import "./assets/icon/iconfont.css";

import { ElementTiptapPlugin } from "element-tiptap";

import App from "./App";
import store from "./store";
import router from "./router";

import "@/permission"; // permission control

/**
 * If you don't want to use mock-server
 * you want to use MockJs for mock api
 * you can execute: mockXHR()
 *
 * Currently MockJs will be used in the production environment,
 * please remove it before going online ! ! !
 */
//  const { mockXHR } = require('../mock')
//  mockXHR()

// set ElementUI lang to EN
Vue.use(ElementUI, { locale });
// var echarts = require('echarts')
// 如果想要中文版 element-ui，按如下方式声明
// Vue.use(ElementUI)

Vue.use(ElementTiptapPlugin);
// 现在你已经在全局注册了 `el-tiptap` 组件。

Vue.config.productionTip = false;

new Vue({
  el: "#app",
  router,
  store,
  render: (h) => h(App),
});

<template>
  <div class="app">
    <div class="aside">
      <div class="aside-inner">
        <router-link v-if="$store.getters.is_admin" :to="`/add_topic/`">
          <el-button
            type="warning"
            size="small"
            style="margin: 0px 0px 5px 75px"
            icon="el-icon-circle-plus"
            id="create-wiki"
            >新建 Wiki</el-button
          >
        </router-link>
        <sidebar></sidebar>
      </div>
    </div>
    <div class="content">
      <div class="main-content" :style="{ minHeight: minHeight + 'px' }">
        <keep-alive>
          <router-view v-if="$route.meta.keepAlive">
            <!-- 这里是会被缓存的视图组件，比如 Home！ -->
          </router-view>
        </keep-alive>

        <router-view v-if="!$route.meta.keepAlive">
          <!-- 这里是不被缓存的视图组件，比如 Edit！ -->
        </router-view>
      </div>
      <div class="footer">
        <el-divider></el-divider>
        <router-link
          :to="{
            path: '/welcome',
            hash: 'contact',
          }"
        >
          <el-button type="text"> 联系我们 </el-button>
        </router-link>
        <el-divider direction="vertical"></el-divider>
        <router-link
          :to="{
            path: '/rules',
          }"
        >
          <el-button type="text"> 社区规则 </el-button>
        </router-link>
        <div>Copyright &copy; 2021-2022 USTC飞跃网站</div>
      </div>
    </div>
  </div>
</template>

<script>
import Sidebar from "./Sidebar";
export default {
  name: "Wiki",
  components: {
    Sidebar,
  },
  data() {
    return {
      minHeight: 0,
    };
  },
  mounted() {
    this.minHeight = document.documentElement.clientHeight - 285;
    var that = this;
    window.onresize = function () {
      this.minHeight = document.documentElement.clientHeight - 285;
    };
  },
};
</script>

<style scoped>
.app {
  position: static;
  overflow-x: hidden;
  padding: 0 60px 30px;
  z-index: 1;
}
.aside {
  /* width 19% 总宽度不足100%时中间会空出来 */
  top: 45px;
  left: 0;
  bottom: 0;
  position: fixed;
  overflow-y: auto;
  overflow-x: auto;
  z-index: 10;
  /* -webkit-overflow-scrolling: touch; */
  /* -ms-overflow-style: none; */
  /*如果height 100%侧边栏将无法滚动，而且展开收起条目时下边框会上下跟随移动  */
}
.aside-inner {
  display: block;
  min-width: 260px;
  max-width: 260px;
  padding: 35px 0px 10px 10px;
  /* padding 上右下左 */
}
.content {
  display: block;
  position: relative;
  padding: 5px 0;
  max-width: 1100px;
  margin: 0px 20px 20px 20px;
  padding-left: 320px;
}
#create-wiki {
  background: rgb(255, 255, 255);
  color: rgb(105, 105, 105);
  border-color: rgb(151, 151, 151);
}
.footer {
  height: 60px;
  padding-left: 0px;
  width: 850px;
  /* margin-top: -88px;  */
  /* position: fixed;
  bottom: 0;
  left: 260px;
  width:900px */
}
</style>

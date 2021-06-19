<template>
  <div class="app">
    <div class="aside">
      <div class="aside-inner">
        <router-link
        :to="`/add_topic/`"
        >
        <el-button
          type="warning"
          size="small"
          style="margin: 0px 0px 5px 75px"
          icon="el-icon-circle-plus"
          id="create-wiki"
          >新建 WIKI</el-button
        >
        </router-link>
        <sidebar></sidebar>
      </div>
    </div>
    <div class="content">
      <keep-alive>
        <router-view v-if="$route.meta.keepAlive">
          <!-- 这里是会被缓存的视图组件，比如 Home！ -->
        </router-view>
      </keep-alive>

      <router-view v-if="!$route.meta.keepAlive">
        <!-- 这里是不被缓存的视图组件，比如 Edit！ -->
      </router-view>
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
};
</script>

<style scoped>
.app{
 
  position:static;
  overflow-x:hidden;
  padding:0 60px 30px;
  z-index: 1;
}
.aside {
  /* width 19% 总宽度不足100%时中间会空出来 */
  top:45px;
  left:0;
  bottom:0;
  position:fixed;
  overflow-y:auto;
  overflow-x: hidden;
  z-index: 10;
  /* -webkit-overflow-scrolling: touch; */
  /* -ms-overflow-style: none; */
 /*如果height 100%侧边栏将无法滚动，而且展开收起条目时下边框会上下跟随移动  */
}
.aside-inner{
  display:block;
  width:260px;
  padding:35px 0px 10px 10px;
  /* padding 上右下左 */
}
.content {
  display: block;
  position:relative;
  padding:5px 0;
  max-width: 700px;
  margin:0 auto;
  padding-left:10px;
}
#create-wiki{
  background:rgb(255, 255, 255);
  color:rgb(105, 105, 105);
  border-color: rgb(151, 151, 151);
}
</style>

<template>
  <div class="app">
    <div class="aside">
      <router-link
      :to="`/add_topic/`"
      >
      <el-button
        type="warning"
        size="small"
        style="margin: 0px 0px 5px 75px"
        icon="el-icon-circle-plus"
        >新建 WIKI</el-button
      >
    </router-link>
      <sidebar></sidebar>
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
  width: 100%;
  height: 100%;
  float: left;
  display: flex;
}
.aside {
  width: 250px;
  height: 100%;
}
.content {
  margin: 0 auto;
  width: 750px;
  height: 100%;
}
</style>

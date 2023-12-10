<template>
  <div class="subhome-container">
    <router-view
        class="subhome-content"
        v-if="isRouterAlive"
        :style="{ minHeight: minHeight + 'px' }"
    ></router-view>
    <div class="footer">
      <el-divider></el-divider>
      <router-link
          :to="{
          path: '/welcome',
          hash: 'contact',
        }"
      >
        <el-button type="text"> 联系我们</el-button>
      </router-link>
      <el-divider direction="vertical"></el-divider>
      <router-link
          :to="{
          path: '/rules',
        }"
      >
        <el-button type="text"> 社区规则</el-button>
      </router-link>
      <div>Copyright &copy; 2021-2023 USTC飞跃网站</div>
    </div>
  </div>
</template>
<script>
export default {
  name: "Subhome",
  data() {
    return {
      isRouterAlive: true,
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
.subhome-container {
  padding-top: 30px;
  background: #FFFFFF;
}

.footer {
  bottom: 20px;
  top: 120px;
  /* height: 10px; */
  /* padding: 1px; */
  margin: 20px 1px 1px 1px;
}
</style>

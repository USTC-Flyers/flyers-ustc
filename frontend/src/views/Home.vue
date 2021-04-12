<template>
  <!-- <img alt="Vue logo" src="../assets/logo.png" />
    <HelloWorld msg="Welcome to Your Vue.js App" /> -->
  <el-container class="home-container">
    <el-header>
      <el-menu mode="horizontal" router>
        <el-menu-item index="1">录取汇报</el-menu-item>
        <el-menu-item index="2">申请 WIKI</el-menu-item>
      </el-menu>
      <el-menu mode="horizontal">
          <template slot="title">{{submenus.title}}</template>
          <el-menu-item v-for="(item, subIndex) in submenus.menus"
            :index="(index + 1) + '-' + (subIndex + 1)"
            :key="item.key">
              {{item.title}}
          </el-menu-item>
        </el-submenu>
      </el-menu>
      
      <el-button type="text" icon="el-icon-user-solid">用户名</el-button>
    </el-header>
    <div class="line"></div>
    <el-container>
      <!-- <el-aside width="200px">Aside</el-aside>
      <el-main>Main</el-main> -->
      <router-view></router-view>
    </el-container>
  </el-container>
</template>

<script>
// @ is an alias to /src
// import HelloWorld from "@/components/HelloWorld.vue";

export default {
  name: "Home",
  data() {
      return {
        activeIndex: '1',
      };
    }
  // components: {
  //   HelloWorld,
  // },
};
</script>

<style scoped>
.home-container {
  height: 100vh;
}
.el-header {
  /* background-color: #409eff; */
  display: flex;
  justify-content: space-between;
}

/* .el-aside {
  background-color: #409eff;
} */
</style>

<template>
  <!-- <img alt="Vue logo" src="../assets/logo.png" />
    <HelloWorld msg="Welcome to Your Vue.js App" /> -->
  <el-container class="home-container">
    <el-header>
      <el-menu :default-active="this.$route.path" mode="horizontal" router>
        <el-menu-item index="/admission" router>录取汇报</el-menu-item>
        <el-menu-item index="/wiki" router>申请 WIKI</el-menu-item>
      </el-menu>
      <!-- <el-menu mode="horizontal">
          <template slot="title">{{submenus.title}}</template>
          <el-menu-item v-for="(item, subIndex) in submenus.menus"
            :index="(index + 1) + '-' + (subIndex + 1)"
            :key="item.key">
              {{item.title}}
          </el-menu-item>
        </el-submenu>
      </el-menu> -->

      <el-button type="text" icon="el-icon-user-solid">{{
        username
      }}</el-button>
    </el-header>
    <el-container class="main">
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
      activeIndex: "",
    };
  },
  computed: {
    username() {
      return this.$store.getters.name;
    },
  },
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
.main {
  margin: auto;
  margin-top: 30px;
  width: 90%;
}
/* .el-aside {
  background-color: #409eff;
} */
</style>

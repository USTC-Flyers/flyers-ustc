<template>
  <div id="app">
    <router-view />
  </div>
</template>

<script>
export default {
  name: "App",
};
</script>

<style>
#app {
  height: 100%;
  box-sizing: border-box;
}

body .el-table th.gutter {
  display: table-cell !important;
}
</style>

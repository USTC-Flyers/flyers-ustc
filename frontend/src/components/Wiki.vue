<template>
    <el-container>
      <el-aside>
        <sidebar></sidebar>
      </el-aside>
      <el-main>
        <router-view></router-view>
      </el-main>
    </el-container>
</template>

<script>
import Sidebar from './Sidebar';
export default {
    name: "Wiki",
    components: {
        Sidebar,
    }
}
</script>

<style>

</style>
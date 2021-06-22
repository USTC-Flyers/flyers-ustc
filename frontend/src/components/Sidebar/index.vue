<template>
  <el-scrollbar wrap-class="scrollbar-wrapper">
    <el-menu
      default-active="/topic/1"
      :default-openeds="openeds"
      :unique-opened="false"
      :collapse-transition="true"
      mode="vertical"
      router
    >
      <sidebar-item
        v-for="(title, index) in title_list"
        :key="index"
        :item="title"
        :index="index"
      />
    </el-menu>
  </el-scrollbar>
</template>

<script>
import SidebarItem from "./SidebarItem";
import { getTopicMeta } from "@/api/wiki";
export default {
  components: {
    SidebarItem,
  },
  data() {
    return {
      title_list: null,
      openeds: ['0'],
    };
  },
  created() {
    getTopicMeta().then((resp) => {
      console.log(resp);
      this.title_list = resp.title;
    });
  },
};
</script>

<style>
.scrollbar-wrapper {
  overflow-x: auto ;
}
/* .el-submenu__title{
  font-size:20px;
  font-weight:400;
} */
/* .el-menu-item{
  font-size:17px;
} */
</style>

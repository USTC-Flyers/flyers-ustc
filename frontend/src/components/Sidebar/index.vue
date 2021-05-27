<template>
  <el-scrollbar wrap-class="scrollbar-wrapper">
    <el-menu
      :default-active="'0-1'"
      :unique-opened="true"
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
  overflow-x: hidden !important;
}
</style>

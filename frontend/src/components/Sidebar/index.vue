<template>
  <el-scrollbar wrap-class="scrollbar-wrapper">
      <el-menu
        :unique-opened="true"
        :collapse-transition="true"
        mode="vertical"
      >
        <sidebar-item v-for="title in title_list" :key="title.category" :item="title"/>
      </el-menu>
  </el-scrollbar>
</template>

<script>
import SidebarItem from './SidebarItem';
import {getTopicMeta} from "@/api/wiki";
export default {
    components: {
        SidebarItem
    },
    data() {
        return {
            title_list: null
        }
    },
    created() {
        console.log('get meta!');
        getTopicMeta().then((resp) => {
            this.title_list = resp.title;
            console.log('get meta!');
        })
    }
    }

</script>

<style>
.scrollbar-wrapper {
    overflow-x: hidden !important;
}
</style>
<template>
  <el-submenu :index="index+''">
      <template slot="title">{{ item.category }}</template>
      <el-menu-item v-for="topic in item.topics" :key="topic.id" :index="`/topic/${topic.id}`" :route="{path: `/topic/${topic.id}`}">{{ topic.title }}</el-menu-item>
      <!-- <app-link v-for="topic in item.topics" :key="topic.id" :title="topic.title" :id="topic.id">
          <el-menu-item :index="index+'-'+topic.id">
              {{ topic.title }}
          </el-menu-item>
      </app-link> -->
  </el-submenu>
</template>

<script>
// import AppLink from './Link'

export default {
    name: 'SidebarItem',
    // components: {
    //     AppLink
    // },
    props: {
        item: {
            type: Object,
            required: true
        },
        index: {
            type: Number,
            required: true
        }
    }
}
</script>

<style>

</style>
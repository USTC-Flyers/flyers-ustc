<template>
  <el-submenu :index="index">
      <template slot="title">{{ item.category }}</template>
      <app-link v-for="topic in item.topics" :key="topic.id" :title="topic.title" :id="topic.id">
          <el-menu-item :index="topic.id">
              {{ topic.title }}
          </el-menu-item>
      </app-link>
  </el-submenu>
</template>

<script>
import AppLink from './Link'

export default {
    name: 'SidebaarItem',
    components: {
        AppLink
    },
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
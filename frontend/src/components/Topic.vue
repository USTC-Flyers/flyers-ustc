<template>
  <div>
    <router-link :to="{ path: `/revision/${topic_id}` }">
      <el-button type="text" size="default" style="margin-bottom: 20px"
        >修改内容</el-button
      >
    </router-link>
    <div v-html="content" />
  </div>
</template>

<script>
import { getTopic } from "@/api/wiki";
export default {
  name: "Topic",
  data() {
    return {
      topic_id: null,
      content: "",
    };
  },
  created() {
    this.topic_id = this.$route.params.id;
    this.getTopicContent();
  },
  methods: {
    getTopicContent() {
      getTopic(this.topic_id).then((response) => {
        this.content = response.current_version.content;
      });
    },
  },
  beforeRouteUpdate(to, from, next) {
    this.topic_id = to.params.id;
    this.getTopicContent();
    next();
  },
};
</script>

<style></style>

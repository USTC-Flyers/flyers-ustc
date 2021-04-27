<template>
  <div>
    <div v-html="content"></div>
    <blog></blog>
  </div>
</template>

<script>
import Blog from "./Blog"
import getAllTopic from "@/api/wiki"
export default {
  name: "Wiki",
  components: {
    blog: Blog
  },
  props
  data() {
    return {
      content: '<h1>Title</h1>\n<p>content</p>'
    }
  },
  created() {
    this.getTopics()
  },
  methods: {
    getTopics() {
      getAllTopic().then((res) => {
        
      }).catch((err) => {
        
      });
    }
  },
};
</script>

<style></style>

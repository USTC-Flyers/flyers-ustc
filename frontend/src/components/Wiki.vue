<template>
  <div>
    <div v-html="content"></div>
  </div>
</template>

<script>
import {getAllTopic, getTopic} from "@/api/wiki"
export default {
  name: "Wiki",
  components: {
    blog: Blog
  },
  props: {
    id: Number
  },
  data() {
    return {
      // !FIXME: scirpt in html check
      content: '<h1>Title</h1>\n<p>content</p>'
    }
  },
  created() {
    this.getData(this.id)
  },
  methods: {
    getData(id) {
      getTopic(id).then((res) => {
        this.content = res.current_version.content
      }).catch((err) => {
        console.log(err);
      });
    }
  },
};
</script>

<style></style>

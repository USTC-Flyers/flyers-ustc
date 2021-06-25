<template>
  <div class="codediff">
    <div>WIKI 标题</div>
    <code-diff
      :old-string="old_title"
      :new-string="new_title"
      :context="10"
      outputFormat="side-by-side"
    />
    <div>WIKI 内容</div>
    <code-diff
      :old-string="old_content"
      :new-string="new_content"
      :context="10"
      outputFormat="side-by-side"
    />
    <el-button type="primary" @click="revisionAp">通过</el-button>
    <el-button type="warning" @click="revisionRej">不通过</el-button>
  </div>
</template>
<script>
import CodeDiff from "vue-code-diff";
import {
  getTopicRevision,
  getTopic,
  approveTopic,
  rejectTopic,
} from "@/api/wiki";

export default {
  name: "Review",
  components: {
    CodeDiff,
  },
  data() {
    return {
      revision_id: null,
      old_content: "",
      new_content: "",
      old_title: "",
      new_title: "",
      status: null,
      topic_id: null,
    };
  },
  created() {
    this.revision_id = this.$route.params.id;
    getTopicRevision(this.revision_id)
      .then((resp) => {
        this.new_title = resp.title;
        this.new_content = resp.content;
        this.status = resp.status;
        this.topic_id = resp.related_topic;
        getTopic(this.topic_id).then((resp) => {
          this.old_content = resp.current_version.content;
          this.old_title = resp.current_version.title;
        });
      })
      .catch((err) => {
        console.log(err);
      });
  },
  methods: {
    revisionAp: function() {
      approveTopic(this.revision_id)
        .then(() => {
          this.$message.success("审核完成，修改通过");
          this.$router.push({ path: "/topic/" + this.topic_id }, () => {});
        })
        .catch((err) => {
          console.log(err);
        });
    },
    revisionRej: function() {
      rejectTopic(this.revision_id)
        .then(() => {
          this.$message.success("审核完成，修改未通过");
          this.$router.push({ path: "/topic/" + this.topic_id }, () => {});
        })
        .catch((err) => {
          console.log(err);
        });
    },
  },
};
</script>
<style scoped>
.codediff {
  margin: 5%;
  margin-top: 0%;
}
</style>

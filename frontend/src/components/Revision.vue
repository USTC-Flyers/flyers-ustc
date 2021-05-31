<template>
  <div>
    <el-input v-model="title"></el-input>
    <tiptap-editor
      v-model="content"
      placeholder="请输入文章内容"
      height="800"
    />
    <el-button type="primary" @click="submitForm" style="margin-top:30px">提交</el-button>
  </div>
</template>

<script>
// import Editor from "@tinymce/tinymce-vue";
import TiptapEditor from "./TiptapEditor"
import { getTopic, updateTopic } from "@/api/wiki";
export default {
  name: "Revision",
  components: {
    TiptapEditor,
  },
  data() {
    return {
      topic_id: null,
      revision_id: null,
      title: "",
      content: "",
    };
  },
  created() {
    console.log("yes", this.$route.params.id);
    this.topic_id = this.$route.params.id;
    getTopic(this.topic_id).then((response) => {
      this.title = response.current_version.title;
      this.content = response.current_version.content;
      this.revision_id = response.current_version.id;
    });
  },
  methods: {
    submitForm() {
      updateTopic(this.revision_id, { title: this.title, content: this.content }).then(() => {
        this.$message.success("更新成功");
        this.$router.go(-1);
      });
    },
  },
};
</script>

<style></style>

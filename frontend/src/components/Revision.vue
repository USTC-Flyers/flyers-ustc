<template>
  <div>
    <el-input v-model="title" id="wiki-title"></el-input>
    <tiptap-editor
      v-model="content"
      placeholder="请勿使用一级标题(Heading 1)，从Heading 2开始使用"
      height="550"
      id="tiptap-editor"
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
      updateTopic(this.topic_id, { title: this.title, content: this.content }).then(() => {
        this.$message.success("更新成功");
        this.$router.go(-1);
      });
    },
  },
};
</script>

<style>
#wiki-title {
  display: block;
  font-size: 2em;
  margin-block-start: 0.67em;
  margin-block-end: 0.67em;
  margin-inline-start: 0px;
  margin-inline-end: 0px;
  font-weight: bold;
  width:1020px;
  
}
#tiptap-editor{
  width:1020px;
}
</style>

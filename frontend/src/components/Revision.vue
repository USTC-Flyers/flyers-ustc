<template>
  <div>
    <editor
      api-key="skusgmkyvt20zw0c6ywi9swko5p3gzo7wzhdaaizwbbor7tx"
      :init="{
        height: 450,
        menubar: false,
        plugins: [
          'autolink lists link image preview fullscreen table help wordcount',
        ],
        toolbar:
          'undo redo | formatselect | bold italic backcolor | \
                    bullist numlist outdent indent | preview | removeformat | table | help',
      }"
      placeholder="申请季感言，套磁、文书、面试、英语、中介等各方面的经验与建议"
      v-model="content"
    />
    <el-button type="primary" @click="submitForm">提交</el-button>
  </div>
</template>

<script>
// import Editor from "@tinymce/tinymce-vue";
import { getTopic, updateTopic } from "@/api/wiki";
export default {
  name: "Revision",
  // components: {
  //   Editor,
  // },
  data() {
    return {
      topic_id: null,
      revision_id: null,
      content: "",
    };
  },
  created() {
    console.log("yes", this.$route.params.id);
    this.topic_id = this.$route.params.id;
    getTopic(this.topic_id).then((response) => {
      this.content = response.current_version.content;
      this.revision_id = response.current_version.id;
    });
  },
  methods: {
    submitForm() {
      updateTopic(this.revision_id, { content: this.content }).then(() => {
        this.$message.success("更新成功");
        this.$router.go(-1);
      });
    },
  },
};
</script>

<style></style>

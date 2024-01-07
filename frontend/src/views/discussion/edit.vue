<template>
  <div class="create-container">
    <el-form ref="createForm"
             :model="form"
             :rules="rules"
    >
      <h1 class="title">写点什么</h1>
      <el-form-item prop="title">
        <el-input
            v-model="form.title"
            type="text"
            placeholder="请输入帖子标题"
        />
      </el-form-item>
      <el-form-item prop="content">
        <tiptap-editor v-model="form.content" :extensions="extensions" placeholder="随便写点什么吧~"/>
      </el-form-item>
      <el-form-item>
        <el-button @click="submitCreate" :disabled="publishing" :loading="publishing" type="primary">发表帖子
        </el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import {createPost, getPost, updatePost, uploadImg} from "@/api/discussion";
import TiptapEditor from "@/components/TiptapEditor/index.vue";
import {
  Blockquote,
  Bold, BulletList,
  Doc,
  Heading, History,
  HorizontalRule, Image,
  Indent,
  Italic, Link, ListItem, OrderedList,
  Paragraph,
  Strike,
  Text,
  TextAlign,
  Underline
} from "element-tiptap";
import axios from "axios";

export default {
  components: {TiptapEditor},
  data() {
    return {
      publishing: false,
      form: {
        title: '',
        content: '',
        images: [],
      },
      rules: {
        title: [
          {
            required: true, message: "请输入标题", trigger: "blur", transform(value) {
              return value.trim();
            },
          },
        ],
        content: [
          {
            required: true, message: "请输入你要发表的内容", trigger: "blur", transform(value) {
              return value.trim();
            }
          },
        ],
      },
      extensions: [
        new Doc(),
        new Text(),
        new Paragraph(),
        new Heading({level: 5}),
        new Bold({bubble: true}),
        new Underline({bubble: true}),
        new Italic(),
        new Strike(),
        new HorizontalRule(),
        new Indent(),
        new TextAlign(),
        new Blockquote(),
        new Image({
          uploadRequest: async file => {
            const uploadArg = await uploadImg();
            const {host, ...otherParams} = uploadArg;
            const formData = new FormData();
            for (const key in otherParams) {
              formData.set(key, otherParams[key]);
            }
            formData.set('success_action_status', 201);
            formData.append('file', file);
            await axios.post(host, formData);
            return host + '/' + otherParams.key;
          }
        }),
        new Link(),
        new ListItem(),
        new BulletList(),
        new OrderedList(),
        new History(),
      ]
    };
  },
  computed: {
    isEdit() {
      return !!this.$route.params.id;
    },
  },
  methods: {
    async initData(id) {
      const res = await getPost(id)
      this.form = {
        title: res.title,
        content: res.content,
        images: res.images,
      }
    },
    async submitCreate() {
      if (this.publishing) {
        return
      }
      this.$refs.createForm.validate(async valid => {
        if (valid) {
          this.publishing = true;
          try {
            if (this.isEdit) {
              await updatePost(this.$route.params.id, {
                ...this.form,
              });
            } else {
              await createPost(this.form)
            }
            this.$message.success("发布成功！");
            this.$router.back();
          } catch (e) {
            console.error(e)
            this.$message.error("发布失败")
          } finally {
            this.publishing = false
          }
        }
      })
    },
  },
  mounted() {
    if (this.$route.params.id) {
      this.initData(this.$route.params.id);
    }
  }
};
</script>

<style lang="scss" scoped>
.create-container {
  background: #FFFFFF;
  padding: 16px;
}
</style>
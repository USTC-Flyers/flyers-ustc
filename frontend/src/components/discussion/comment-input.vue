<template>
  <div class="comment-form">
    <div class="comment-create">
      <div ref="commentEditor" class="comment-input-wrapper">
        <div v-if="quote" class="comment-quote-info">
          回复：
          <label v-text="quote.user.username"/>
          <i class="iconfont icon-close" alt="取消回复" @click="cancelReply"/>
        </div>
        <text-editor ref="simpleEditor" v-model="value" @submit="create"/>
      </div>
    </div>
  </div>
</template>

<script>
import TextEditor from "@/components/discussion/text-editor.vue";
import {comment} from "@/api/discussion";

export default {
  components: {TextEditor},
  props: {
    postId: {
      type: Number,
      required: true,
    },
  },
  data() {
    return {
      value: '',
      sending: false,
      quote: null,
    }
  },
  computed: {
    btnName() {
      return this.sending ? '正在发表...' : '评论'
    },
  },
  methods: {
    async create() {
      if (!this.value) {
        this.$message.error('请输入评论内容')
        return
      }
      if (this.sending) {
        return
      }
      this.sending = true
      try {
        const data = await comment({
          post_id: this.postId,
          content: this.value,
          comment_id: this.quote ? this.quote.id : null
        })
        this.value = '';
        this.quote = null
        this.$refs.simpleEditor.clear()
        this.$message.success('评论成功')
        this.$emit('created', data)
      } catch (e) {
        console.error(e)
        this.$message.error(e.message || e)
      } finally {
        this.sending = false
      }
    },
    reply(quote) {
      this.quote = quote
      this.$refs.commentEditor.scrollIntoView({
        block: 'start',
        behavior: 'smooth',
      })
    },
    cancelReply() {
      this.quote = null
    },
  },
}
</script>

<style scoped lang="scss">
.comment-form {
  background-color: var(--bg-color);
  margin-bottom: 10px;

  .comment-create {
    border-radius: 4px;
    overflow: hidden;
    position: relative;
    padding: 0;
    box-sizing: border-box;

    .comment-quote-info {
      font-size: 13px;
      color: var(--text-color);
      margin-bottom: 3px;
      font-weight: 600;

      i {
        font-size: 12px !important;
        color: var(--text-link-color);
        cursor: pointer;
      }

      i:hover {
        color: red;
      }
    }

    .comment-input-wrapper {
      margin-bottom: 8px;

      .text-input {
        outline: none;
        width: 100%;
        height: 85px;
        font-size: 14px;
        padding: 10px 40px 10px 10px;
        color: var(--text-color);
        line-height: 16px;
        max-width: 100%;
        resize: none;
        border: 1px solid var(--border-color);
        box-sizing: border-box;
        border-radius: var(--jinsom-border-radius);
      }
    }

    .comment-button-wrapper {
      user-select: none;
      display: flex;
      float: right;
      height: 30px;
      line-height: 30px;

      span {
        color: var(--text-color4);
        font-size: 13px;
        margin-right: 5px;
      }

      button {
        font-weight: 500;
      }
    }
  }
}
</style>
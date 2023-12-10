<template>
  <div class="replies">
    <div
        v-for="comment in replies"
        :key="comment.id"
        class="comment"
    >
      <div class="comment-item-main">
        <div class="comment-meta">
          <div>
            <span class="comment-nickname">
              {{ comment.related_user.username }}
            </span>
          </div>
          <time
              class="comment-time"
          >{{ comment.created_time | formatDate }}
          </time
          >
        </div>
        <div
            class="comment-content-wrapper"
        >
          <div class="comment-content content">
            <div v-html="comment.content"/>
          </div>
        </div>
<!--        <div class="comment-actions">-->
<!--          <div-->
<!--              class="comment-action-item"-->
<!--              :class="{ active: comment.liked }"-->
<!--              @click="like(comment)"-->
<!--          >-->
<!--            <i class="el-icon-star-off"></i>-->
<!--            <span>喜欢</span>-->
<!--            <span v-if="comment.likeCount > 0">{{ comment.likeCount }}</span>-->
<!--          </div>-->
<!--          <div-->
<!--              class="comment-action-item"-->
<!--              :class="{ active: reply.commentId === comment.id }"-->
<!--              @click="switchShowReply(comment)"-->
<!--          >-->
<!--            <i class="el-icon-chat-dot-square"></i>-->
<!--            <span>{{-->
<!--                reply.commentId === comment.id ? '取消评论' : '评论'-->
<!--              }}</span>-->
<!--          </div>-->
<!--        </div>-->
        <div
            v-if="reply.commentId === comment.id"
            class="comment-reply-form"
        >
          <text-editor
              :ref="`editor${comment.id}`"
              v-model="reply.content"
              :height="80"
              @submit="submitReply"
          />
        </div>
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
    commentId: {
      type: Number,
      required: true,
    },
    data: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      replies: this.data,
      reply: {
        commentId: 0,
        content: '',
      },
    }
  },
  methods: {
    async like(comment) {
      try {
        await this.$axios.post(`/api/comment/like/${comment.commentId}`)
        comment.liked = true
        comment.likeCount = comment.likeCount + 1
        this.$message.success('点赞成功')
      } catch (e) {
        if (e.errorCode === 1) {
          this.$msgSignIn()
        } else {
          this.$message.error(e.message || e)
        }
      }
    },
    switchShowReply(comment) {
      if (this.reply.commentId === comment.id) {
        this.hideReply(comment)
      } else {
        this.reply.commentId = comment.id
        setTimeout(() => {
          this.$refs[`editor${comment.id}`][0].focus()
        }, 0)
      }
    },
    hideReply() {
      this.reply.commentId = 0
      this.reply.content = ''
    },
    async submitReply() {
      try {
        const ret = await comment({
          post_id: this.postId,
          comment_id: this.commentId,
          content: this.reply.content,
        })
        this.hideReply()
        this.$emit('reply', ret)
        this.$message.success('回复成功')
      } catch (e) {
        console.error(e);
      }
    },
  },
}
</script>
<style lang="scss" scoped>
.replies {
  margin-top: 10px;
  padding: 1px 10px;
  font-size: 12px;
  background-color: var(--bg-color2);

  .comment {
    display: flex;
    padding: 8px 0;

    &:not(:last-child) {
      border-bottom: 1px solid var(--border-color);
    }

    .comment-item-main {
      flex: 1 1 auto;
      margin-left: 8px;

      .comment-meta {
        display: flex;
        justify-content: space-between;

        .comment-nickname {
          font-size: 12px;
          font-weight: 600;
          color: var(--text-color);

          &:hover {
            color: var(--text-link-color);
          }
        }

        .comment-time {
          font-size: 11px;
          color: var(--text-color3);
        }
      }

      .comment-content-wrapper {
        .comment-content {
          margin-top: 5px;
          margin-bottom: 0;
          color: var(--text-color2);
          white-space: pre-wrap;
        }


        .comment-quote {
          position: relative;
          background-color: var(--bg-color3);
          border: 1px solid var(--border-color2);
          color: var(--text-color3);
          padding: 0 12px;
          margin: 5px 0;
          box-sizing: border-box;
          border-radius: 4px;

          &::after {
            position: absolute;
            content: '\201D';
            font-family: Georgia, serif;
            font-size: 36px;
            font-weight: bold;
            color: var(--text-color3);
            right: 2px;
            top: -8px;
          }

          .comment-quote-content {
            margin: 5px 0;
            color: var(--text-color3);
          }

        }
      }

      .comment-actions {
        margin-top: 5px;
        display: flex;
        align-items: center;

        .comment-action-item {
          line-height: 22px;
          font-size: 11px;
          cursor: pointer;
          color: var(--text-color3);
          user-select: none;

          &:hover {
            color: var(--text-link-color);
          }

          &.active {
            color: var(--text-link-color);
            font-weight: 500;
          }

          &:not(:last-child) {
            margin-right: 16px;
          }
        }
      }

      .comment-reply-form {
        margin-top: 10px;
      }
    }
  }

  .reply {
    display: flex;
  }

  .comment-more {
    margin: 10px;
    font-size: 13px;
    font-weight: 500;
    color: var(--text-link-color);
  }
}
</style>
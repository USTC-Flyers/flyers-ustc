<template>
  <div class="comments">
    <load-more
        ref="commentsLoadMore"
        v-slot="{results}"
        :params="{ post_id: postId }"
        :page-method="pageMethod"
    >
      <div v-for="comment in results" :key="comment.id" class="comment">
        <div class="comment-item-main">
          <div class="comment-meta">
            <span class="comment-nickname">
              {{ comment.related_user.username }}
            </span>
            <div class="comment-meta-right">
              <span
                  class="comment-time"
              >{{ comment.created_time |prettyDate }}
              </span
              >
            </div>
          </div>
          <div class="comment-content-wrapper">
            <div
                class="comment-content content"
                v-text="comment.content"
            />
          </div>
          <div class="comment-actions">
            <div
                class="comment-action-item"
                :class="{ active: comment.liked }"
                @click="like(comment)"
            >
              <i :class="`${comment.liked?'el-icon-star-on checked-icon':'el-icon-star-off'}`"></i>
              <span>喜欢</span>
              <span v-if="comment.likeCount > 0">{{ comment.likeCount }}</span>
            </div>
            <div
                class="comment-action-item"
                :class="{ active: reply.commentId === comment.id }"
                @click="switchShowReply(comment)"
            >
              <i class="el-icon-chat-dot-square"></i>
              <span>{{
                  reply.commentId === comment.id ? '取消评论' : '评论'
                }}</span>
            </div>
          </div>
          <div
              v-if="reply.commentId === comment.id"
              class="comment-reply-form"
          >
            <text-editor
                :ref="`editor${comment.id}`"
                v-model="reply.content"
                :height="100"
                @submit="submitReply(comment)"
            />
          </div>
          <sub-comment-list
              v-if="comment.replies.length"
              :post-id="postId"
              :comment-id="comment.id"
              :data="comment.replies"
              @reply="onReply(comment, $event)"
          />
        </div>
      </div>
    </load-more>
  </div>
</template>

<script>
import SubCommentList from './sub-comment-list.vue'
import LoadMore from "./load-more.vue";
import TextEditor from "@/components/discussion/text-editor.vue";
import {comment, commentAction, listComment} from "@/api/discussion";

export default {
  components: {TextEditor, LoadMore, SubCommentList},
  props: {
    postId: {
      type: Number,
      default: 0,
      required: true,
    },
    commentsPage: {
      type: Object,
      default() {
        return {}
      },
    },
  },
  data() {
    return {
      reply: {
        commentId: 0,
        content: ''
      },
    }
  },
  methods: {
    pageMethod(params) {
      return listComment(params)
    },
    appendComment(data) {
      this.$refs.commentsLoadMore.unshiftResults(data)
    },
    async like(comment) {
      try {
        await commentAction(comment.id, {
          action: comment.liked ? 'cancel_like' : 'like',
        })
        comment.liked = !comment.liked
        comment.liked ? comment.like_count++ : comment.like_count--
      } catch (e) {
        console.error(e);
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
    async submitReply(parent) {
      try {
        const ret = await comment({
          post_id: this.postId,
          comment_id: parent.id,
          content: this.reply.content,
        })
        this.hideReply()
        this.appendReply(parent, ret)
        this.$message.success('评论成功')
      } catch (e) {
        console.error(e)
      }
    },
    onReply(parent, comment) {
      this.appendReply(parent, comment)
    },
    appendReply(parent, comment) {
      if (parent.replies.length) {
        parent.replies.push(comment)
      } else {
        parent.replies = [comment]
      }
      this.$emit('reply', comment);
    }
  },
}
</script>

<style scoped lang="scss">
.comments {
  padding: 10px;
  font-size: 14px;

  .comment {
    display: flex;
    padding: 10px 0;

    &:not(:last-child) {
      border-bottom: 1px solid var(--border-color);
    }

    .comment-item-main {
      flex: 1 1 auto;

      .comment-meta {
        display: flex;
        justify-content: space-between;

        .comment-nickname {
          font-size: 14px;
          font-weight: 600;
          color: var(--text-color);

          &:hover {
            color: var(--text-link-color);
          }
        }

        .comment-meta-right {
          .comment-time {
            font-size: 13px;
            color: var(--text-color3);
          }


        }
      }

      .comment-content-wrapper {
        .comment-content {
          margin-top: 10px;
          margin-bottom: 0;
          color: var(--text-color);
          white-space: pre-wrap;
        }
      }

      .comment-actions {
        margin-top: 10px;
        display: flex;
        align-items: center;

        .comment-action-item {
          line-height: 22px;
          font-size: 13px;
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

          .checked-icon {
            color: var(--color-red);
          }
        }
      }

      .comment-reply-form {
        margin-top: 10px;
      }

      .comment-replies {
        margin-top: 10px;
        background-color: var(--bg-color2);
      }
    }
  }

  .reply {
    display: flex;
  }
}
</style>
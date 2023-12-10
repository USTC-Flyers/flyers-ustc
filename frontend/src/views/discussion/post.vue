<template>
  <div class="post-wrapper" v-if="post">
    <article
        class="post-detail">
      <div class="post-header">
        <div class="post-header-left">
          <div class="post-nickname">
            {{ post.related_user.username }}
          </div>
          <div class="post-meta">
                    <span class="meta-item">
                      发布于 <span>{{ post.created_time|prettyDate }}</span>
                    </span>
          </div>
        </div>
        <div class="post-header-right" v-if="post.related_user.id===userId">
          <el-button-group>
            <el-button size="mini" type="primary" icon="el-icon-edit"
                       @click="$router.push(`/discussion/${post.id}/edit`)">编辑
            </el-button>
            <el-button size="mini" type="danger" icon="el-icon-delete" @click="deletePost">删除</el-button>
          </el-button-group>
        </div>
      </div>
      <div
          class="post-content ">
        <h1 class="post-title">
          {{ post.title }}
        </h1>
        <div
            ref="postContent"
            class="post-content-detail"
            v-html="post.content"/>
        <ul
            v-if="post.images.length"
            class="post-image-list"
        >
          <li v-for="(image, index) in post.images" :key="index">
            <el-image :src="image" class="image-item" lazy :preview-src-list="post.images"/>
          </li>
        </ul>
      </div>

      <!-- 功能按钮 -->
      <div class="post-actions">
        <div class="action disabled">
          <i class="action-icon el-icon-view"/>
          <div class="action-text">
            <span>浏览</span>
            <span class="action-text">
                      ({{ post.visit_count }})
                    </span>
          </div>
        </div>
        <div
            class="action"
            @click="like"
        >
          <i
              class="action-icon "
              :class="{ 'checked-icon': post.liked,'el-icon-star-on':post.liked,'el-icon-star-off':!post.liked }"
          />
          <div class="action-text">
            <span>喜欢</span>
            <span>({{ post.like_count }})</span>
          </div>
        </div>
      </div>
    </article>

    <div class="comment-component">
      <div class="comment-header">
        <span>{{ post.comment_count }}条评论</span>
      </div>
      <comment-input
          ref="input"
          :post-id="post.id"
          @created="createComment"
      />
      <comment-list
          ref="commentList"
          :post-id="post.id"
          @reply="post.comment_count++"
      />
    </div>
  </div>
  <el-empty v-else description="数据不见了" style="background-color: #FFFFFF">
    <el-button type="primary" @click="$router.back()">返回</el-button>
  </el-empty>
</template>

<script>

import CommentInput from "@/components/discussion/comment-input.vue";
import CommentList from "@/components/discussion/comment-list.vue";
import {deletePost, getPost, postAction} from "@/api/discussion";

export default {
  components: {CommentList, CommentInput},
  data() {
    return {
      loading: false,
      post: null
    }
  },
  computed: {
    userId() {
      return this.$store.getters.user_id;
    },
  },
  methods: {
    async loadPost() {
      this.loading = true
      const id = this.$route.params.id;
      try {
        this.post = await getPost(id);
      } catch (e) {
        console.error(e)
      } finally {
        this.loading = false
      }
    },
    async like() {
      try {
        await postAction(this.post.id, {
          action: this.post.liked ? 'cancel_like' : 'like',
        })
        this.post.liked = !this.post.liked
        this.post.liked ? this.post.like_count++ : this.post.like_count--
      } catch (e) {
        console.error(e);
      }
    },
    async createComment(comment) {
      this.$refs.commentList.appendComment(comment)
      this.post.comment_count++
    },
    async deletePost() {
      await this.$confirm('确认删除该篇帖子?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      });
      try {
        await deletePost(this.post.id)
        this.$message.success('删除成功');
        this.$router.back();
      } catch (e) {
        this.$message.error('删除失败');
        console.error(e);
      }
    },
  },
  mounted() {
    this.loadPost()
  }
}
</script>

<style lang="scss" scoped>
.post-wrapper {
  max-width: 1000px;
  margin: 0 auto;

  .post-detail {
    padding: 16px;
    margin-bottom: 20px;
    background-color: var(--bg-color);
    border-radius: 3px;


    .post-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      width: 100%;

      &-left {
        display: flex;
        flex-direction: column;

        .post-nickname {
          color: var(--text-color2);
          font-size: 16px;
          font-weight: bold;
        }

        .post-meta {
          position: relative;
          font-size: 12px;
          line-height: 24px;
          color: var(--text-color3);
          margin-top: 5px;

          .meta-item {
            font-size: 12px;

            &:not(:last-child) {
              margin-right: 8px;
            }
          }
        }
      }

    }

    .post-content {
      font-size: 14px;
      color: var(--text-color);
      white-space: normal;
      word-break: break-all;
      word-wrap: break-word;
      padding-top: 0 !important;

      .post-title {
        font-weight: 700;
        font-size: 20px;
        word-wrap: break-word;
        word-break: normal;
        border-bottom: 1px solid var(--border-color);
        padding-bottom: 10px;
      }

      .post-content-detail {
        font-size: 16px;
        line-height: 24px;
        word-wrap: break-word;
        -webkit-font-smoothing: antialiased;
        padding-bottom: 10px;
      }

      .post-image-list {
        margin-left: 0;
        margin-top: 10px;

        li {
          cursor: pointer;
          border: 1px dashed var(--border-color2);
          text-align: center;

          display: inline-block;
          vertical-align: middle;
          margin: 0 8px 8px 0;
          background-color: var(--bg-color2);
          background-size: 32px 32px;
          background-position: 50%;
          background-repeat: no-repeat;
          overflow: hidden;
          position: relative;

          .image-item {
            display: block;
            overflow: hidden;
            transform-style: preserve-3d;

            & > img {
              width: 100%;
              height: 100%;
              object-fit: cover;
              transition: all 0.5s ease-out 0.1s;

              &:hover {
                transform: matrix(1.04, 0, 0, 1.04, 0, 0);
                backface-visibility: hidden;
              }
            }
          }

          &:first-child:nth-last-child(1) {
            width: 210px;
            height: 210px;
            line-height: 210px;

            .image-item {
              width: 210px;
              height: 210px;
            }
          }

          &:first-child:nth-last-child(2),
          &:first-child:nth-last-child(2) ~ li {
            width: 180px;
            height: 180px;
            line-height: 180px;

            .image-item {
              width: 180px;
              height: 180px;
            }
          }

          &:first-child:nth-last-child(n + 3),
          &:first-child:nth-last-child(n + 3) ~ li {
            width: 120px;
            height: 120px;
            line-height: 120px;

            .image-item {
              width: 120px;
              height: 120px;
            }
          }
        }
      }
    }


    .post-actions {
      padding: 10px 0;
      display: flex;
      align-items: center;
      justify-content: space-between;
      border-top: 1px solid var(--border-color);

      .action {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        background: var(--bg-color);
        cursor: pointer;
        color: var(--text-color3);
        font-size: 14px;

        .checked-icon {
          color: var(--color-red);
        }

        &.disabled {
          cursor: not-allowed;

          &:hover {
            color: var(--text-color3);

            > .action-icon {
              fill: var(--text-color3);
            }
          }
        }

        > .action-icon {
          fill: #8590a6;
        }

        .action-text {
          color: var(--text-color);
          margin-left: 5px;
        }

        &:hover {
          color: var(--text-link-color);

          > .action-icon {
            fill: var(--text-link-color);
          }
        }
      }
    }
  }

  .comment-component {
    margin-top: 10px;
    padding: 16px;
    background-color: var(--bg-color);
  }
}

</style>
<template>
  <div>
    <div class="search-box">
      <el-input v-model="query" placeholder="输入关键字搜索" @keyup.enter.native="search" >
        <el-button slot="append" icon="el-icon-search" @click="search"/>
      </el-input>
    </div>
    <load-more
        ref="commentsLoadMore"
        :params="{query}"
        v-slot="{results}"
        :page-method="loadPost"
    >
      <ul class="post-list">
        <li class="post-item" v-for="post in results" :key="post.id" @click="goPost(post.id)">
          <div class="post-main-content">
            <div class="post-top">
              <div class="post-userinfo"> {{ post.related_user.username }}</div>
              <div class="post-time">
                发布于{{ post.created_time|prettyDate }}
              </div>
            </div>
            <div class="post-content">
              <div class="post-title">{{ post.title }}</div>
              <p class="post-summary">{{ post.content }}</p>
              <ul class="post-image-list" v-if="post.images.length" @click.stop="void(0)">
                <li v-for="(img,idx) in post.images" :key="idx">
                  <el-image class="image-item" :src="img" :preview-src-list="post.images"/>
                </li>
              </ul>
            </div>
            <div class="post-bottom">
              <div class="post-handlers">
                <div class="btn"><i class="el-icon-star-off"></i>喜欢
                  <span>{{ post.like_count }}</span></div>
                <div class="btn"><i class="el-icon-chat-dot-square"></i>评论
                  <span>{{ post.comment_count }}</span></div>
                <div class="btn"><i class="el-icon-view"></i>浏览
                  <span>{{ post.visit_count }}</span></div>
              </div>
              <!--            <div class="post-tags"><a  class="post-tag"-->
              <!--                                       alt="交流">交流</a></div>-->
            </div>
          </div>
        </li>
      </ul>
    </load-more>
  </div>
</template>

<script>
import {listPost} from "@/api/discussion";
import LoadMore from "@/components/discussion/load-more.vue";

export default {
  components: {LoadMore},
  data() {
    return {
      query: '',
      loading: false,
      list: [],
      page: {
        current: 1,
        hasMore: false,
      }
    }
  },
  methods: {
    search() {
      this.$refs.commentsLoadMore.loadMore(true);
    },
    loadPost(params) {
      return listPost(params);
    },
    goPost(id) {
      this.$router.push(`/discussion/${id}`)
    },
  },
}
</script>

<style lang="scss" scoped>

.search-box{
  width: 100%;
  max-width: 500px;
  margin: 0 auto 32px;
}
.post-list {
  padding: 0;

  .post-item {
    padding: 12px 12px;
    display: flex;
    position: relative;
    overflow: hidden;
    transition: background 0.5s;
    border-radius: 3px;
    background: var(--bg-color);
    cursor: pointer;

    &:not(:first-of-type) {
      margin-top: 16px;
    }

    &:hover {
      opacity: .9;
    }

    .post-main-content {
      flex: 1;
      margin-left: 12px;

      .post-top {
        margin-bottom: 8px;

        .post-userinfo {
          display: inline-flex;
          align-items: center;

          a {
            font-weight: 700;
            font-size: 16px;
            color: var(--text-color3);
            display: flex;
            max-width: 250px;
            overflow: hidden;
          }
        }


        .post-time {
          color: var(--text-color3);
          font-size: 12px;
          float: right;
          display: flex;
        }

        @media screen and (max-width: 1024px) {
          .post-time {
            float: none;
            margin-top: 8px;
          }
        }
      }

      .post-content {
        .post-title {
          display: inline-block;
          padding: 0;
          line-height: 1;
          margin: 0 0 6px;
          word-wrap: break-word;
          word-break: break-all;
          width: 100%;

          a {
            font-size: 16px;
            font-weight: 600;
            color: var(--text-color);

            &:hover {
              text-decoration: underline;
            }
          }
        }

        .post-summary {
          display: inline-block;
          font-size: 15px;
          margin: 0;
          width: 100%;
          text-decoration: none;
          color: var(--text-color2);
          word-wrap: break-word;

          overflow: hidden;
          display: -webkit-box;
          -webkit-box-orient: vertical;
          -webkit-line-clamp: 3;
          text-align: justify;
          word-break: break-all;
          text-overflow: ellipsis;
          font-weight: normal;
        }


        .post-image-list {
          margin-top: 10px;
          padding: 0;

          li {
            cursor: pointer;
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

            /*大于两个图片时*/
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

      .post-bottom {
        display: flex;

        .post-handlers {
          display: flex;
          align-items: center;
          margin-top: 6px;
          font-size: 12px;
          flex: 1;

          .btn {
            color: var(--text-color3);
            cursor: pointer;

            &:not(:last-child) {
              margin-right: 20px;
            }

            &:hover {
              color: var(--text-link-color);
            }

            i {
              margin-right: 3px;
              font-size: 12px;
              position: relative;
            }
          }
        }

        .post-tags {
          .post-tag {
            padding: 2px 8px;
            justify-content: center;
            align-items: center;
            border-radius: 12.5px;
            margin-right: 10px;
            background: var(--bg-color2);
            border: 1px solid var(--border-color2);
            color: var(--text-color3);
            font-size: 12px;

            &:hover {
              color: var(--text-link-color);
              background: var(--bg-color);
            }
          }
        }
      }

      .liked {
        color: var(--color-red) !important;
      }
    }
  }

}
</style>
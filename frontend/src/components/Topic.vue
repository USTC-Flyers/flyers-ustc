<template>
  <div>
    <div>
      <h1>{{ title }}</h1>
      <el-button
        v-if="isUpvoted"
        type="primary"
        icon="el-icon-caret-top"
        size="mini"
        @click="downvote"
        round
        >已点赞 {{ upvoted_count }}</el-button
      >
      <el-button
        v-else
        plain
        type="primary"
        icon="el-icon-caret-top"
        size="mini"
        @click="upvote"
        round
        >点赞 {{ upvoted_count }}</el-button
      >

      <el-button
        v-if="isFollowed"
        type="success"
        icon="el-icon-minus"
        size="mini"
        @click="unfollow"
        round
        >已关注</el-button
      >
      <el-button
        v-else
        plain
        type="success"
        icon="el-icon-plus"
        size="mini"
        @click="follow"
        :disabled="isFollowed"
        round
        >关注</el-button
      >
      <router-link :to="{ path: `/revision/${topic_id}` }">
        <el-link icon="el-icon-edit" type="primary" style="margin-left: 20px"
          >修改内容</el-link
        >
      </router-link>
      <el-popconfirm
        v-if="$store.getters.is_admin"
        confirm-button-text="确认"
        cancel-button-text="取消"
        icon="el-icon-info"
        icon-color="red"
        title="确定将本页删除吗？"
        @confirm="deletePage"
        style="margin-left: 20px"
      >
        <el-link slot="reference" type="danger">删除</el-link>
      </el-popconfirm>
    </div>

    <div v-html="content" />
  </div>
</template>

<script>
import {
  getTopic,
  deleteTopic,
  upvoteTopic,
  downvoteTopic,
  followTopic,
  unfollowTopic,
} from "@/api/wiki";
export default {
  name: "Topic",
  data() {
    return {
      topic_id: null,
      title: "",
      content: "",
      upvoted_count: null,
      isUpvoted: false,
      isFollowed: false,
    };
  },
  inject: ["reload"],
  created() {
    this.topic_id = this.$route.params.id;
    this.getTopicContent();
  },
  methods: {
    getTopicContent() {
      getTopic(this.topic_id).then((response) => {
        this.title = response.current_version.title;
        this.content = response.current_version.content;
        this.upvoted_count = response.upvoted_count;
        this.isUpvoted = response.upvoted;
        this.isFollowed = response.followed;
      });
    },
    deletePage() {
      deleteTopic(this.topic_id)
        .then(() => {
          this.$message.success("删除成功");
          this.reload();
          this.$forceUpdate();
          this.$router.push({ path: "/wiki" });
        })
        .catch((err) => {
          console.log(err);
        });
    },
    upvote() {
      upvoteTopic(this.topic_id)
        .then(() => {
          this.isUpvoted = true;
          this.upvoted_count += 1;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    downvote() {
      downvoteTopic(this.topic_id)
        .then(() => {
          this.isUpvoted = false;
          this.upvoted_count -= 1;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    follow() {
      followTopic(this.topic_id)
        .then(() => {
          this.isFollowed = true;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    unfollow() {
      unfollowTopic(this.topic_id)
        .then(() => {
          this.isFollowed = false;
        })
        .catch((err) => {
          console.log(err);
        });
    },
  },
  beforeRouteUpdate(to, from, next) {
    this.topic_id = to.params.id;
    this.getTopicContent();
    setTimeout(() => {
      document.body.scrollTop = 0;
      document.documentElement.scrollTop = 0;
    }, 300);
    next();
  },
};
</script>

<style></style>

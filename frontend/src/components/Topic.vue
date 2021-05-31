<template>
  <div>
    <div>
      <el-button v-if="isUpvoted" type="primary" icon="el-icon-caret-top" size="mini" @click="downvote" round>{{ upvoted_count }}</el-button>
      <el-button v-else plain type="primary" icon="el-icon-caret-top" size="mini" @click="upvote" round>{{ upvoted_count }}</el-button>

      <el-button v-if="isFollowed" type="success" icon="el-icon-minus" size="mini" @click="unfollow" round>已关注</el-button>
      <el-button v-else plain type="success" icon="el-icon-plus" size="mini" @click="follow" :disabled="isFollowed" round>关注</el-button>
      <router-link :to="{ path: `/revision/${topic_id}` }">
        <el-link icon="el-icon-edit" type="primary" style="margin-left: 20px"
          >修改内容</el-link
        >
      </router-link>
    </div>

    <div v-html="content" />
  </div>
</template>

<script>
import { getTopic, upvoteTopic, downvoteTopic, followTopic, unfollowTopic } from "@/api/wiki";
export default {
  name: "Topic",
  data() {
    return {
      topic_id: null,
      content: "",
      upvoted_count: null,
      isUpvoted: false,
      isFollowed: false,
    };
  },
  created() {
    this.topic_id = this.$route.params.id;
    this.getTopicContent();
  },
  methods: {
    getTopicContent() {
      getTopic(this.topic_id).then((response) => {
        this.content = response.current_version.content;
        this.upvoted_count = response.upvoted_count;
        this.isUpvoted = response.upvoted;
        this.isFollowed = response.followed;
      });
    },
    upvote() {
      upvoteTopic(this.topic_id).then(() => {
        this.isUpvoted = true;
        this.upvoted_count += 1;
      }).catch((err) => {
        console.log(err);
      });
    },
    downvote() {
      downvoteTopic(this.topic_id).then(() => {
        this.isUpvoted = false;
        this.upvoted_count -= 1;
      }).catch((err) => {
        console.log(err);
      });
    },
    follow() {
      followTopic(this.topic_id).then(() => {
        this.isFollowed = true;
      }).catch((err) => {
        console.log(err);
      });
    },
    unfollow() {
      unfollowTopic(this.topic_id).then(() => {
        this.isFollowed = false;
      }).catch((err) => {
        console.log(err);
      });
    }
  },
  beforeRouteUpdate(to, from, next) {
    this.topic_id = to.params.id;
    this.getTopicContent();
    next();
  },
};
</script>

<style></style>

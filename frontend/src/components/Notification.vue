<template>
  <div class="app-container">
    <h2 v-if="isAll">全部通知</h2>
    <h2 v-else>未读通知</h2>
    <el-table :data="notificationList" :row-class-name="tableRowClassName">
      <template slot="empty">
        <div>你没有新的通知</div>
      </template>
      <el-table-column
          prop="created_time"
          label="时间"
          align="center"
          width="200"
      >
        <template slot-scope="scope">
          {{ scope.row.created_time | dateFilter }}
        </template>
      </el-table-column>
      <el-table-column
          prop="message"
          label="消息"
          header-align="center"
          width="350"
      >
      </el-table-column>
      <el-table-column label="查看" width="100">
        <template slot-scope="{ row }">
          <router-link
              :to="{
              path: `${row.route_name}/${row.route_id}/`,
              hash: row.hash,
            }"
          >
            <el-button type="text" size="small" @click="getNotificationCount">
              查看
            </el-button>
          </router-link>
        </template>
      </el-table-column>
    </el-table>
    <!-- <router-link :to="{ path: `/revision/${topic_id}` }"> -->
    <el-button
        v-if="isAll === false"
        icon="el-icon-d-arrow-right"
        type="text"
        style="float: right"
        @click="getAll"
    >全部通知
    </el-button
    >
    <!-- </router-link> -->
  </div>
</template>

<script>
const [
  UPDATED,
  UPVOTED,
  DELETED,
  APPROVED,
  REJECTED,
  REPLIED,
  MENTIONED,
  PINNED,
  UNPINNED,
  PR,
  REPORT,
  OTHER,
  LIKED,
  COMMENT,
  COMMENT_LIKED,
] = [...Array(15).keys()];

import {
  initNotification,
  getNotification,
  readNotification,
} from "@/api/user";
import {admissions_get} from "@/api/admission";
import {getTopicRevision} from "@/api/wiki";

// import AnchorRouterLink from 'vue-anchor-router-link'
export default {
  filters: {
    dateFilter(val) {
      return val.slice(0, 19).replace("T", " ");
    },
  },
  // components: {
  //   AnchorRouterLink
  // },
  data() {
    return {
      isAll: false,
      notificationList: null,
      operationsMap: null,
    };
  },
  inject: ["getNotificationCount"],
  created() {
    this.operationsMap = {};
    this.operationsMap[UPDATED] = "";
    this.operationsMap[OTHER] = "";
    this.operationsMap[PR] = "";
    this.operationsMap[UPVOTED] = "success-row";
    this.operationsMap[APPROVED] = "success-row";
    this.operationsMap[REPLIED] = "success-row";
    this.operationsMap[MENTIONED] = "success-row";
    this.operationsMap[PINNED] = "success-row";
    this.operationsMap[UNPINNED] = "warning-row";
    this.operationsMap[DELETED] = "warning-row";
    this.operationsMap[REJECTED] = "warning-row";
    this.operationsMap[REPORT] = "warning-row";
    this.operationsMap[LIKED] = "success-row";
    this.operationsMap[COMMENT] = "success-row";
    this.operationsMap[COMMENT_LIKED] = "success-row";

    initNotification()
        .then((resp) => {
          // this.notificationList = resp.results;
          this.notificationList = [];
          resp.unread_set.forEach((item) => {
            this.notificationList.push(this.notiMap(item));
            readNotification(item.id);
          });
          // console.log(this.notificationList);
        })
        .catch((err) => {
          console.log(err);
        });
    // !TODO: fixme
    // this.notificationList.forEach((no) => {
    //   no.created_time = this.parseDate(no.created_time);
    // });
  },
  methods: {
    tableRowClassName({row, rowIndex}) {
      // console.log(row);
      let operation = this.notificationList[rowIndex];
      return this.operationsMap[operation];
    },
    handleClick(row) {
      // console.log(row);
      this.$router.push({
        path: "/" + row.route_name + "/" + row.route_id + "/",
        hash: row.hash,
      });
    },
    getAll() {
      getNotification()
          .then((resp) => {
            // this.notificationList = resp.results;
            this.notificationList = [];
            resp.results.forEach((item) => {
              this.notificationList.push(this.notiMap(item));
            });
            this.isAll = true;
          })
          .catch((err) => {
            console.log(err);
          });
    },
    notiMap(noti_item) {
      var result = {
        id: null,
        created_time: null,
        ref_obj_name: "",
        ref_obj_id: null,
        message: "",
        hash: "",
      };
      result.id = noti_item.id;
      result.created_time = this.parseDate(noti_item.created_time);
      if (noti_item.operation === UPVOTED) {
        result.route_name = "usermain";
        result.route_id = this.$store.getters.user_id;
        if (noti_item.ref_obj_name === "Background") {
          result.message = "你的申请总结被点赞";
          result.hash = "#summary";
        } else if (noti_item.ref_obj_name === "Admissions") {
          admissions_get(noti_item.ref_obj_id)
              .then((response) => {
                var schoolname = response.related_university.short_name;
                result.message = "你的「" + schoolname + "」申请经验被点赞";
                result.hash = "#admissions";
              })
              .catch((error) => {
                if (error.response.status === 404) {
                  result.message = "该申请经验已被删除";
                }
              });
        }
      } else if (noti_item.operation === PR) {
        result.route_name = "review";
        result.route_id = noti_item.ref_obj_id;
        result.message = "新的 Wiki 修改请求";
      } else if (noti_item.operation === UPDATED) {
        result.route_name = "topic";
        getTopicRevision(noti_item.ref_obj_id).then((response) => {
          var title = response.title;
          result.message = "你关注的 Wiki -「" + title + "」有更新";
          result.route_id = response.related_topic;
        });
      } else if (noti_item.operation === APPROVED) {
        result.route_name = "topic";
        getTopicRevision(noti_item.ref_obj_id).then((response) => {
          var title = response.title;
          result.message = "你对 Wiki -「" + title + "」的修改已被审核通过";
          result.route_id = response.related_topic;
        });
      } else if (noti_item.operation === REJECTED) {
        result.route_name = "topic";
        getTopicRevision(noti_item.ref_obj_id).then((response) => {
          var title = response.title;
          result.message = "你对 Wiki -「" + title + "」的修改审核未通过";
          result.route_id = response.related_topic;
        });
      } else if (noti_item.operation === LIKED||noti_item.operation === COMMENT||noti_item.operation === COMMENT_LIKED) {
        result.route_name = "/discussion";
        result.message = noti_item.message;
        result.route_id = noti_item.ref_obj_id;
      }
      return result;
    },
    parseDate(val) {
      return val.slice(0, 19).replace("T", " ");
    },
  },
};
</script>

<style scoped>
.app-container {
  margin: 5%;
  width: 650px;
}
</style>

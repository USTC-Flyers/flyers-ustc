<template>
  <div class="app-container">
    <el-table
      :data="notificationList"
      :row-class-name="tableRowClassName"
      :header-cell-class-name="getHeaderClass"
    >
      <el-table-column prop="created_time" label="时间" width="180">
        <template slot-scope="scope">
          {{ scope.row.created_time | dateFilter }}
        </template>
      </el-table-column>
      <el-table-column prop="message" label="消息" width="300">
      </el-table-column>
      <el-table-column label="" width="100">
        <template slot-scope="{ row }">
          <router-link
            :to="{
              path: `${row.route_name}/${row.route_id}/`,
              hash: row.hash,
            }"
          >
            <el-button type="text" size="small">
              查看
            </el-button>
          </router-link>
        </template>
      </el-table-column>
    </el-table>
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
    ] = [...Array(12).keys()];

import { getNotification } from "@/api/user";
import { admissions_get } from "@/api/admission"
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
      notificationList: null,
      operationsMap: null,
    };
  },
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

    getNotification()
      .then((resp) => {
        // this.notificationList = resp.results;
        this.notificationList = [];
        resp.results.forEach(item => {
          this.notificationList.push(this.notiMap(item));
        });
        console.log(this.notificationList);
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
    getHeaderClass() {
      return "table-header";
    },
    tableRowClassName({ row, rowIndex }) {
      // console.log(row);
      let operation = this.notificationList[rowIndex];
      return this.operationsMap[operation];
    },
    handleClick(row) {
      console.log(row);
      this.$router.push(
        { path: "/" + row.route_name + "/" + row.route_id + "/", hash: row.hash },
      );
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
      if(noti_item.operation === UPVOTED) {
        result.route_name = "usermain";
        result.route_id = this.$store.getters.user_id;
        if(noti_item.ref_obj_name === "Background") {
          result.message = "你的申请总结被点赞";
          result.hash = "#summary"
        }
        else if(noti_item.ref_obj_name === "Admissions") {
          admissions_get(noti_item.ref_obj_id).then((response) => {
            var schoolname =  response.related_university.short_name;
            result.message = "你的 " + schoolname +" 申请经验被点赞";
            result.hash = "#admissions"
          }).catch((error) => {
            if (error.response.status === 404) {
              result.message = "该申请经验已被删除"
            }
          });
        }
      }
     
      return result;
      // if (name === "TopicRevision") return "Review";
      // else if (name === "Admissions") return "usermain"
      // return name;
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
}
.el-table .table-header {
  text-align: center;
}
</style>

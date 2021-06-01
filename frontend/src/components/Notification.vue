<template>
  <el-table
    :data="notificationList"
    style="width: 100%"
    :row-class-name="tableRowClassName"
  >
    <el-table-column prop="created_time" label="时间" width="180">
    </el-table-column>
    <el-table-column prop="message" label="通知" width="300"> </el-table-column>
    <el-table-column label="" width="100">
      <template slot-scope="scope">
        <el-button @click="handleClick(scope.row)" type="text" size="small"
          >查看</el-button
        >
      </template>
    </el-table-column>
  </el-table>
</template>

<script>
import { getNotification, readNotification } from "@/api/user";
export default {
  data() {
    return {
      notificationList: null,
      operationsMap: null,
    };
  },
  created() {
    console.log("created");

    this.operationsMap = {};
    let [
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
    console.log("created");
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
    console.log("created");

    getNotification()
      .then((resp) => {
        this.notificationList = resp.results;
      })
      .catch((err) => {
        console.log(err);
      });
  },
  methods: {
    tableRowClassName({ row, rowIndex }) {
      console.log(row);
      let operation = this.notificationList[rowIndex];
      return this.operationsMap[operation];
    },
    handleClick(row) {
      console.log(row);
      readNotification(row.id);
      this.$router.push(
        { path: "/" + row.ref_obj_name + "/" + row.ref_obj_id + "/" },
        () => {}
      );
    },
    pathMap(name) {
      if (name === "TopicRevision") return "topic_revision";
      return name;
    },
  },
};
</script>

<style></style>

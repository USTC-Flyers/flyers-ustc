<template>
  <router-link to="/report_admission">
    <el-button type="primary" size="default">汇报我的录取结果</el-button>
  </router-link>
  <!-- <div>
    <el-table v-loading="listLoading" :data="list" element-loading-text="Loading" border fit>
      <el-table-column :prop="col.id" :label="col.label">
      </el-table-column>
    </el-table>
  </div> -->
</template>

<script>
export default {
  name: "Admission",
  data() {
    return {
      list: null,
    };
  },
};
</script>

<style></style>

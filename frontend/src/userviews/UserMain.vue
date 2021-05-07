<template>
  <el-row>
    <el-row>
      <h3>我的录取</h3>
    </el-row>
    <el-row>
      <el-col :span="24">
        <el-table
          :data="tableData"
          stripe
          style="width: 100%">
          <el-table-column
            prop="school"
            label="录取学校">
          </el-table-column>
          <el-table-column
            prop="program"
            label="录取项目">
          </el-table-column>
          <el-table-column
            prop="time"
            label="入学时间">
          </el-table-column>
          <el-table-column
            prop="result"
            label="结果">
          </el-table-column>
        </el-table>
      </el-col>
    </el-row>

    <el-row>
      <h3>我的暑研</h3>
    </el-row>
    <el-row>
      <el-table
        :data="tableData"
        stripe
        style="width: 100%">
        <el-table-column
          prop="school"
          label="录取学校">
        </el-table-column>
        <el-table-column
          prop="program"
          label="录取项目">
        </el-table-column>
        <el-table-column
          prop="time"
          label="入学时间">
        </el-table-column>
        <el-table-column
          prop="result"
          label="结果">
        </el-table-column>
      </el-table>
    </el-row>
    
    <el-row>
      <h3>我的问答</h3>
    </el-row>
    <el-row>
      <span>这是第一个问题</span>
      <el-divider></el-divider>
      <span>这是第二个问题</span>
      <el-divider></el-divider>
    </el-row>
  </el-row>
</template>

<script>
export default {
  name: "UserMain",
  data: function () {
    return {
      tableData: [{
        school: 'MIT',
        program: 'program A',
        time: '21 fall',
        result: 'AD'
      }, {
        school: 'UCB',
        program: 'program B',
        time: '21 fall',
        result: 'AD'
      }, {
        school: 'CMU',
        program: 'program C',
        time: '21 fall',
        result: 'AD'
      }]
    }
  }
}
</script>

<style scoped>
.el-row {
  width: 100%;
}
</style>

<template>
  <div class="app-container">
    <el-row>
      <h3>我的录取</h3>
    </el-row>
    <el-row>
      <el-col :span="24">
        <el-table
          :data="tableData"
          :header-cell-class-name="getHeaderClass"
          fit
          stripe
        >
          <el-table-column prop="username" width="100" align="center">
          </el-table-column>
          <el-table-column label="录取学校" width="100" align="center">
            <template slot-scope="{ row }">
              <el-tooltip :content="row.univ_fullname" placement="top">
                <div>{{ row.univ }}</div>
              </el-tooltip>
            </template>
          </el-table-column>
          <el-table-column prop="program" label="录取项目"> </el-table-column>
          <el-table-column
            prop="semester"
            label="入学时间"
            width="110"
            align="center"
          ></el-table-column>
          <el-table-column
            prop="result"
            label="结果"
            width="80"
            align="center"
            :filters="[
              { text: 'AD', value: true },
              { text: 'Reject', value: false },
            ]"
          >
            <template slot-scope="{ row }">
              <el-tag :type="row.result | adrejFilter | adrejStatusFilter">
                {{ row.result | adrejFilter }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column
            prop=""
            label="项目申请经验"
            width="120"
            align="center"
          >
            <template slot-scope="{ row }">
              <el-button
                type="text"
                size="small"
                @click="experienceVisible = true"
                >点击查看</el-button
              >
              <el-dialog
                :visible.sync="experienceVisible"
                custom-class="dialog"
              >
                <div class="dialog-block">
                  <i class="el-icon-arrow-right dialog-title"> 项目申请经验</i>
                  <p>{{ row.program_experience }}</p>
                </div>
                <div class="dialog-block" v-show="row.program_summary != ''">
                  <i class="el-icon-arrow-right dialog-title"> 项目就读体验</i>
                  <p>{{ row.program_summary }}</p>
                </div>
              </el-dialog>
            </template>
          </el-table-column>
          <el-table-column label="专业" width="140">
            <template slot-scope="{ row }">
              {{ row.major | majorFilter }}
            </template>
          </el-table-column>
          <el-table-column label="背景" width="220" align="center">
            <template slot-scope="{ row }">
              <el-tag
                v-if="row.background.rank != 'else'"
                type="success"
                size="mini"
              >
                {{ row.background.rank | rankFilter }}
              </el-tag>
              <el-tag type="info" size="mini">
                {{ row.background.apply_for | applyFilter }}
              </el-tag>
              <el-tag v-for="tag in row.background.tags" :type="tag" :key="tag | tagTypeFilter" size="mini">
                {{ tag | tagFilter }}
              </el-tag>
            </template>
          </el-table-column>

          <el-table-column prop="" label="申请总结" width="150" align="center">
            <template slot-scope="{ row }">
              <el-button
                type="text"
                @click="backgroundVisible = true"
                >完整申请背景</el-button
              >
              <el-dialog
                title="个人背景"
                :visible.sync="backgroundVisible"
              >
                <el-form label-position="right" label-width="auto">
                  <el-row>
                    <el-col :span="11">
                      <el-form-item label="专业:" size="mini">
                        <span>{{ row.major | majorFilter }}</span>
                      </el-form-item>
                    </el-col>
                    <el-col :span="13">
                      <el-form-item label="方向:" size="mini">
                        <span>{{ row.background.apply_for | applyFilter }}</span>
                      </el-form-item>
                    </el-col>
                  </el-row>
                  <el-row>
                    <el-col :span="11">
                      <el-form-item label="GPA:" size="mini">
                        <span>{{ row.background.gpa }}</span>
                      </el-form-item>
                    </el-col>
                    <el-col :span="13">
                      <el-form-item label="排名:" size="mini">
                        <span>{{ row.background.rank | rankFilter }}</span>
                      </el-form-item>
                    </el-col>
                  </el-row>
                  <el-row>
                    <el-col :span="11">
                      <el-form-item label="托福:" size="mini">
                        <span>{{ row.background.TOEFL }}</span>
                      </el-form-item>
                    </el-col>
                    <el-col :span="13">
                      <el-form-item label="GRE:" size="mini">
                        <span>{{ row.background.GRE }}</span>
                      </el-form-item>
                    </el-col>
                  </el-row>
                  <el-form-item label="其他标化:" size="mini"> </el-form-item>
                  <el-form-item label="科研/实习背景:">
                    <span>
                      {{ row.background.researchSpec }}
                    </span>
                  </el-form-item>
                  <el-form-item label="推荐信:">
                    <span>
                      {{ row.background.referSpec }}
                    </span>
                  </el-form-item>
                </el-form> </el-dialog
              ><br />
              <el-button type="text" @click="summaryVisible = true"
                >总结与感想</el-button
              >
              <el-dialog
                :visible.sync="summaryVisible"
                custom-class="dialog"
              >
                <div class="dialog-block">
                  <i class="el-icon-arrow-right dialog-title"> 申请方向的思考</i>
                  <!-- <p>{{ row.background.comments }}</p> -->
                  <div v-html="row.background.comments"/>
                </div>
                <div class="dialog-block">
                  <i class="el-icon-arrow-right dialog-title"> 申请感言</i>
                  <!-- <p>{{ row.background.summary }}</p> -->
                  <div v-html="row.background.summary"/>
                </div>
              </el-dialog>
            </template>
          </el-table-column>
        </el-table>
      </el-col>
    </el-row>

    <el-row>
      <h3>我的暑研</h3>
    </el-row>
    <el-row>
      <!-- <el-table
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
      </el-table> -->
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
  </div>
</template>

<script>
import { admissions_get_my } from "@/api/admission";
import {
  major_list,
  rank_list,
  applyfor_filter,
  research_tags,
  ref_tags,
} from "@/assets/data.json";

export default {
  name: "UserMain",
  filters: {
    adrejFilter(value) {
      const map = {
        true: "AD",
        false: "Reject",
      };
      return map[value];
    },
    adrejStatusFilter(status) {
      const map = {
        AD: "success",
        Reject: "danger",
      };
      return map[status];
    },
    majorFilter(major) {
      const map = major_list;
      return map[major];
    },
    rankFilter(rank) {
      const map = rank_list;
      return map[rank];
    },
    applyFilter(apply) {
      const map = applyfor_filter;
      return map[apply];
    },
    tagFilter(tag) {
      const map = Object.assign({}, research_tags, ref_tags);
      return map[tag];
    },
    tagTypeFilter(tag) {
      const map = {
        "oversea_research": "",
        "first_author": "",
        "paper": "",
        "internship": "",
        "oversea_refer": "warning",
        "bigname_refer": "warning",
        "connection": "warning"
      };
      return map[tag];
    }
  },
  data: function () {
    return {
      tableData: [],
      experienceVisible: false,
      backgroundVisible: false,
      summaryVisible: false,
    }
  },
  mounted() {
    this.getTable();
  },
  methods: {
    getHeaderClass: function () {
      return "table-header";
    },
    getTable: function () {
      console.log("UserMain getTable");
      admissions_get_my().then((response) => {
        this.getTableData(response.user_detail);
      });
    },
    getTableData: function (data) {
      this.tableData = [];
      this.experienceVisible = false;
      this.backgroundVisible = false;
      this.summaryVisible = false;
      data.forEach((item) => {
        this.tableData.push({
          username: item.related_user.username,
          univ: item.related_university.short_name,
          univ_fullname: item.related_university.school_name,
          program: item.related_program,
          semester: item.enrolledSemester,
          result: item.result,
          program_experience: item.comments,
          program_summary: item.summary,
          major: item.related_background.major,
          background: item.related_background,
        });
        this.experienceVisible = false;
        this.backgroundVisible = false;
        this.summaryVisible = false;
      });
    },
  }
}
</script>

<style scoped>
.el-row {
  width: 100%;
}
.app-container {
  margin: 0 auto;
}
.el-table {
  /* margin-top: 50px; */
  width: 1200px;
}

.el-table .table-header {
  text-align: center;
}
.el-table .cell {
  word-break: break-word;
}
.dialog {
  text-align: left;
}
.dialog .dialog-block {
  margin: 0px 10px 40px 10px;
}
.dialog .dialog-title {
  font-size: 16px;
  color: #409eff;
  font-weight: bolder;
}
</style>

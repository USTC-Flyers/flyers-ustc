<template>
  <div class="app-container">
    <router-link to="/report_admission">
      <el-button type="primary" size="default">汇报我的录取结果</el-button>
    </router-link>
    <div>
      <div class="filter-container">
        <el-select placeholder="入学时间" filterable>
          <el-option
            v-for="semester in semester_list"
            :key="semester"
            :label="semester"
            :value="semester"
          ></el-option>
        </el-select>
        <el-select filterable placeholder="专业">
          <el-option
            v-for="item in major_list"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          ></el-option>
        </el-select>
      </div>
      <el-table
        :data="table_data"
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
          width="100"
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
          :filter-method="filterResult"
          :filter-multiple="false"
          filter-placement="top"
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
          <template slot-scope="{ row, $index }">
            <el-button
              type="text"
              size="small"
              @click="$set(experience_visible, $index, true)"
              >点击查看</el-button
            >
            <el-dialog
              :visible.sync="experience_visible[$index]"
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
            <el-tag type="warning" size="mini">
              {{ row.background.apply_for | applyFilter }}
            </el-tag>
            <el-tag v-for="tag in row.background.tags" :key="tag" size="mini">
              {{ tag | tagFilter }}
            </el-tag>
          </template>
        </el-table-column>

        <el-table-column prop="" label="申请总结" width="150" align="center">
          <template slot-scope="{ row, $index }">
            <el-button
              type="text"
              @click="$set(background_visible, $index, true)"
              >完整申请背景</el-button
            >
            <el-dialog
              title="个人背景"
              :visible.sync="background_visible[$index]"
            >
              <el-form label-position="right" label-width="auto">
                <el-row>
                  <el-col :span="11">
                    <el-form-item label="专业:" size="mini">
                      <span>{{ row.major | majorFilter }}</span>
                    </el-form-item>
                  </el-col>
                  <el-col :span="13">
                    <el-form-item label="专业:" size="mini">
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
            <el-button type="text" @click="$set(summary_visible, $index, true)"
              >总结与感想</el-button
            >
            <el-dialog
              :visible.sync="summary_visible[$index]"
              custom-class="dialog"
            >
              <div class="dialog-block">
                <i class="el-icon-arrow-right dialog-title"> 申请方向的思考</i>
                <p>{{ row.background.comments }}</p>
              </div>
              <div class="dialog-block">
                <i class="el-icon-arrow-right dialog-title"> 申请感言</i>
                <p>{{ row.background.summary }}</p>
              </div>
            </el-dialog>
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<script>
import { admissions_get_all } from "@/api/admission";
// import { getInfo } from "@/api/user"
export default {
  name: "Admission",
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
      const map = {
        "045": "045: 数学系",
        "046": "046: 计算与应用数学系",
        "047": "047: 概率统计系",
        "002": "002: 物理学系",
        "004": "004: 近代物理系",
        "022": "022: 天文学系",
        "038": "038: 光学与光学工程系",
        "048": "048: 工程与应用物理系",
        "015": "015: 工商管理系",
        "016": "016: 管理科学系",
        "017": "017: 统计与金融系",
        "034": "034: MBA中心",
        "035": "035: MPA中心",
        "039": "039: EMBA",
        "003": "003: 化学物理系",
        "012": "012: 应用化学系",
        "014": "014: 材料科学与工程系",
        "019": "019: 化学系",
        "020": "020: 高分子科学与工程系",
        "008": "008: 分子生物学与细胞生物学系",
        "021": "021: 神经生物学与生物物理学系",
        "031": "031: 系统生物学系",
        "032": "032: 医药生物技术系",
        "071": "071: 地球物理与行星科学技术系",
        "072": "072: 地球化学与环境科学系",
        "005": "005: 近代力学系",
        "009": "009: 精密机械与精密仪器系",
        "013": "013: 热科学和能源工程系",
        "030": "030: 安全科学与工程系",
        "006": "006: 电子工程与信息科学系",
        "010": "010: 自动化系",
        "023": "023: 电子科学与技术系",
        "033": "033: 信息安全",
        "018": "018: 外语系",
        "024": "024: 科技史与科技考古系",
        "025": "025: 科技传播与科技政策系",
        "055": "055: 科技哲学系",
        "056": "056: 心理学系",
        "011": "011: 计算机科学与技术系",
        "044": "044: 物流工程硕士中心",
      };
      return map[major];
    },
    rankFilter(rank) {
      const map = {
        "top1%": "Top 1%",
        "top5%": "Top 5%",
        "top10%": "Top 10%",
        "top20%": "Top 20%",
        "top30%": "Top 30%",
        "top50%": "Top 50%",
      };
      return map[rank];
    },
    applyFilter(apply) {
      const map = {
        phd: "主申PhD",
        ms: "主申Master",
        ms_phd: "混申",
      };
      return map[apply];
    },
    tagFilter(tag) {
      const map = {
        oversea_research: "海外科研",
        first_author: "顶会/顶刊一作",
        paper: "有Paper",
        internship: "工业界实习",
        oversea_refer: "海外推",
        bigname_refer: "牛推",
        connection: "强Connection推",
      };
      return map[tag];
    },
  },
  data() {
    return {
      semester_list: [
        "2021 Fall",
        "2021 Spring",
        "2020 Fall",
        "2020 Spring",
        "2019 Fall",
        "2019 Spring",
        "2018 Fall",
        "2018 Spring",
        "2017 Fall",
        "2017 Spring",
        "2016 Fall",
        "2016 Spring",
        "2015 Fall",
        "2015 Spring",
        "2014 Fall",
        "2014 Spring",
        "2013 Fall",
        "2013 Spring",
        "2012 Fall",
        "2012 Spring",
        "2011 Fall",
        "2011 Spring",
      ],
      table_data: [],
      experience_visible: [],
      background_visible: [],
      summary_visible: [],
    };
  },
  mounted() {
    admissions_get_all().then((response) => {
      response.forEach((item) => {
        this.table_data.push({
          username: item.related_user.username,
          univ: item.related_university.short_name,
          univ_fullname: item.related_university.school_name,
          program: item.related_program,
          semester: item.enrolledSemester,
          result: item.result,
          // program_comments: {
          //   experience: item.comments,
          //   summary: item.summary,
          // },
          program_experience: item.comments,
          program_summary: item.summary,
          major: item.related_background.major,
          background: item.related_background,
        });
        this.experience_visible.push(false);
        this.background_visible.push(false);
        this.summary_visible.push(false);
      });
    });
  },
  methods: {
    getHeaderClass() {
      return "table-header";
    },
    filterResult(value, row) {
      return value === row.result;
    },
    // getCellClass({row,column,rowIndex,columnIndex}){
    //   if(column.label == "结果"){
    //     if(row.result == "AD"){

    //     }
    //   }
    // }
  },
};
</script>

<style>
.app-container {
  margin: 0 auto;
}
.filter-container {
  margin-top: 50px;
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
.el-form span {
  font-weight: normal;
  float: left;
}
</style>

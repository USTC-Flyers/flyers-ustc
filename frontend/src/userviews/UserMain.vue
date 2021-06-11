<template>
  <div class="app-container">
    <div class="aside">
      <h2 class="highlight">{{ user.nickname }}</h2>
      <div class="info-item highlight">
        <i class="el-icon-magic-stick"> 获得 {{ user.all_votes_cnt }} 次点赞</i>
      </div>
      <div class="info-item">
        <div class="bold">学院：</div>
        <div>{{ user.school | schoolFilter }}</div>
      </div>
      <div class="info-item">
        <span class="bold">在校身份：</span>
        <span>{{ user.isUndergrad | isUndergradFilter }}</span>
      </div>
      <div class="info-item">
        <div class="bold">联系方式：</div>
        <div>{{ user.contact }}</div>
      </div>
      <div class="info-item">
        <div class="bold">最终去向：</div>
        <div>{{ user.final_university }}</div>
        <div>{{ user.final_program }}</div>
      </div>
    </div>
    <div class="content">
      <div class="content-block">
        <el-row>
          <h2 class="highlight" id="background">申请背景&#32;</h2>
          <i class="el-icon-magic-stick">&nbsp; {{ user.all_votes_cnt }}</i>
        </el-row>
        <el-form label-position="right" label-width="auto">
          <el-row>
            <el-col :span="12">
              <el-form-item label="专业:" size="mini">
                <span>{{ background.major | majorFilter }}</span>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="方向:" size="mini">
                <span>{{ background.apply_for | applyFilter }}</span>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12">
              <el-form-item label="GPA:" size="mini">
                <span>{{ background.gpa }}</span>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="排名:" size="mini">
                <span>{{ background.rank | rankFilter }}</span>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12">
              <el-form-item label="托福:" size="mini">
                <span>{{ background.TOEFL }}</span>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="GRE:" size="mini">
                <span>{{ background.GRE }}</span>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-form-item label="其他标化:" size="mini"> </el-form-item>
          </el-row>
          <el-row>
            <el-form-item label="科研/实习背景:">
              <span>
                <div>
                  <el-tag
                    v-for="tag in background.research_tag_list"
                    :type="tag | tagTypeFilter"
                    :key="tag"
                    size="mini"
                  >
                    {{ tag | tagFilter }}
                  </el-tag>
                </div>
                <div>
                  {{ background.researchSpec }}
                </div>
              </span>
            </el-form-item>
          </el-row>
          <el-row>
            <el-form-item label="推荐信:">
              <span>
                <div>
                  <el-tag
                    v-for="tag in background.ref_tag_list"
                    :type="tag | tagTypeFilter"
                    :key="tag"
                    size="mini"
                  >
                    {{ tag | tagFilter }}
                  </el-tag>
                </div>
                <div>
                  {{ background.referSpec }}
                </div>
              </span>
            </el-form-item>
          </el-row>
        </el-form>
      </div>
      <div class="content-block">
        <el-row>
          <h2 class="highlight" id="admissions">录取信息</h2>
        </el-row>
        <el-table
          :data="tableData"
          :header-cell-class-name="getHeaderClass"
          fit
          stripe
        >
          <el-table-column label="录取学校" width="100" align="center">
            <template slot-scope="{ row }">
              <el-tooltip :content="row.univ_fullname" placement="top">
                <div>{{ row.univ }}</div>
              </el-tooltip>
            </template>
          </el-table-column>
          <el-table-column prop="program" label="录取项目"> </el-table-column>
          <el-table-column
            sortable
            prop="semester"
            label="入学时间"
            width="120"
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
                @click="$set(experienceVisible, $index, true)"
                >点击查看</el-button
              >
              <el-dialog
                :visible.sync="experienceVisible[$index]"
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
                <div class="dialog-button">
                  <el-button
                    v-if="row.upvoted"
                    type="primary"
                    icon="el-icon-magic-stick"
                    size="small"
                    @click="downvote(row)"
                    round
                    >已点赞 {{ row.upvoted_count }}</el-button
                  >
                  <el-button
                    v-else
                    plain
                    type="primary"
                    icon="el-icon-magic-stick"
                    size="small"
                    @click="upvote(row)"
                    round
                    >点赞 {{ row.upvoted_count }}</el-button
                  >
                </div>
              </el-dialog>
            </template>
          </el-table-column>
        </el-table>
      </div>
      <div class="content-block">
        <el-row>
          <h2 class="highlight" id="summary">申请总结</h2>
        </el-row>
        <i class="el-icon-arrow-right mini-title"> 申请方向的思考</i>
        <div v-html="background.comments" />
        <i class="el-icon-arrow-right mini-title"> 申请感言</i>
        <div v-html="background.summary" />
      </div>
    </div>
  </div>
</template>

<script>

// import { get_user_profile } from "@/api/user";
// import { admissions_get_user } from "@/api/admission";
// import { background_get_user } from "@/api/background";
import { getInfo } from "@/api/user";
import { admissions_get_my } from "@/api/admission";
import { background_get_my } from "@/api/background";
import {
  school_list,
  major_list,
  rank_list,
  applyfor_filter,
  research_tags,
  ref_tags,
  tags_mapper,
} from "@/assets/data.json";

export default {
  name: "UserMain",
  filters: {
    schoolFilter(index) {
      let school_name = school_list[index];
      return school_name.slice(4, school_name.length);
    },
    isUndergradFilter(value) {
      const map = {
        true: "本科生",
        false: "研究生",
      };
      return map[value];
    },
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
        oversea_research: "",
        first_author: "",
        paper: "",
        internship: "",
        oversea_refer: "warning",
        bigname_refer: "warning",
        connection: "warning",
      };
      return map[tag];
    },
  },
  data: function () {
    return {
      school_list,
      tags_mapper,
      user: {
        nickname: "",
        all_votes_cnt: 0,
        school: 0,
        isUndergrad: null,
        contact: "",
        final_university: null,
        final_program: null,
      },
      background: {
        major: "",
        gpa: 4.3,
        rank: "",
        apply_for: "",
        TOEFL: "",
        GRE: "",
        score: "",
        researchSpec: "",
        referSpec: "",
        comments: "",
        summary: "",
        tags: [],
        research_tag_list: [],
        ref_tag_list: [],
      },
      tableData: [],
      experienceVisible: [],
    };
  },
  created() {
    this.getUserProfile();
    this.getBackground();
    this.getTable();
  },
  methods: {
    getHeaderClass: function () {
      return "table-header";
    },
    filterResult(value, row) {
      return value === row.result;
    },
    getUserProfile: function () {
      getInfo().then((response) => {
        this.user = response.user_detail;
      });
    },
    getBackground: function () {
      background_get_my().then((response) => {
        this.background = response.user_detail;
        this.background.research_tag_list = [];
        this.background.ref_tag_list = [];
        var tags = this.background.tags;
        for (const item of tags) {
          if (item) {
            if (this.tags_mapper[item] == 0) {
              this.background.research_tag_list.push(item);
            } else if (this.tags_mapper[item] == 1) {
              this.background.ref_tag_list.push(item);
            } else {
              console.log("tag error:" + item);
            }
          }
        }
      });
    },
    getTable: function () {
      admissions_get_my().then((response) => {
        this.getTableData(response.user_detail);
      });
    },
    getTableData: function (data) {
      this.tableData = [];
      this.experienceVisible = [];
      data.forEach((item) => {
        this.tableData.push({
          univ: item.related_university.short_name,
          univ_fullname: item.related_university.school_name,
          program: item.related_program,
          semester: item.enrolledSemester,
          result: item.result,
          program_experience: item.comments,
          program_summary: item.summary,
        });
        this.experienceVisible.push(false);
      });
    },
  },
};
</script>

<style scoped>
.app-container {
  margin: 0 auto;
  width: 1200px;
  height: 100%;
  /* float: left; */
  display: flex;
}
.aside {
  width: 200px;
  height: 100%;
}
.content {
  margin: 0 auto;
  width: 850px;
  height: 100%;
}
.content-block {
  padding-bottom: 30px;
}
.info-item {
  margin-top: 15px;
}
.highlight {
  color: #409eff;
  font-weight: bold;
  display: inline-block;
}
.bold {
  font-weight: 550;
}
.el-row {
  width: 100%;
}
.el-table {
  width: 800px;
  /* margin-top: 50px; */
  /* width: 1200px; */
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
.dialog .dialog-button {
  position: absolute;
  right: 5%;
  bottom: 3%;
}
.dialog .dialog-title {
  font-size: 16px;
  color: #409eff;
  font-weight: bolder;
}
.mini-title {
  font-size: 1.2em;
  color: #409eff;
  font-weight: bolder;
}
</style>

<template>
  <div class="app-container">
    <div class="aside">
      <div>
        <h2 class="highlight">{{ user.nickname }}</h2>
      </div>
      <div class="highlight">
        <i class="el-icon-alidianzan"> 获得 {{ user.all_votes_cnt }} 次点赞</i>
      </div>
      <div class="info-item">
        <div class="mini-title">学院</div>
        <!-- <el-divider content-position="left"></el-divider> -->
        <!-- <div class="bold">学院：</div> -->
        <div>{{ user.school | schoolFilter }}</div>
      </div>
      <div class="info-item">
        <div class="mini-title">在校身份</div>
        <!-- <el-divider content-position="left"><div class="mini-title">在校身份</div></el-divider> -->
        <!-- <span class="bold">在校身份：</span> -->
        <span>{{ user.isUndergrad | isUndergradFilter }}</span>
      </div>
      <div class="info-item">
        <div class="mini-title">最终去向</div>
        <!-- <el-divider content-position="left"><div class="mini-title">最终去向</div></el-divider> -->
        <!-- <div class="bold">最终去向：</div> -->
        <div class="bold">{{ user.final_university }}</div>
        <div>{{ user.final_program }}</div>
      </div>
      <div class="info-item">
        <div class="mini-title">联系方式</div>
        <!-- <el-divider content-position="left"><div class="mini-title">联系方式</div></el-divider> -->
        <!-- <div class="bold">联系方式：</div> -->
        <div>{{ user.contact }}</div>
      </div>
    </div>
    <a class="anchor" id="background"></a>
    <div class="content">
      <div class="content-block">
        <el-row>
          <h2 class="highlight">申请背景</h2>
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
      <a class="anchor" id="admissions"></a>
      <div class="content-block">
        <el-row>
          <h2 class="highlight">录取信息</h2>
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
                    type="text"
                    icon="el-icon-alidianzan"
                    size="small"
                    @click="downvote(row)"
                    >已点赞 {{ row.upvoted_count }}</el-button
                  >
                  <el-button
                    v-else
                    type="text"
                    icon="el-icon-alidianzan1"
                    size="small"
                    @click="upvote(row)"
                    >点赞 {{ row.upvoted_count }}</el-button
                  >
                </div>
              </el-dialog>
            </template>
          </el-table-column>
        </el-table>
      </div>
      <a class="anchor" id="summary"></a>
      <div class="content-block">
        <el-row>
          <el-col :span="6">
            <h2 class="highlight">申请总结</h2>
          </el-col>
          <el-col :span="18">
           <!-- <h2><i class="cil-thumb-up highlight"> {{ user.all_votes_cnt }}</i></h2>  -->
           
          </el-col>
        </el-row>
        <el-button
            v-if="background.upvoted"
            type="text"
            icon="el-icon-alidianzan"
            @click="downvoteBackground()"
            >已点赞 {{ background.upvoted_count }}</el-button
          >
          <el-button
            v-else
            type="text"
            icon="el-icon-alidianzan1"
            @click="upvoteBackground()"
            >点赞 {{ background.upvoted_count }}</el-button
          >
        <!-- <CIcon name="cil-pencil">
        <CIcon name="cilSettings">
        <i class="cil-thumb-up"></i> -->
        <h3><i class="el-icon-arrow-right highlight"> 申请方向的思考</i></h3>
        <div v-html="background.comments" />
        <h3><i class="el-icon-arrow-right highlight"> 申请感言</i></h3>
        <div v-html="background.summary" />
      </div>
    </div>
  </div>
</template>

<script>

import { get_user_profile } from "@/api/user";
import { admissions_get_user, admissions_upvote,
  admissions_downvote, } from "@/api/admission";
import { background_get_user, background_upvote,
  background_downvote, } from "@/api/background";
// import { getInfo } from "@/api/user";
// import { admissions_get_my } from "@/api/admission";
// import { background_get_my } from "@/api/background";
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
  // components:{
  //   'CIcon':ElementTiptap,
  // },
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
      user_id: null,
      user: {
        nickname: "",
        all_votes_cnt: 0,
        school: 0,
        isUndergrad: null,
        contact: "",
        final_university: "",
        final_program: null,
      },
      background: {
        id: null,
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
        upvoted: false,
        upvoted_count: 0,
      },
      tableData: [],
      experienceVisible: [],
    };
  },
  mounted() {
    this.user_id = this.$route.params.id;
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
      get_user_profile(this.user_id).then((response) => {
        // this.user = response.user_detail;
        this.user.nickname = response.user_detail.nickname;
        this.user.all_votes_cnt = response.user_detail.all_votes_cnt;
        this.user.school = response.user_detail.school;
        this.user.isUndergrad = response.user_detail.isUndergrad;
        this.user.contact = response.user_detail.contact;
        this.user.final_university = response.user_detail.final_university.school_name;
        this.user.final_program = response.user_detail.final_program;
      });
    },
    getBackground: function () {
      background_get_user(this.user_id).then((response) => {
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
      admissions_get_user(this.user_id).then((response) => {
        this.getTableData(response.user_detail);
        // hash to anchor after getting all data
        if(location.hash) {
          setTimeout("document.querySelector(location.hash).scrollIntoView(true)", 100);
        }
      });
    },
    getTableData: function (data) {
      this.tableData = [];
      this.experienceVisible = [];
      data.forEach((item) => {
        this.tableData.push({
          id: item.id,
          univ: item.related_university.short_name,
          univ_fullname: item.related_university.school_name,
          program: item.related_program,
          semester: item.enrolledSemester,
          result: item.result,
          program_experience: item.comments,
          program_summary: item.summary,
          upvoted: item.upvoted,
          upvoted_count: item.upvoted_count,
        });
        this.experienceVisible.push(false);
      });
    },
    upvote(admission) {
      admissions_upvote(admission.id)
        .then(() => {
          admission.upvoted = true;
          admission.upvoted_count += 1;
          this.user.all_votes_cnt += 1;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    downvote(admission) {
      admissions_downvote(admission.id)
        .then(() => {
          admission.upvoted = false;
          admission.upvoted_count -= 1;
          this.user.all_votes_cnt -= 1;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    upvoteBackground() {
      background_upvote(this.background.id)
        .then(() => {
          this.background.upvoted = true;
          this.background.upvoted_count += 1;
          this.user.all_votes_cnt += 1;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    downvoteBackground() {
      background_downvote(this.background.id)
        .then(() => {
          this.background.upvoted = false;
          this.background.upvoted_count -= 1;
          this.user.all_votes_cnt -= 1;
        })
        .catch((err) => {
          console.log(err);
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
  width: 220px;
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
  padding: 10px 0px;
  line-height: 30px;
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
  font-size: 1.1em;
  color: #409eff;
  font-weight: bolder;
}
</style>

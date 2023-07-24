<template>
  <div class="app-container">
    <div>
      <router-link
        :to="`/report_research/${
          is_background_initial ? 'initial' : 'not_initial'
        }`"
      >
        <el-button
          v-if="is_research_initial"
          type="success"
          size="default"
          style="margin-bottom: 20px"
          icon="el-icon-edit"
          >汇报我的暑研情况</el-button
        >
        <el-button
          v-else
          type="warning"
          size="default"
          style="margin-bottom: 20px"
          icon="el-icon-edit"
          >更新我的暑研情况</el-button
        >
      </router-link>
      <div>
        <div class="filter-container">
          <el-select
            v-model="query.major"
            filterable
            clearable
            placeholder="专业"
            size="small"
          >
            <el-option
              v-for="[value, label] in Object.entries(major_list)"
              :key="value"
              :label="label"
              :value="value"
            ></el-option>
          </el-select>
          <el-select
            v-model="query.rank"
            clearable
            placeholder="成绩排名"
            size="small"
          >
            <el-option
              v-for="[value, label] in Object.entries(rank_list)"
              :key="value"
              :label="label"
              :value="value"
            >
            </el-option>
          </el-select>
          <el-select
            v-model="query.apply_for"
            clearable
            placeholder="主申方向"
            size="small"
          >
            <el-option
              v-for="[value, label] in Object.entries(applyfor_filter)"
              :key="value"
              :label="label"
              :value="value"
            >
            </el-option>
          </el-select>
          <el-select
            v-model="query.tags"
            multiple
            clearable
            placeholder="背景 Tag"
            style="width: 25%"
            size="small"
          >
            <el-option
              v-for="[value, label] in Object.entries(tag_list)"
              :key="value"
              :label="label"
              :value="value"
            >
            </el-option>
          </el-select>
        </div>

        <div class="filter-container">
          <el-select
            v-model="query.related_university"
            filterable
            clearable
            remote
            placeholder="请输入学校"
            :remote-method="querySearchUniv"
            :loading="univ_loading"
            @change="query.related_program = null"
            size="small"
            ><el-option
              class="university"
              v-for="univ in current_univ_list"
              :key="univ.id"
              :label="univ.school_name"
              :value="univ.id"
            >
              <div class="name">
                {{ univ.short_name }}-{{ univ.school_name_cn }}
              </div>
              <div class="line2">
                <span class="fullname">{{ univ.school_name }}</span>
                <span class="area">{{ univ.area }}</span>
              </div>
            </el-option>
          </el-select>
          <el-autocomplete
            v-model="query.related_program"
            :fetch-suggestions="querySearchProgram"
            @focus="getPrograms"
            @clear="clearFocus"
            placeholder="请输入项目"
            popper-class="program"
            clearable
            :ref="'autocomplete'"
            size="small"
          >
            <template slot-scope="{ item }">
              <div class="name">{{ item.name }}</div>
              <div class="fullname">{{ item.full_name }}</div>
            </template>
          </el-autocomplete>
          <el-select
            v-model="query.enrolledSemester"
            placeholder="入学时间"
            filterable
            clearable
            size="small"
          >
            <el-option
              v-for="semester in semester_list"
              :key="semester"
              :label="semester"
              :value="semester"
            ></el-option>
          </el-select>
          <!-- <el-select v-model="query.result" placeholder="录取结果">
              <el-option
                v-for="[label, value] in Object.entries(result_list)"
                :key="label"
                :label="label"
                :value="value"
              ></el-option>
            </el-select> -->
          <el-button-group>
            <el-button
              type="primary"
              icon="el-icon-search"
              @click="handleSearch"
              size="small"
            >
              搜索
            </el-button>
            <el-button
              type="primary"
              icon="el-icon-refresh-right"
              @click="clearSearch"
              size="small"
            >
              重置
            </el-button>
          </el-button-group>
        </div>

        <el-table
          :data="table_data"
          v-loading="table_loading"
          :header-cell-class-name="getHeaderClass"
          fit
          stripe
        >
          <el-table-column width="100" align="center">
            <template slot-scope="{ row }">
              <router-link target="_blank" :to="`/usermain/${row.user_id}`">
                <el-button type="text">{{ row.username }}</el-button>
              </router-link>
            </template>
          </el-table-column>
          <el-table-column label="暑研学校" width="105" align="center">
            <template slot-scope="{ row }">
              <el-tooltip :content="row.univ_fullname" placement="top">
                <div>{{ row.univ }}</div>
              </el-tooltip>
            </template>
          </el-table-column>
          <el-table-column prop="program" label="暑研项目"> </el-table-column>
          <el-table-column
            sortable
            prop="semester"
            label="暑研时间"
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
            label="暑研申请经验"
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
                  <i class="el-icon-arrow-right dialog-title"> 暑研申请经验</i>
                  <p>{{ row.program_experience }}</p>
                </div>
                <div class="dialog-block" v-show="row.program_summary != ''">
                  <i class="el-icon-arrow-right dialog-title"> 暑研体验</i>
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
          <el-table-column label="专业" width="140">
            <template slot-scope="{ row }">
              {{ row.major | majorFilter }}
            </template>
          </el-table-column>
          <el-table-column label="背景" width="220" align="center">
            <template slot-scope="{ row }">
              <el-tag
                v-if="row.background.rank && row.background.rank != 'else'"
                type="success"
                size="mini"
              >
                {{ row.background.rank | rankFilter }}
              </el-tag>
              <el-tag v-if="row.background.apply_for" type="info" size="mini">
                {{ row.background.apply_for | applyFilter }}
              </el-tag>
              <el-tag
                v-for="tag in row.background.tags"
                :type="tag | tagTypeFilter"
                :key="tag"
                size="mini"
              >
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
                      <el-form-item label="方向:" size="mini">
                        <span>{{
                          row.background.apply_for | applyFilter
                        }}</span>
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
                  <el-form-item label="其他标化:" size="mini">
                    <span>{{ row.background.score }}</span>
                  </el-form-item>
                  <el-form-item label="科研/实习背景:" style="text-align: left">
                    <span>
                      <div class="pre-formatted">
                        {{ row.background.researchSpec }}
                      </div>
                    </span>
                  </el-form-item>
                  <el-form-item label="推荐信:" style="text-align: left">
                    <span>
                      <div class="pre-formatted">
                        {{ row.background.referSpec }}
                      </div>
                    </span>
                  </el-form-item>
                </el-form> </el-dialog
              ><br />
              <el-button
                type="text"
                @click="$set(summary_visible, $index, true)"
                >总结与感想</el-button
              >
              <el-dialog
                :visible.sync="summary_visible[$index]"
                custom-class="dialog"
              >
                <div class="dialog-block">
                  <i class="el-icon-arrow-right dialog-title">
                    申请方向的思考</i
                  >
                  <div v-html="row.background.comments" />
                </div>
                <div class="dialog-block">
                  <i class="el-icon-arrow-right dialog-title"> 申请感言</i>
                  <div v-html="row.background.summary" />
                </div>
                <div class="dialog-button">
                  <el-button
                    v-if="row.background.upvoted"
                    type="text"
                    icon="el-icon-alidianzan"
                    size="small"
                    @click="downvoteBackground(row.background)"
                    >已点赞 {{ row.background.upvoted_count }}</el-button
                  >
                  <el-button
                    v-else
                    type="text"
                    icon="el-icon-alidianzan1"
                    size="small"
                    @click="upvoteBackground(row.background)"
                    >点赞 {{ row.background.upvoted_count }}</el-button
                  >
                </div>
              </el-dialog>
            </template>
          </el-table-column>
        </el-table>
      </div>
    </div>
    <el-pagination
      :total="pageNum"
      :current-page="currentPage"
      @current-change="handlePagination"
      :page-size="10"
      layout="total, prev, pager, next, jumper"
    ></el-pagination>
  </div>
</template>

<script>
import {
  // admissions_get_all,
  // admissions_query,
  university_query,
  programs_get,
  research_get_my,
  research_upvote,
  reasearch_downvote,
  research_query_page,
  research_get_all_page,
} from "@/api/research";
import {
  background_get_my,
  background_upvote,
  background_downvote,
} from "@/api/background";
// import { getInfo } from "@/api/user"
import {
  major_list,
  semester_list,
  rank_list,
  applyfor_filter,
  research_tags,
  ref_tags,
  result_list,
} from "@/assets/data.json";
export default {
  name: "Research",
  filters: {
    isInitialFilter(value) {
      const map = {
        true: 1,
        false: 0,
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

  data() {
    return {
      semester_list,
      major_list,
      result_list,
      rank_list,
      applyfor_filter,
      tag_list: [],
      table_data: [],
      table_loading: true,
      experience_visible: [],
      background_visible: [],
      summary_visible: [],
      query: {
        enrolledSemester: "",
        related_university: null,
        related_program: "",
        major: "",
        rank: "",
        apply_for: "",
        tags: [],
      },
      univ_loading: false,
      current_univ_list: [],
      current_program_list: [],
      is_background_initial: true,
      is_research_initial: true,
      pageNum: 0,
      currentPage: 1,
      isNotQuery: true,
    };
  },
  created() {
    this.tag_list = Object.assign({}, research_tags, ref_tags);
    research_get_my()
      .then((response) => {
        this.is_research_initial = response.user_detail.length == 0;
      })
      .catch(() => {
        this.is_research_initial = true;
      });
    background_get_my()
      .then(() => {
        this.is_background_initial = false;
      })
      .catch(() => {
        this.is_background_initial = true;
      });

    this.isNotQuery = true;
    this.handlePagination(1);
  },
  methods: {
    getHeaderClass() {
      return "table-header";
    },
    filterResult(value, row) {
      return value === row.result;
    },
    clearSearch() {
      this.query = {
        enrolledSemester: "",
        related_university: null,
        related_program: "",
        major: "",
        rank: "",
        apply_for: "",
        tags: [],
      };
      this.isNotQuery = true;
      this.handlePagination(1);
    },
    handleSearch() {
      this.removeEmpty(this.query);
      // console.log(this.query);
      this.isNotQuery = false;
      this.handlePagination(1);
    },
    handlePagination(pageNo) {
      this.currentPage = pageNo;
      this.table_loading = true;
      if (this.isNotQuery) {
        research_get_all_page(pageNo).then((response) => {
          this.getTableData(response.results);
          this.table_loading = false;
          this.pageNum = response.count;
        });
      } else {
        research_query_page(this.query, pageNo).then((response) => {
          this.getTableData(response.results);
          this.table_loading = false;
          this.pageNum = response.count;
        });
      }
    },
    // getTable() {
    //   this.table_loading = true;
    //   if (this.isNotQuery) {
    //     admissions_get_all().then((response) => {
    //       this.getTableData(response.results);
    //       this.table_loading = false;
    //       this.pageNum = response.count;
    //     });
    //   } else {
    //     admissions_query(this.query).then((response) => {
    //       this.getTableData(response.results);
    //       this.table_loading = false;
    //       this.pageNum = response.count;
    //     });
    //   }
    // },
    getTableData(data) {
      this.table_data = [];
      this.experience_visible = [];
      this.background_visible = [];
      this.summary_visible = [];
      data.forEach((item) => {
        this.table_data.push({
          id: item.id,
          username: item.related_user.username,
          user_id: item.related_user.id,
          univ: item.related_university.short_name,
          univ_fullname: item.related_university.school_name,
          program: item.related_program,
          semester: item.enrolledSemester,
          result: item.result,
          program_experience: item.comments,
          program_summary: item.summary,
          upvoted: item.upvoted,
          upvoted_count: item.upvoted_count,
          major: item.related_background.major,
          background: item.related_background,
        });
        this.experience_visible.push(false);
        this.background_visible.push(false);
        this.summary_visible.push(false);
      });
    },
    upvote(reasearch) {
      research_upvote(reasearch.id)
        .then(() => {
          reasearch.upvoted = true;
          reasearch.upvoted_count += 1;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    downvote(reasearch) {
      reasearch_downvote(reasearch.id)
        .then(() => {
          reasearch.upvoted = false;
          reasearch.upvoted_count -= 1;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    upvoteBackground(background) {
      background_upvote(background.id)
        .then(() => {
          background.upvoted = true;
          background.upvoted_count += 1;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    downvoteBackground(background) {
      background_downvote(background.id)
        .then(() => {
          background.upvoted = false;
          background.upvoted_count -= 1;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    querySearchUniv(query_string) {
      if (query_string != "") {
        this.univ_loading = true;
        university_query(query_string).then((response) => {
          this.univ_loading = false;
          this.current_univ_list = response.data;
        });
      } else {
        this.current_univ_list = [];
      }
    },
    async getPrograms() {
      var uid = this.query.related_university;
      await programs_get(uid)
        .then((response) => {
          var programs = [];
          response.data.forEach((program) => {
            programs.push({
              name: program.name,
              full_name: program.full_name,
              value: program.full_name + " (" + program.name + ")",
            });
          });
          this.current_program_list = programs;
        })
        .catch(() => {
          this.current_program_list = [];
        });
    },
    querySearchProgram(query, cb) {
      var programs = this.current_program_list;
      var results = [];
      if (query) {
        results = programs.filter((item) => {
          return item.value.toLowerCase().indexOf(query.toLowerCase()) > -1;
        });
      } else {
        results = programs;
      }
      cb(results);
    },
    clearFocus() {
      this.$refs["autocomplete"].handleFocus();
    },
    removeEmpty(obj) {
      Object.keys(obj).forEach((key) => !obj[key] && delete obj[key]);
    },
  },
};
</script>

<style>
.app-container {
  margin: 0 auto;
  width: 1200px;
  /* display: flex;
    align-items: center;
    flex-direction: column; */
}
.filter-container {
  margin: 10px 0px;
  /* text-align: center; */
}
.el-table {
  /* margin-top: 50px; */
  margin: 0 auto;
  width: 100%;
}

.el-table .table-header {
  text-align: center;
}
.el-table .cell {
  word-break: break-word;
}
.dialog {
  text-align: left;
  position: relative;
  white-space: pre-wrap;
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
.el-button-group {
  margin-left: 15px;
}
.el-pagination {
  margin: 30px;
  text-align: center;
}
</style>

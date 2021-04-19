<template>
  <el-container>
    <el-header>
      <el-steps :active="active" align-center>
        <el-step
          v-for="(step, index) in steps"
          :key="step"
          :title="step"
          @click.native="click_step(index)"
        ></el-step>
      </el-steps>
    </el-header>
    <el-main>
      <div>
        <div v-if="active == 0" class="form">
          <el-form
            :model="form_data.background"
            label-position="right"
            label-width="auto"
          >
            <el-form-item label="专业" size="mini">
              <el-col :span="9">
                <el-select
                  v-model="form_data.background.major"
                  filterable
                  placeholder="请选择"
                >
                  <el-option
                    v-for="item in major_list"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  ></el-option>
                </el-select>
              </el-col>
            </el-form-item>
            <el-form-item label="GPA" size="mini">
              <el-col :span="9">
                <el-input-number
                  v-model="form_data.background.gpa"
                  :precision="2"
                  :step="0.01"
                  :min="1.0"
                  :max="4.3"
                ></el-input-number>
              </el-col>
            </el-form-item>
            <el-form-item label="排名" size="mini">
              <el-col :span="9">
                <el-select
                  v-model="form_data.background.rank"
                  placeholder="请选择"
                >
                  <el-option
                    v-for="item in rank_list"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  ></el-option>
                </el-select>
              </el-col>
            </el-form-item>
            <el-form-item label="托福" size="mini">
              <el-col :span="9">
                <el-input v-model="form_data.background.TOEFL"></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="GRE" size="mini">
              <el-col :span="9">
                <el-input v-model="form_data.background.GRE"></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="科研/实习背景">
              <el-checkbox-group
                v-model="form_data.background.research_tag_list"
              >
                <el-checkbox
                  v-for="tag in research_tags"
                  :key="tag.value"
                  :label="tag.value"
                  >{{ tag.label }}</el-checkbox
                >
              </el-checkbox-group>
              <el-input
                v-model="form_data.background.researchSpec"
                type="textarea"
                :rows="5"
                placeholder="科研实习背景具体描述，Paper发表等"
              ></el-input>
            </el-form-item>
            <el-form-item label="推荐信">
              <el-checkbox-group v-model="form_data.background.ref_tag_list">
                <el-checkbox
                  v-for="tag in ref_tags"
                  :key="tag.value"
                  :label="tag.value"
                  >{{ tag.label }}</el-checkbox
                >
              </el-checkbox-group>
              <el-input
                v-model="form_data.background.referSpec"
                type="textarea"
                :rows="5"
                placeholder="推荐信具体描述"
              ></el-input>
            </el-form-item>
            <el-form-item label="主申方向" size="mini">
              <el-col :span="9">
                <el-select
                  v-model="form_data.background.apply_for"
                  placeholder="请选择"
                >
                  <el-option
                    v-for="item in applyfor_list"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  ></el-option>
                </el-select>
              </el-col>
            </el-form-item>
          </el-form>
        </div>

        <div v-else-if="active == 1" class="form">
          <el-form
            v-for="(item, index) in admissions"
            :key="item"
            label-position="right"
            label-width="90px"
          >
            <el-form-item v-show="index > 0 || admissions.length > 1" label=" ">
              <el-button type="danger" size="mini" @click="del_admission(index)"
                >删除此项</el-button
              >
            </el-form-item>
            <el-row>
              <el-col :span="12">
                <el-form-item label="录取结果" size="mini">
                  <el-select placeholder="请选择" v-model="item.result"
                    ><el-option
                      v-for="result in result_list"
                      :key="result.value"
                      :label="result.label"
                      :value="result.value"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="入学时间" size="mini">
                  <el-select v-model="item.enrolledSemester" filterable placeholder="请选择">
                    <el-option
                      v-for="semester in semester_list"
                      :key="semester"
                      :label="semester"
                      :value="semester"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
            </el-row>

            <el-row>
              <el-col :span="12">
                <el-form-item label="录取学校" size="mini">
                  <el-input></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="录取项目" size="mini">
                  <el-input></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row>
              <el-form-item label="申请经验">
                <el-input
                  type="textarea"
                  :rows="3"
                  placeholder="可包括：1.申请、套磁、面试过程分享 2.项目录取偏好与特殊要求 3.最终是否选择就读该项目的考虑"
                ></el-input>
              </el-form-item>
            </el-row>
            <el-row>
              <el-form-item v-show="item.result == true" label="入学后体验">
                <el-input
                  type="textarea"
                  placeholder="欢迎入学就读后返场分享"
                ></el-input>
              </el-form-item>
            </el-row>
            <el-divider></el-divider>
            <el-form-item v-show="index == admissions.length - 1" label=" ">
              <el-button type="success" size="small" @click="add_admission()"
                >新增录取项</el-button
              >
            </el-form-item>
          </el-form>
        </div>
        <div v-else-if="active == 2" class="form">
          <el-form label-position="right" label-width="auto">
            <el-form-item label="申请方向的思考">
              <el-input
                v-model="form_data.background.summary"
                type="textarea"
                :rows="5"
                placeholder="为什么选择申请这个方向（这些项目），选校/选项目的标准是什么"
              ></el-input>
            </el-form-item>
            <el-form-item label="其他申请感言">
              <el-input
                type="textarea"
                :rows="8"
                placeholder="申请季感言，套磁、文书、面试、英语、中介等各方面的经验与建议"
              ></el-input>
            </el-form-item>
          </el-form>
        </div>
        <div v-else-if="active == 3" class="form">
          <el-form
            label-position="right"
            label-width="auto"
            size="mini"
            class="contact"
          >
            <el-row type="flex" justify="center">
              <el-col :span="9">
                <el-form-item label="QQ">
                  <el-input></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row type="flex" justify="center">
              <el-col :span="9">
                <el-form-item label="微信">
                  <el-input></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row type="flex" justify="center">
              <el-col :span="9">
                <el-form-item label="邮箱">
                  <el-input></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-form>
        </div>
      </div>
    </el-main>
    <el-footer>
      <div class="button">
        <el-button v-show="active > 0" type="primary" @click="last"
          >上一步</el-button
        >
        <el-button v-if="active < 3" type="primary" @click="next"
          >下一步</el-button
        >
        <el-button v-else type="success" @click="handleSubmit">提交</el-button>
      </div>
    </el-footer>
  </el-container>
</template>

<script>
import { background_get_my, background_submit, background_update } from "@/api/admission";
export default {
  name: "Report_Admission",
  data() {
    return {
      active: 0,
      is_initial: true,
      steps: ["个人背景", "录取信息", "申请总结与感想", "联系方式"],
      research_tags: [
        { value: "oversea_research", label: "海外科研" },
        { value: "first_author", label: "顶会/顶刊一作" },
        { value: "paper", label: "有Paper" },
        { value: "internship", label: "工业界实习" },
      ],
      ref_tags: [
        { value: "oversea_refer", label: "海外推" },
        { value: "bigname_refer", label: "牛推" },
        { value: "connection", label: "强Connection推" },
      ],
      tags_mapper: {
        oversea_research: 0,
        first_author: 0,
        paper: 0,
        internship: 0,
        oversea_refer: 1,
        bigname_refer: 1,
        connection: 1,
      },
      major_list: [
        { value: "045", label: "045: 数学系" },
        { value: "046", label: "046: 计算与应用数学系" },
        { value: "047", label: "047: 概率统计系" },
        { value: "002", label: "002: 物理学系" },
        { value: "004", label: "004: 近代物理系" },
        { value: "022", label: "022: 天文学系" },
        { value: "038", label: "038: 光学与光学工程系" },
        { value: "048", label: "048: 工程与应用物理系" },
        { value: "015", label: "015: 工商管理系" },
        { value: "016", label: "016: 管理科学系" },
        { value: "017", label: "017: 统计与金融系" },
        { value: "034", label: "034: MBA中心" },
        { value: "035", label: "035: MPA中心" },
        { value: "039", label: "039: EMBA" },
        { value: "003", label: "003: 化学物理系" },
        { value: "012", label: "012: 应用化学系" },
        { value: "014", label: "014: 材料科学与工程系" },
        { value: "019", label: "019: 化学系" },
        { value: "020", label: "020: 高分子科学与工程系" },
        { value: "008", label: "008: 分子生物学与细胞生物学系" },
        { value: "021", label: "021: 神经生物学与生物物理学系" },
        { value: "031", label: "031: 系统生物学系" },
        { value: "032", label: "032: 医药生物技术系" },
        { value: "071", label: "071: 地球物理与行星科学技术系" },
        { value: "072", label: "072: 地球化学与环境科学系" },
        { value: "005", label: "005: 近代力学系" },
        { value: "009", label: "009: 精密机械与精密仪器系" },
        { value: "013", label: "013: 热科学和能源工程系" },
        { value: "030", label: "030: 安全科学与工程系" },
        { value: "006", label: "006: 电子工程与信息科学系" },
        { value: "010", label: "010: 自动化系" },
        { value: "023", label: "023: 电子科学与技术系" },
        { value: "033", label: "033: 信息安全" },
        { value: "018", label: "018: 外语系" },
        { value: "024", label: "024: 科技史与科技考古系" },
        { value: "025", label: "025: 科技传播与科技政策系" },
        { value: "055", label: "055: 科技哲学系" },
        { value: "056", label: "056: 心理学系" },
        { value: "011", label: "011: 计算机科学与技术系" },
        { value: "044", label: "044: 物流工程硕士中心" },
      ],
      rank_list: [
        { value: "top1%", label: "Top 1%" },
        { value: "top5%", label: "Top 5%" },
        { value: "top10%", label: "Top 10%" },
        { value: "top20%", label: "Top 20%" },
        { value: "top30%", label: "Top 30%" },
        { value: "top50%", label: "Top 50%" },
        { value: "else", label: "其他" },
      ],
      applyfor_list: [
        { value: "phd", label: "Ph.D." },
        { value: "ms", label: "Master" },
        { value: "ms_phd", label: "混申" },
      ],
      result_list: [
        { label: "AD", value: true },
        { label: "Reject", value: false },
      ],
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
      form_data: {
        bg_id: null,
        background: {
          major: "",
          gpa: 4.3,
          rank: "",
          apply_for: "",
          TOEFL: "",
          GRE: "",
          researchSpec: "",
          referSpec: "",
          summary: "",
          tags: [],
          research_tag_list: [],
          ref_tag_list: [],
        },
      },
      get_data: {
        background: null,
      },
      admissions: [
        {
          result: null,
          enrolledSemester: null,
          related_university: null,
          related_program: null,
          comments: "",
          summary: ""
        },
      ],
    };
  },
  created() {
    this.getData();
  },
  methods: {
    last() {
      this.active--;
    },
    next() {
      this.active++;
      if (this.active == 4) this.active = 0;
    },
    click_step(index) {
      this.active = index;
    },
    add_admission() {
      this.admissions.push({
        result: null,
      });
    },
    del_admission(index) {
      this.admissions.splice(index, 1);
    },
    getData() {
      background_get_my()
        .then((response) => {
          this.is_initial = false;
          this.form_data.bg_id = response.user_detail.id;
          this.get_data.background = response.user_detail;
          this.map2form();
        })
        .catch(() => {
          this.is_initial = true;
          console.log("no background data");
        });
    },
    map2form() {
      Object.assign(this.form_data.background, this.get_data.background);
      var tags = this.get_data.background.tags;
      for (const item of tags) {
        console.log(item);
        // console.log(this.tags_mapper[item]);
        if (this.tags_mapper[item] == 0) {
          this.form_data.background.research_tag_list.push(item);
        } else if (this.tags_mapper[item] == 1) {
          this.form_data.background.ref_tag_list.push(item);
        } else {
          console.log("tag error:" + item);
        }
      }
    },
    handleSubmit() {
      this.form_data.background.tags = this.form_data.background.research_tag_list.concat(this.form_data.background.ref_tag_list);
      console.log(this.form_data.background);
      if (this.is_initial) {
        background_submit(this.form_data.background).then(() => {
          this.$message({
            message: "提交成功",
            type: "success",
          });
        }).catch(error => {
          this.$message.error(error);
        })
      }
      else {
        background_update(this.form_data.bg_id, this.form_data.background).then(() => {
          this.$message({
            message: "提交成功",
            type: "success",
          });
        }).catch(error => {
          this.$message.error(error);
        })
      }
      // this.removeEmpty(this.form_data.background);
    },
    removeEmpty(obj) {
      Object.keys(obj).forEach((key) => obj[key] == null && delete obj[key]);
    },
  },
};
</script>

<style>
.el-steps {
  width: 100%;
}
.el-main {
  position: relative;
  /* left: 10%; */
}
.el-form-item {
  font-weight: bolder;
}
.el-form {
  margin: auto;
  /* margin: 0px 0px; */
}
.form {
  margin: 0 auto;
  margin-top: 30px;
  width: 600px;

  /* display: inline; */
  /* text-align: center; */
  /* margin: 0px 0px; */
  /* display: flex;
  justify-content: center;
  align-items: center; */
  /* display: table-cell;
  vertical-align: middle;
  text-align: center; */
}
/* .el-row {
  
} */
/* .contact {
  margin: auto;
  width: 35%;
} */
.button {
  /* margin-top: 12px; */
  position: absolute;
  right: 15%;
}
</style>
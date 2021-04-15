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
      <div class="form">
        <el-form
          :model="form_data.background"
          v-if="active == 0"
          label-position="right"
          label-width="auto"
        >
          <el-form-item label="专业" size="mini">
            <el-select
              v-model="form_data.background.major"
              filterable
              placeholder="请选择"
            >
              <el-option
                v-for="item in major_list"
                :key="item"
                :label="item"
                :value="item"
              ></el-option>
            </el-select>
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
            <el-select v-model="form_data.background.rank" placeholder="请选择">
              <el-option
                v-for="item in rank_list"
                :key="item"
                :label="item"
                :value="item"
              ></el-option>
            </el-select>
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
            <el-checkbox-group v-model="form_data.background.research_tag_list">
              <el-checkbox
                v-for="tag in research_tags"
                :key="tag"
                :label="tag"
                >{{ tag }}</el-checkbox
              >
            </el-checkbox-group>
            <el-input
              v-model="form_data.background.researchSpec"
              type="textarea"
              :rows="4"
              placeholder="科研实习具体描述"
            ></el-input>
          </el-form-item>
          <el-form-item label="推荐信">
            <el-checkbox-group v-model="form_data.background.ref_tag_list">
              <el-checkbox v-for="tag in ref_tags" :key="tag" :label="tag">{{
                tag
              }}</el-checkbox>
            </el-checkbox-group>
            <el-input
              v-model="form_data.background.referSpec"
              type="textarea"
              :rows="4"
              placeholder="推荐信具体描述"
            ></el-input>
          </el-form-item>
          <el-form-item label="主申方向" size="mini">
            <el-select
              v-model="form_data.background.applyFor"
              placeholder="请选择"
            >
              <el-option
                v-for="item in applyfor_list"
                :key="item"
                :label="item"
                :value="item"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-form>
        <el-form v-else-if="active == 1">

        </el-form>
        <!-- <el-form v-else-if="active==2">

        </el-form>
        <el-form v-else>

        </el-form> -->
      </div>
    </el-main>
    <el-footer>
      <div class="button">
        <el-button v-show="active > 0" @click="last">上一步</el-button>
        <el-button v-if="active < 3" class="next" @click="next"
          >下一步</el-button
        >
        <el-button v-else class="next" type="primary" @click="next"
          >提交</el-button
        >
      </div>
    </el-footer>
  </el-container>
</template>

<script>
export default {
  name: "Report_Admission",
  data() {
    return {
      active: 0,
      steps: ["个人背景", "录取信息", "申请总结与感想", "联系方式"],
      research_tags: ["海外科研", "顶会/顶刊一作", "有Paper", "工业界实习"],
      ref_tags: ["海外推", "牛推", "强Connection推"],
      major_list: [
        "045: 数学系",
        "046: 计算与应用数学系",
        "047: 概率统计系",
        "002: 物理学系",
        "004: 近代物理系",
        "022: 天文学系",
        "038: 光学与光学工程系",
        "048: 工程与应用物理系",
        "015: 工商管理系",
        "016: 管理科学系",
        "017: 统计与金融系",
        "034: MBA中心",
        "035: MPA中心",
        "039: EMBA",
        "003: 化学物理系",
        "012: 应用化学系",
        "014: 材料科学与工程系",
        "019: 化学系",
        "020: 高分子科学与工程系",
        "008: 分子生物学与细胞生物学系",
        "021: 神经生物学与生物物理学系",
        "031: 系统生物学系",
        "032: 医药生物技术系",
        "071: 地球物理与行星科学技术系",
        "072: 地球化学与环境科学系",
        "005: 近代力学系",
        "009: 精密机械与精密仪器系",
        "013: 热科学和能源工程系",
        "030: 安全科学与工程系",
        "006: 电子工程与信息科学系",
        "010: 自动化系",
        "023: 电子科学与技术系",
        "033: 信息安全",
        "018: 外语系",
        "024: 科技史与科技考古系",
        "025: 科技传播与科技政策系",
        "055: 科技哲学系",
        "056: 心理学系",
        "011: 计算机科学与技术系",
        "044: 物流工程硕士中心",
      ],
      rank_list: [
        "Top 1%",
        "Top 5%",
        "Top 10%",
        "Top 20%",
        "Top 30%",
        "Top 50%",
        "其他",
      ],
      applyfor_list: ["Ph.D.", "Master", "混申"],
      form_data: {
        background: {
          major: "",
          GPA: 0,
          rank: "",
          TOEFL: "",
          GRE: "",
          research_tag_list: [],
          researchSpec: "",
          ref_tag_list: [],
          referSpec: "",
          applyFor: "",
        },
        admissions: []
      },
    };
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
.form {
  margin: auto;
  width: 50%;
}
.button {
  margin-top: 12px;
  position: absolute;
  right: 15%;
}
</style>
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
        <el-form v-if="active == 0" label-position="right" label-width="auto">
          <el-form-item label="专业" size="mini">
            <el-select></el-select>
          </el-form-item>
          <el-form-item label="GPA" size="mini">
            <el-col :span="9">
              <el-input type="number" min="0" max="4.3"></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="排名" size="mini">
            <el-select></el-select>
          </el-form-item>
          <el-form-item label="托福" size="mini">
            <el-col :span="9">
              <el-input></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="GRE" size="mini">
            <el-col :span="9">
              <el-input></el-input>
            </el-col>
          </el-form-item>
          <el-form-item label="科研/实习背景">
            <el-checkbox-group v-model="research_tag_list">
              <el-checkbox
                v-for="tag in research_tags"
                :key="tag"
                :label="tag"
                >{{ tag }}</el-checkbox
              >
            </el-checkbox-group>
            <el-input
              type="textarea"
              :rows="4"
              placeholder="科研实习具体描述"
            ></el-input>
          </el-form-item>
          <el-form-item label="推荐信">
            <el-checkbox-group v-model="ref_tag_list">
              <el-checkbox v-for="tag in ref_tags" :key="tag" :label="tag">{{
                tag
              }}</el-checkbox>
            </el-checkbox-group>
            <el-input
              type="textarea"
              :rows="4"
              placeholder="推荐信具体描述"
            ></el-input>
          </el-form-item>
          <el-form-item label="主申方向" size="mini">
            <el-select></el-select>
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
            <el-button v-if="active < 3" class="next" @click="next">下一步</el-button>
            <el-button v-else class="next" type="primary" @click="next">提交</el-button>
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
      ref_tags: ["海外推", "强Connection推"],
      research_tag_list: [],
      ref_tag_list: [],
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
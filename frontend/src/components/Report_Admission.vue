<template>
  <el-container>
    <el-header>
      <el-steps :active="active" align-center>
        <el-step
          v-for="(step, index) in steps"
          :key="step"
          :title="step"
          @click.native="active = index"
        ></el-step>
      </el-steps>
    </el-header>
    <el-main>
      <div>
        <div v-if="active == 0" class="form">
          <el-form
            :model="form_data.background"
            label-position="right"
            label-width="110px"
          >
            <el-form-item label="专业" size="mini">
              <el-col :span="9">
                <el-select
                  v-model="form_data.background.major"
                  filterable
                  clearable
                  placeholder="请选择"
                >
                  <el-option
                    v-for="[value, label] in Object.entries(major_list)"
                    :key="value"
                    :label="label"
                    :value="value"
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
                  clearable
                  v-model="form_data.background.rank"
                  placeholder="请选择"
                >
                  <el-option
                    v-for="[value, label] in Object.entries(rank_list)"
                    :key="value"
                    :label="label"
                    :value="value"
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
            <el-form-item label="其他标化" size="mini">
              <el-col :span="9">
                <el-input
                  v-model="form_data.background.score"
                  placeholder="雅思、GRE Sub 等"
                ></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="科研/实习背景">
              <el-checkbox-group
                v-model="form_data.background.research_tag_list"
              >
                <el-checkbox
                  v-for="[value, label] in Object.entries(research_tags)"
                  :key="value"
                  :label="value"
                  >{{ label }}</el-checkbox
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
                  v-for="[value, label] in Object.entries(ref_tags)"
                  :key="value"
                  :label="value"
                  >{{ label }}</el-checkbox
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
                  clearable
                  v-model="form_data.background.apply_for"
                  placeholder="请选择"
                >
                  <el-option
                    v-for="[value, label] in Object.entries(applyfor_list)"
                    :key="value"
                    :label="label"
                    :value="value"
                  ></el-option>
                </el-select>
              </el-col>
            </el-form-item>
          </el-form>
        </div>

        <div v-show="active == 1" class="form">
          <report-item
            v-for="(item, index) in admissions"
            :key="index"
            :id="index"
            ref="admission_forms"
            :data="item"
            :univ_list="univ_list[index]"
          >
            <!-- <el-button
              v-if="index > 0 || admissions.length > 1"
              type="danger"
              size="mini"
              @click="del_admission(index)"
              >删除此项</el-button
            > -->
            <el-button
              v-if="index > 0 || admissions.length > 1"
              type="danger"
              size="small"
              @click="del_admission(index)"
              icon="el-icon-delete"
              style="position: relative; left: 640px"
              circle
            >
            </el-button>
          </report-item>
          <!-- <el-form
            :rules="admission_rules"
            v-for="(item, index) in admissions"
            :key="index"
            :model="admissions[index]"
            :id="index"
            ref="admission_forms"
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
                <el-form-item label="录取结果" size="mini" prop="result">
                  <el-select placeholder="请选择" v-model="item.result"
                    ><el-option
                      v-for="[label, value] in Object.entries(result_list)"
                      :key="label"
                      :label="label"
                      :value="value"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item
                  label="入学时间"
                  size="mini"
                  prop="enrolledSemester"
                >
                  <el-select
                    v-model="item.enrolledSemester"
                    filterable
                    placeholder="请选择"
                  >
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
                <el-form-item label="录取学校" prop="related_university">
                  <el-select
                    v-model="item.related_university"
                    filterable
                    clearable
                    remote
                    placeholder="请输入学校"
                    :remote-method="(query) => querySearchUniv(query, index)"
                    :loading="univ_loading"
                    @change="admissions[index].related_program = null"
                    ><el-option
                      class="university"
                      v-for="univ in current_univ_list[index]"
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
                    </el-option></el-select
                  >
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="录取项目" prop="related_program">
                  <el-autocomplete
                    v-model="item.related_program"
                    :fetch-suggestions="
                      (query, cb) => querySearchProgram(query, index, cb)
                    "
                    @focus="getPrograms(index)"
                    @clear="clearFocus(index)"
                    placeholder="请输入项目"
                    popper-class="program"
                    clearable
                    :ref="index + 'autocomplete'"
                  >
                    <template slot-scope="{ item }">
                      <div class="name">{{ item.name }}</div>
                      <div class="fullname">{{ item.full_name }}</div>
                    </template>
                  </el-autocomplete>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row>
              <el-form-item label="申请经验">
                <el-input
                  v-model="item.comments"
                  type="textarea"
                  :rows="3"
                  placeholder="可包括：1.申请、套磁、面试过程分享 2.项目录取偏好与特殊要求 3.最终是否选择就读该项目的考虑"
                ></el-input>
              </el-form-item>
            </el-row>
            <el-row>
              <el-form-item v-show="item.result == true" label="入学后体验">
                <el-input
                  v-model="item.summary"
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
          </el-form> -->
          <el-button
            type="success"
            icon="el-icon-plus"
            size="medium"
            @click="add_admission()"
            round
            style="position: relative; left: 20px"
            >新增录取项</el-button
          >
        </div>
        <div v-if="active == 2" class="form">
          <el-form label-position="right" label-width="110px">
            <el-form-item label="申请方向的思考">
              <tiptap-editor
                v-model="form_data.background.comments"
                placeholder="请输入文章内容"
                height="300"
              />
            </el-form-item>
            <el-form-item label="其他申请感言">
              <tiptap-editor
                v-model="form_data.background.summary"
                placeholder="请输入文章内容"
                height="300"
              />
            </el-form-item>
          </el-form>
        </div>
        <div v-else-if="active == 3" class="form">
          <el-form label-position="right" label-width="70px">
            <el-form-item label="联系方式">
              <el-input
                v-model="contact"
                type="textarea"
                :rows="4"
                placeholder="QQ，微信，邮箱等任何方便学弟学妹联系你的方式"
              ></el-input>
            </el-form-item>
          </el-form>
        </div>
      </div>
    </el-main>
    <el-footer>
      <div class="button">
        <el-button v-show="active > 0" type="primary" @click="active--"
          >上一步</el-button
        >
        <el-button ref="next" v-if="active < 3" type="primary" @click="active++"
          >下一步</el-button
        >
        <el-button v-else type="success" @click="handleSubmit">提交</el-button>
      </div>
    </el-footer>
  </el-container>
</template>

<script>
import {
  // university_query,
  // programs_get,
  admissions_get_my,
  // admissions_create,
  // admissions_update,
  admissions_delete,
} from "@/api/admission";
import {
  background_get_my,
  background_submit,
  background_update,
} from "@/api/background";
import { getInfo, update_contact } from "@/api/user";
import {
  major_list,
  semester_list,
  rank_list,
  applyfor_list,
  result_list,
  research_tags,
  ref_tags,
  tags_mapper,
} from "@/assets/data.json";
import TiptapEditor from "./TiptapEditor"
import ReportItem from "./ReportItem";
export default {
  name: "Report_Admission",
  components: {
    ReportItem,
    TiptapEditor
  },
  data() {
    return {
      active: 0,
      is_initial: true,
      steps: ["个人背景", "录取信息", "申请总结与感想", "联系方式"],
      research_tags,
      ref_tags,
      tags_mapper,
      major_list,
      rank_list,
      applyfor_list,
      result_list,
      semester_list,
      admission_rules: {
        result: [{ required: true, message: "请选择结果", trigger: "blur" }],
        enrolledSemester: [
          { required: true, message: "请选择入学时间", trigger: "blur" },
        ],
        related_university: [
          { required: true, message: "请输入录取学校", trigger: "blur" },
        ],
        related_program: [
          { required: true, message: "请输入录取项目", trigger: "change" },
        ],
      },
      form_data: {
        bg_id: null,
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
          summary: "",
        },
      ],
      univ_list: [[]],
      // program_list:[[]],
      delete_ids: [],
      // univ_loading: false,
      // current_univ_list: [[]],
      // current_program_list: [[]],
      user_id: null,
      contact: "",
      
    };
  },

  created() {
    this.is_initial =
      this.$route.params.is_initial === "initial" ? true : false;
    this.getData();
  },
  methods: {
    add_admission() {
      this.admissions.push({
        result: null,
        enrolledSemester: null,
        related_university: null,
        related_program: null,
        comments: "",
        summary: "",
      });
      this.univ_list.push([]);
      // this.program_list.push([]);
      // this.current_univ_list.push([]);
      // this.current_program_list.push([]);
    },
    del_admission(index) {
      console.log(index);
      if (this.admissions[index].id) {
        this.delete_ids.push(this.admissions[index].id);
      }
      this.admissions.splice(index, 1);
      this.univ_list.splice(index, 1);
      // this.program_list.splice(index, 1);
      // this.current_univ_list.splice(index, 1);
      // this.current_program_list.splice(index, 1);
    },

    // querySearchUniv(query_string, index) {
    //   if (query_string != "") {
    //     this.univ_loading = true;
    //     university_query(query_string).then((response) => {
    //       this.univ_loading = false;
    //       this.$set(this.current_univ_list, index, response.data);
    //     });
    //   } else {
    //     this.$set(this.current_univ_list, index, []);
    //   }
    // },

    // async getPrograms(index) {
    //   var uid = this.admissions[index].related_university;
    //   await programs_get(uid)
    //     .then((response) => {
    //       var programs = [];
    //       response.data.forEach((program) => {
    //         programs.push({
    //           name: program.name,
    //           full_name: program.full_name,
    //           value: program.full_name + " (" + program.name + ")",
    //         });
    //       });
    //       this.$set(this.current_program_list, index, programs);
    //     })
    //     .catch(() => {
    //       this.$set(this.current_program_list, index, []);
    //     });
    // },
    // querySearchProgram(query, index, cb) {
    //   var programs = this.current_program_list[index];
    //   var results = [];
    //   if (query) {
    //     results = programs.filter((item) => {
    //       return item.value.toLowerCase().indexOf(query.toLowerCase()) > -1;
    //     });
    //   } else {
    //     results = programs;
    //   }
    //   cb(results);
    // },
    // clearFocus(index) {
    //   this.$refs[index + "autocomplete"][0].handleFocus();
    // },

    getData() {
      if (this.is_initial == false) {
        background_get_my()
          .then((response) => {
            this.form_data.bg_id = response.user_detail.id;
            this.get_data.background = response.user_detail;
            this.map2form();
          })
          .catch((error) => {
            console.log(error);
          });
        admissions_get_my().then((response) => {
          let data = response.user_detail;
          console.log(data, data.length);
          for (let i = 0; i < data.length; i++) {
            console.log(data[i]);
            this.$set(this.admissions, i, {
              result: data[i].result,
              enrolledSemester: data[i].enrolledSemester,
              comments: data[i].comments,
              summary: data[i].summary,
              related_university: data[i].related_university.id,
              // related_university_full: data[i].related_university,
              related_program: data[i].related_program,
              id: data[i].id,
            });
            this.$set(this.univ_list, i, [data[i].related_university]);
            // this.$set(this.univ_list, i, [data[i].related_university]);
          }
          console.log(response, this.admissions, this.univ_list);
        });
      }
      getInfo().then((response) => {
        this.user_id = response.user_detail.id;
        this.contact = response.user_detail.contact;
      });
    },
    map2form() {
      Object.assign(this.form_data.background, this.get_data.background);
      var tags = this.get_data.background.tags;
      for (const item of tags) {
        if (item) {
          if (this.tags_mapper[item] == 0) {
            this.form_data.background.research_tag_list.push(item);
          } else if (this.tags_mapper[item] == 1) {
            this.form_data.background.ref_tag_list.push(item);
          } else {
            console.log("tag error:" + item);
          }
        }
      }
    },
    async handleSubmit() {
      this.form_data.background.tags = this.form_data.background.research_tag_list.concat(
        this.form_data.background.ref_tag_list
      );
      if (!this.form_data.background.major) {
        this.form_data.background.major = null;
      }
      var ad_forms = this.$refs["admission_forms"];
      var valid_funcs = [];
      ad_forms.forEach((form, index) => {
        valid_funcs.push(
          form.validateForm().catch(() => {
            throw index;
          })
          // new Promise((resolve, reject) => {
          //   form.validateForm((valid) => {
          //     if (valid) {
          //       resolve(index);
          //     } else {
          //       reject(index);
          //     }
          //   });
          // })
        );
      });
      var is_valid = await Promise.all(valid_funcs).then(
        () => {
          console.log("AD validated");
          return true;
        },
        (error_index) => {
          console.log("AD form error in form " + error_index);
          this.active = 1;
          window.location.hash = "#" + error_index;
          return false;
        }
      );
      // .catch((index) => {
      //   console.log("AD form error in form " + index);
      //   this.active = 1;
      //   window.location.hash = "#" + index;
      //   return false;
      // });
      if (!is_valid) return;
      if (!this.form_data.background.gpa) {
        this.form_data.background.gpa = null;
      }
      if (this.is_initial) {
        await background_submit(this.form_data.background)
          .then((response) => {
            console.log(response);
          })
          .catch((error) => {
            console.log(error);
          });
      } else {
        await background_update(this.form_data.bg_id, this.form_data.background)
          .then((response) => {
            console.log(response);
          })
          .catch((error) => {
            console.log(error);
          });
      }

      var edit_funcs = [];
      // var func = null;
      ad_forms.forEach((form) => {
        edit_funcs.push(form.submitForm());
      });
      // this.admissions.forEach((item) => {
      //   if (item.result == false) item.summary = "";
      //   if (item.id) {
      //     func = new Promise((resolve, reject) => {
      //       admissions_update(item.id, item)
      //         .then((response) => {
      //           console.log(response);
      //           resolve();
      //         })
      //         .catch((error) => {
      //           reject(error);
      //         });
      //     });
      //   } else {
      //     func = new Promise((resolve, reject) => {
      //       admissions_create(item)
      //         .then((response) => {
      //           console.log(response);
      //           resolve();
      //         })
      //         .catch((error) => {
      //           reject(error);
      //         });
      //     });
      //   }
      //   edit_funcs.push(func);
      // });
      this.delete_ids.forEach((id) => {
        edit_funcs.push(
          new Promise((resolve, reject) => {
            admissions_delete(id)
              .then((response) => {
                console.log(response);
                resolve();
              })
              .catch((error) => {
                reject(error);
              });
          })
        );
      });
      edit_funcs.push(
        new Promise((resolve, reject) => {
          update_contact(this.user_id, { contact: this.contact })
            .then((response) => {
              console.log(response);
              resolve();
            })
            .catch((error) => {
              reject(error);
            });
        })
      );
      Promise.all(edit_funcs)
        .then(() => {
          this.$message.success("提交成功");
          this.$router.push({ path: "/admission" });
        })
        .catch((error) => {
          console.log(error);
        });
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

.el-form-item__label {
  font-weight: bolder;
}
.el-form {
  margin: auto;
  /* margin: 0px 0px; */
}
.form {
  margin: 0 auto;
  margin-top: 30px;
  width: 650px;

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
.university,
.program li {
  /* line-height: 10px; */
  padding: 0px 6px;
  height: 40px;
  line-height: 18px;
  font-size: xx-small;
  vertical-align: middle;
}
.university .name,
.program .name {
  font-weight: bolder;
  text-overflow: ellipsis;
  overflow: hidden;
}
.university .line2 {
  display: flex;
  justify-content: space-between;
}
.university .fullname {
  text-align: left;
  width: 80%;
  text-overflow: ellipsis;
  overflow: hidden;
}
.university .area {
  text-align: right;
  width: 20%;
}
.program .fullname {
  text-overflow: ellipsis;
  overflow: hidden;
}
</style>

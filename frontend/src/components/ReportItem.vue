<template>
  <el-form
    :rules="admission_rules"
    :model="data"
    ref="form"
    label-position="right"
    label-width="90px"
  >
    <slot></slot>
    <el-row>
      <el-col :span="12">
        <el-form-item label="录取结果" size="mini" prop="result">
          <el-select placeholder="请选择" v-model="data.result"
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
        <el-form-item label="入学时间" size="mini" prop="enrolledSemester">
          <el-select
            v-model="data.enrolledSemester"
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
            v-model="data.related_university"
            filterable
            clearable
            remote
            placeholder="请输入学校"
            :remote-method="querySearchUniv"
            :loading="univ_loading"
            @change="data.related_program = null"
          >
            <el-option
              class="university"
              v-for="univ in univ_list"
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
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item label="录取项目" prop="related_program">
          <el-autocomplete
            v-model="data.related_program"
            :fetch-suggestions="querySearchProgram"
            @focus="getPrograms"
            @clear="clearFocus"
            placeholder="请输入项目"
            popper-class="program"
            clearable
            ref="autocomplete"
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
          v-model="data.comments"
          type="textarea"
          :rows="3"
          placeholder="可包括：1.申请、套磁、面试过程分享 2.项目录取偏好与特殊要求 3.最终是否选择就读该项目的考虑"
        ></el-input>
      </el-form-item>
    </el-row>
    <el-row>
      <el-form-item v-show="data.result == true" label="入学后体验">
        <el-input
          v-model="data.summary"
          type="textarea"
          placeholder="欢迎入学就读后返场分享"
        ></el-input>
      </el-form-item>
    </el-row>
    <el-divider></el-divider>
  </el-form>
</template>

<script>
import {
  university_query,
  //   university_get,
  programs_get,
  admissions_create,
  admissions_update,
} from "@/api/admission";
import { semester_list, result_list } from "@/assets/data.json";
export default {
  name: "ReportItem",
  props: {
    data: {
      type: Object,
      default: function () {
        return {
          result: null,
          enrolledSemester: null,
          related_university: null,
          related_program: null,
          comments: "",
          summary: "",
        };
      },
      required: true,
    },
    univ_list: {
      type: Array,
      default: function () {
        return [];
      },
      required: true,
    },
    // program_list: {
    //   type: Array,
    //   default: function () {
    //     return [];
    //   },
    //   required: true,
    // },
  },
  watch: {
    // "data.related_university_full": function () {
    //   console.log("watch");
    //   if (this.data.related_university_full) {
    //     this.$set(this.current_univ_list, 0, this.data.related_university_full);
    //   }
    // },
    // "data.related_university": function() {
    //     // if(this.data.related_university && this.current_univ_list.length === 0 ||
    //     //    this.data.related_university && this.current_univ_list.length === 1 && this.data.related_university != this.current_univ_list[0].id){
    //     //     university_get(this.data.related_university).then((response) => {
    //     //         this.current_univ_list = [response];
    //     //     }).catch((error) => {
    //     //         console.log(error);
    //     //     })
    //     // }
    //     console.log(this.univ_list);
    //     if(this.data.related_university && this.univ_list.length === 0){
    //         university_get(this.data.related_university).then((response) => {
    //             this.univ_list = [response];
    //         }).catch((error) => {
    //             console.log(error);
    //         })
    //     }
    // }
  },
  data() {
    return {
      result_list,
      semester_list,
      admission_rules: {
        result: [
          {
            required: true,
            message: "请选择结果",
            trigger: ["blur", "change"],
          },
        ],
        enrolledSemester: [
          {
            required: true,
            message: "请选择入学时间",
            trigger: ["blur", "change"],
          },
        ],
        related_university: [
          {
            required: true,
            message: "请输入录取学校",
            trigger: ["blur", "change"],
          },
        ],
        related_program: [
          {
            required: true,
            message: "请输入录取项目",
            trigger: ["blur", "change"],
          },
        ],
      },
      //   current_univ_list: [],
      //   current_program_list: [],
      program_list: [],
      univ_loading: false,
    };
  },

  methods: {
    querySearchUniv(query_string) {
      if (query_string != "") {
        this.univ_loading = true;
        university_query(query_string).then((response) => {
          this.univ_loading = false;
          //   this.univ_list = response.data;
          response.data.forEach((item, index) => {
            this.$set(this.univ_list, index, item);
          });
          this.univ_list.length = response.data.length;
        });
      } else {
        this.univ_list.length = 0;
      }
      //   console.log(this.univ_list);
    },

    getPrograms() {
      var uid = this.data.related_university;
      programs_get(uid)
        .then((response) => {
          var programs = [];
          response.data.forEach((program) => {
            programs.push({
              name: program.name,
              full_name: program.full_name,
              value: program.full_name + " (" + program.name + ")",
            });
          });
          this.program_list = programs;
        })
        .catch(() => {
          this.program_list = [];
        });
    },
    querySearchProgram(query, cb) {
      var programs = this.program_list;
      var results = [];
      if (query) {
        results = programs.filter((item) => {
          return item.value.toLowerCase().indexOf(query.toLowerCase()) > -1;
        });
      } else {
        results = programs;
      }
      console.log(query, results);
      cb(results);
    },
    clearFocus() {
      this.$refs["autocomplete"].handleFocus();
    },
    validateForm() {
      return new Promise((resolve, reject) => {
        this.$refs["form"].validate((valid) => {
          if (valid) {
            resolve();
          } else {
            reject();
          }
        });
      });
    },
    submitForm() {
      var form = this.data;
      if (form.result == false) form.summary = "";
      if (form.id) {
        return new Promise((resolve, reject) => {
          admissions_update(form.id, form)
            .then((response) => {
              console.log(response);
              resolve();
            })
            .catch((error) => {
              reject(error);
            });
        });
      } else {
        return new Promise((resolve, reject) => {
          admissions_create(form)
            .then((response) => {
              console.log(response);
              resolve();
            })
            .catch((error) => {
              reject(error);
            });
        });
      }
    },
  },
};
</script>

<style></style>

<template>
  <el-form class="create-form" label-position="right" label-width="100px">
    <el-form-item label="用户名/昵称" prop="">
    <el-col :span="13">
      <el-input v-model="form.nickname"></el-input>
    </el-col>
    </el-form-item>
    <el-form-item label="学院">
      <el-col :span="14">
      <el-select
        v-model="form.school"
        filterable
        placeholder="请选择">
        <el-option
          v-for="(school, index) in school_list"
          :key="index"
          :label="school"
          :value="index"></el-option>
      </el-select>
      </el-col>
    </el-form-item>
    <el-form-item label="入学年份" prop="">
      <el-col :span="10">
      <!-- <el-select>
        <el-option
          v-for="year in enrollyear_list"
          :key="year"
          :label="year"
          :value="year"></el-option>
      </el-select> -->
      <el-date-picker
      v-model="form.year"
      type="year"
      placeholder="选择年">
    </el-date-picker>
      </el-col>
    </el-form-item>
    <el-form-item label="在校时身份" prop="">
      <el-col :span="14">
      <el-select v-model="form.student_role">
        <el-option
          v-for="[label, value] in Object.entries(student_role_list)"
          :key="label"
          :label="label"
          :value="value"
        ></el-option>
      </el-select>
      </el-col>
    </el-form-item>
    <el-form-item label="联系方式" prop="">
      <el-input
        v-model="contact"
        type="textarea"
        :rows="3"
        placeholder="QQ，微信，邮箱等任何方便联系你的方式"
      ></el-input>
    </el-form-item>
  </el-form>
</template>

<script>
import { school_list, student_role_list } from "@/assets/data.json"
export default {
  name: "Create_User",
  data() {
    return {
      form: {
        nickname: "",
        school: null,
        year: "",
        student_role: null,
        contact: ""
      },
      school_list,
      student_role_list
    }
  }
};
</script>

<style scoped>
.create-form {
  margin: 0 auto;
  margin-top: 50px;
  width: 500px;
}
</style>
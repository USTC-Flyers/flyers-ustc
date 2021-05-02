<template>
  <el-form
    class="create-form"
    :model="form"
    :rules="rules"
    ref="form"
    label-position="right"
    label-width="100px"
  >
    <el-form-item label="用户名/昵称" prop="nickname">
      <el-col :span="13">
        <el-input v-model="form.nickname"></el-input>
      </el-col>
    </el-form-item>
    <el-form-item label="学院">
      <el-col :span="14">
        <el-select v-model="form.school" filterable placeholder="请选择">
          <el-option
            v-for="(school, index) in school_list"
            :key="index"
            :label="school"
            :value="index"
          ></el-option>
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
        <el-date-picker v-model="form.enrolledYear" type="year" placeholder="选择年">
        </el-date-picker>
      </el-col>
    </el-form-item>
    <el-form-item label="在校时身份" prop="">
      <el-col :span="14">
        <el-select v-model="form.isUndergrad">
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
        v-model="form.contact"
        type="textarea"
        :rows="3"
        placeholder="QQ，微信，邮箱等任何方便联系你的方式"
      ></el-input>
    </el-form-item>
    <el-form-item>
      <el-button type="primary" @click="submitForm">立即创建</el-button>
    </el-form-item>
  </el-form>
</template>

<script>
import { school_list, student_role_list } from "@/assets/data.json";
import { getInfo, create_user_profile, update_user_profile } from "@/api/user";
export default {
  name: "Create_User",
  data() {
    return {
      is_initial: true,
      user_id: null,
      form: {
        nickname: "",
        school: null,
        enrolledYear: "",
        isUndergrad: null,
        contact: "",
      },
      school_list,
      student_role_list,
      rules: {
        nickname: [{ required: true, message: "请填写用户名", trigger: "blur" }],
      }
    };
  },
  async created() {
    this.is_initial = await getInfo().then((response) => {
      this.form = response.user_detail;
      this.user_id = response.user_detail.id;
      return false
    }).catch(() => {
      return true
    })
  },
  methods: {
    submitForm() {
      this.$refs["form"].validate((valid) => {
        if (valid) {
          console.log(this.form);
          if(this.is_initial) {
            create_user_profile(this.form).then(() => {
              this.$message.success("创建成功");
              this.$router.push({ path: "/home" });
            });
          } else {
            update_user_profile(this.user_id, this.form).then(() => {
              this.$message.success("更新成功");
              this.$store.dispatch("user/setInfo", this.form.nickname);
              this.$router.go(-1);
            })
          }
          
        } else {
          return false;
        }
      });
    },
  },
};
</script>

<style scoped>
.create-form {
  margin: 0 auto;
  margin-top: 50px;
  width: 500px;
}
</style>
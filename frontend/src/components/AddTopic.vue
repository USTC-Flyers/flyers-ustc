<template>
  <el-form
    class="create-form"
    :model="form"
    :rules="rules"
    ref="form"
    label-position="right"
    label-width="80px"
  >
    <el-form-item label="板块" prop="category">
      <el-select v-model="form.category">
        <el-option
          v-for="category in categories"
          :key="category"
          :label="category"
          :value="category"
        >
        </el-option>
      </el-select>
      <!-- <el-input v-model="form.category"></el-input> -->
    </el-form-item>
    <el-form-item label="标题" prop="title">
      <el-input v-model="form.title"></el-input>
    </el-form-item>
    <el-form-item>
      <el-button size="small" type="success" @click="submitForm">立即创建</el-button>
    </el-form-item>
  </el-form>
</template>

<script>
import { createTopic, getTopicCategory } from "@/api/wiki";
export default {
  name: "AddTopic",
  data() {
    return {
      form: {
        category: "申请主版",
        title: "",
      },
      categories: [],
      rules: {
        category: [{ required: true, message: "请选择板块", trigger: "blur" }],
        title: [{ required: true, message: "请填写标题", trigger: "blur" }],
      },
    };
  },
  inject: ["reload"],
  created() {
    getTopicCategory()
      .then((response) => {
        this.categories = response.category;
      })
      .catch((err) => {
        console.log(err);
      });
  },
  methods: {
    submitForm() {
      this.$refs["form"].validate((valid) => {
        if (valid) {
          // console.log(this.form);
          createTopic(this.form)
            .then(() => {
              this.$message.success("创建成功");
              // this.$router.push({ path: "/wiki" });
              this.reload();
              this.$forceUpdate();
            })
            .catch((err) => {
              console.log(err);
            });

          // if (this.is_initial) {
          //   create_user_profile(this.form).then(() => {
          //     this.$message.success("创建成功");
          //     this.$router.push({ path: "/home" });
          //   });
          // } else {
          //   update_user_profile(this.user_id, this.form).then(() => {
          //     this.$message.success("更新成功");
          //     this.$store.dispatch("user/setInfo", this.form.nickname);
          //     this.$router.go(-1);
          //   });
          // }
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
  width: 300px;
}
</style>

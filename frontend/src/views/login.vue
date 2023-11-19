<template>
  <div class="page">
    <el-card class="login-card">
      <div class="login-card-title">用户登录</div>
      <div class="login-card-content">
        <el-form
            ref="loginForm"
            :model="loginForm"
            :rules="loginRules"
            class="login-form"
            label-position="top"
        >
          <el-form-item label="邮箱" prop="mail">
            <el-input v-model="loginForm.mail" name="mail" auto-complete="email"/>
          </el-form-item>
          <el-form-item label="验证码" prop="verify_code">
            <el-input
                v-model="loginForm.verify_code"
                autocomplete="off"
                style="width: 220px"
            />
            <el-button style="float: right" @click="sendVerifyCode" :loading="loading.send_verify_code"
                       :disabled="countdownActive">
              {{ countdownActive ? countdown + '秒后重发' : '发送验证码' }}
            </el-button>
          </el-form-item>
          <div style="display: flex;flex-direction: column;gap: 16px;margin-top: 48px;">
            <el-button style="width: 100%" type="primary" @click="mailLogin" :loading="loading.login">登录</el-button>
            <el-button style="width: 100%;margin-left: 0;" type="danger" @click="casLogin">统一认证登录</el-button>
          </div>
        </el-form>
      </div>
    </el-card>
    <!-- <router-view></router-view> -->
  </div>
</template>

<script>
// import login from "@/api/user";
export default {
  name: "Login",
  data() {
    return {
      loginForm: {
        mail: "",
        verify_code: "",
      },
      loading: {
        send_verify_code: false,
        login: false,
      },
      loginRules: {
        mail: [
          {required: true, message: '请输入邮箱', trigger: 'blur'},
          // {pattern: /^[a-zA-Z0-9._-]+@(?:mail\.)?ustc\.edu\.cn$/, message: '请输入正确的教育邮箱', trigger: 'blur'},
        ],
        verify_code: [
          {required: true, message: '请输入验证码', trigger: 'blur'},
        ],
      },
      // ticket: 'fake-ticket',
      redirect: undefined,
      countdownActive: false,
      countdown: 0,
      timer: null
    };
  },
  // watch: {
  //   $route: {
  //     handler: function(route) {
  //       const query = route.query
  //       if (query.redirect) {
  //         this.redirect = query.redirect
  //       }
  //     },
  //     immediate: true
  //   }
  // },
  created() {
    const storedEndTime = localStorage.getItem('countdownEndTime');
    if (storedEndTime && Date.now() < storedEndTime) {
      this.countdown = Math.ceil((storedEndTime - Date.now()) / 1000);
      this.countdownActive = true;
      this.startCountdown();
    }
  },
  beforeDestroy() {
    clearInterval(this.timer);
  },
  methods: {
    startCountdown(countdown) {
      if (countdown) {
        this.countdown = countdown;
        const endTime = Date.now() + countdown * 1000;
        localStorage.setItem('countdownEndTime', endTime);
      }
      this.countdownActive = true;
      this.timer = setInterval(() => {
        const currentTime = Date.now();
        const storedEndTime = localStorage.getItem('countdownEndTime');
        if (currentTime >= storedEndTime) {
          clearInterval(this.timer);
          this.countdownActive = false;
          localStorage.removeItem('countdownEndTime');
        } else {
          this.countdown = Math.ceil((storedEndTime - currentTime) / 1000);
        }
      }, 1000);
    },
    sendVerifyCode() {
      this.$refs.loginForm.validateField('mail', err => {
        if (!err) {
          this.loading.send_verify_code = true
          this.$store.dispatch('user/sendVerifyCode', this.loginForm.mail).then(() => {
            this.$message.success("验证码已发送");
            this.startCountdown(60*5);
          }).catch((e) => {
            this.$message.error(e.response?.data || '发送验证码失败');
          }).finally(() => {
            this.loading.send_verify_code = false;
          })
        }
      })
    },
    mailLogin() {
      this.$refs.loginForm.validate(valid => {
        if (valid) {
          this.loading.login = true
          this.$store.dispatch('user/mailLogin', this.loginForm).then(() => {
            this.$router.push({path: this.redirect})
          }).catch((e) => {
            this.$message.error(e.response?.data || '登录失败');
          }).finally(() => {
            this.loading.login = false
          })
        }
      })
    },
    casLogin() {
      const serviceUrl = `https://ustcflyer.com/login?redirect=/&service=1`;
      window.location.href = `https://sso-proxy.lug.ustc.edu.cn/auth/default?service=${encodeURIComponent(serviceUrl)}`;
    },
  },
  beforeMount() {
    try {
      this.redirect = this.$route.query.redirect.fullPath || "/";
    } catch (e) {
      this.redirect = "/";
    }
    const currentUrl = window.location.href;
    if (currentUrl.includes("ticket")) {
      // const ticket = currentUrl.match(/\?ticket=([\s\S]+?)#/)[1];
      const ticket = currentUrl.match(/ticket=([\s\S]+)/)[1];
      this.$store
          .dispatch("user/login", ticket)
          .then(() => {
            this.$router.push({path: this.redirect});
          })
          .catch(() => {
            console.log("login error");
          });
    } else if (!this.$store.state.token) {
      // const is_test =
      //     process.env.NODE_ENV === "production" ? "/index.html" : "/debug.html";
      // const serviceUrl = `http://home.ustc.edu.cn/~ztl223/ca${is_test}?redirect=${this.redirect}`;
      // const casUrl = `http://passport.ustc.edu.cn/login?service=${serviceUrl}`;

    }
  },
};
</script>

<style lang="scss">
.page {
  width: 100vw;
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;

  .login-card {
    width: 400px;

    &-title {
      text-align: center;
      font-weight: bold;
      font-size: 18px;
    }

    &-content {
      padding: 20px 0;
    }
  }
}
</style>

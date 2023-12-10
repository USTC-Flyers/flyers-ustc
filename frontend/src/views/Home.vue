<template>
  <!-- <img alt="Vue logo" src="../assets/logo.png" />
    <HelloWorld msg="Welcome to Your Vue.js App" /> -->
  <div class="home-container">
    <div class="header">
      <el-menu :default-active="$route.name" mode="horizontal" router>
        <div id="logo">
          <router-link to="/welcome">
            <el-button type="text" icon="el-icon-alifeiji">
              USTC 飞跃网站
            </el-button>
          </router-link>
        </div>
        <span></span>
        <el-menu-item index="admission" :route="{ path: '/admission' }" router
          >录取汇报</el-menu-item
        >
        <el-menu-item index="research" :route="{ path: '/research' }" router
          >暑研汇报</el-menu-item
        >
        <el-menu-item index="wiki" :route="{ path: '/wiki' }" router
          >申请 Wiki</el-menu-item
        >
        <el-menu-item index="forum" :route="{ path: '/discussion' }" router
        >交流讨论</el-menu-item
        >
        <div style="float: right;display: flex;align-items: center">
          <el-button size="small" type="primary" v-if="$route.path==='/discussion'" @click="$router.push('/discussion/create')" style="margin-right: 16px;">写点什么</el-button>
          <el-badge
            :hidden="notificationCount === 0"
            :value="notificationCount"
            id="badge"
            v-show="username !== null"
          >
            <el-button size="small"  @click="handleMessageMore">通知</el-button>
          </el-badge>
          <el-dropdown v-if="username !== null" class="right-float">
            <span class="el-dropdown-link">
              {{ username }}<i class="el-icon-arrow-down el-icon--right"></i>
            </span>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item @click.native="clickUserMain"
                >个人主页</el-dropdown-item
              >
              <el-dropdown-item @click.native="clickUserProfile"
                >个人信息</el-dropdown-item
              >
              <el-dropdown-item divided @click.native="logout">
                退出登录
              </el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>

          <router-link v-else to="/login" class="right-float">
            <el-button size="small" type="primary"> 登录 </el-button>
          </router-link>
        </div>
      </el-menu>
    </div>
    <div class="main">
      <router-view v-if="isRouterAlive"></router-view>
    </div>
  </div>
</template>

<script>
import { initNotificationCount } from "@/api/user";
//import './home.css'
export default {
  name: "Home",
  provide() {
    return {
      reload: this.reload,
      getNotificationCount: this.getNotificationCount,
    };
  },
  data() {
    return {
      activeIndex: "",
      notificationCount: 0,
      // messageList: [],
      // notificationList: [],
      isRouterAlive: true,
    };
  },
  computed: {
    username() {
      return this.$store.getters.name;
    },
  },
  created() {
    // fetch notification
    this.getNotificationCount();
  },
  methods: {
    clickUserMain: function () {
      this.$router.push(`/usermain/${this.$store.getters.user_id}`);
    },
    clickUserProfile: function () {
      this.$router.push("/create_user/not_initial");
    },
    logout: function () {
      this.$store
        .dispatch("user/logout")
        .then(() => {
          // console.log("resp 200");
          this.$router.push({ path: this.redirect || "/" });
        })
        .catch(() => {
          console.log("logout error");
        });
    },
    handleMessageMore() {
      this.$router.push({ path: "/notificaiton" }, () => {});
    },
    getNotificationCount() {
      if (this.$store.getters.token) {
        initNotificationCount().then((response) => {
          this.notificationCount = response.unread_count;
        });
      }
      this.$forceUpdate();
    },
    reload() {
      this.isRouterAlive = false;
      this.$nextTick(() => (this.isRouterAlive = true));
    },
    // handleScroll(){
    //   let scrollTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop
    //   let offsetTop = document.querySelector('#header').offsetTop
    //   scrollTop > offsetTop ? this.headerFixed = true : this.headerFixed = false
    // },
    // handleScroll(){
    //   var scrollTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop
    //   console.log(scrollTop)
    // }
  },
};
</script>

<style lang="scss">
//不能加scoped，不然进入wiki之后顶部就无法固定了
.home-container {
  height: 100vh;
}
.header {
  /* background-color: #409eff; */
  /* display: flex; */
  justify-content: space-between;
  padding: 0;
  line-height: 60px;
  position: fixed;
  z-index: 999; //堆叠等级
  top: 0;
  width: 100%;
}
.main {
  position: relative;
  margin: 0;
  width: 100%;
  min-height: calc(100vh - 60px);
  top: 60px; //指的是margin更以上的距离，即div模块外围距离
  // padding-top:100px;
}
.footer {
  text-align: center;
  padding: 25px;
  // width: 900px;
  // margin: auto;
  // margin: 100px 0px;
}
/* .el-aside {
  background-color: #409eff;
} */
#logo {
  float: left;
  margin: 0 10px 0 20px;
  font-weight: bolder;
  color: #409eff;
}
.el-dropdown-link {
  cursor: pointer;
  color: #409eff;
}

.el-icon-arrow-down {
  font-size: 12px;
}

.right-float {
  float: right;
  padding-right: 15px;
}

.right-menu {
  float: right;
  height: 100%;
}

#badge {
  line-height: 40px;
  display: inline-flex;
  margin-right: 25px;
}
a.anchor {
  display: block;
  position: relative;
  top: -75px;
  visibility: hidden;
}
.pre-formatted {
  white-space: pre-wrap;
  line-height: 30px;
}
/**修改全局的滚动条*/
/**滚动条的宽度*/
::-webkit-scrollbar {
  width: 8px;
}
//滚动条的滑块
::-webkit-scrollbar-thumb {
  background-color: #eeeeee;
  border-radius: 3px;
}
::-webkit-scrollbar-thumb:hover {
  background-color: #d3d3d3;
  border-radius: 3px;
}
</style>

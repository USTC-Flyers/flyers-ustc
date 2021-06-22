<template>
  <!-- <img alt="Vue logo" src="../assets/logo.png" />
    <HelloWorld msg="Welcome to Your Vue.js App" /> -->
  <div class="home-container">
    <div class="header">
      
      <el-menu :default-active="this.$route.path" mode="horizontal" router>
        <!-- <el-menu-item index="/welcome" router
          ></el-menu-item> -->
          <div id="logo">
            <router-link to="/welcome">
              <el-button type="text">
              USTC 飞跃网站
            </el-button>
            </router-link>
            
          </div>
        <span></span>
        <el-menu-item index="/admission" router>录取汇报</el-menu-item>
        <el-menu-item index="/wiki" router>申请 Wiki</el-menu-item>
        <!-- <el-menu-item index="/about" router>关于我们</el-menu-item> -->
        <!-- <el-menu-item index="/notification" router hidden>申请</el-menu-item> -->
        <div style="float: right">
          <!-- <el-dropdown placement="bottom" style="margin-right: 25px"> -->
          <el-badge
            :hidden="notificationCount === 0"
            :value="notificationCount"
            id="badge"
          >
            <el-button size="small" @click="handleMessageMore">通知</el-button>
          </el-badge>
          <!-- <el-dropdown-menu slot="dropdown">
              <el-dropdown-item
                v-for="(message, index) in messageList"
                :key="message + index"
                :id="index + '-' + notificationList[index].id"
              >
                <template>
                  <router-link
                    :to="{
                      path: `${pathMap(notificationList[index].obj_name)}/${
                        notificationList[index].id
                      }/`,
                    }"
                  >
                    <el-button
                      type="text"
                      size="small"
                      @click="readMessage(notificationList[index].id)"
                    >
                      {{ message }}
                    </el-button>
                  </router-link>
                </template>
              </el-dropdown-item>
              <el-dropdown-item @click.native="handleMessageMore">
                更多
              </el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown> -->
          <el-dropdown class="user-name">
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
        </div>

        <!-- <div class="right-menu" v-if="notificationCount > 0 ">
          
          
        </div> -->

        <!-- <div class="right-menu">
          <el-dropdown class="user-name">
            <span class="el-dropdown-link">
              {{ username }}<i class="el-icon-arrow-down el-icon--right"></i>
            </span>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item @click.native="clickUserMain">个人主页</el-dropdown-item>
              <el-dropdown-item @click.native="clickUserProfile">个人信息</el-dropdown-item>
              <el-dropdown-item divided @click.native="logout">
                退出登录
              </el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </div> -->
      </el-menu>

      <!-- <el-menu mode="horizontal">
          <template slot="title">{{submenus.title}}</template>
          <el-menu-item v-for="(item, subIndex) in submenus.menus"
            :index="(index + 1) + '-' + (subIndex + 1)"
            :key="item.key">
              {{item.title}}
          </el-menu-item>
        </el-submenu>
      </el-menu> -->
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
  // mounted() {
  //   window.addEventListener('scroll', this.handleScroll)
  // },
  // destroyed () {
  //   window.removeEventListener('scroll', this.handleScroll)
  // },
  methods: {
    clickUserMain: function () {
      console.log("clickUserMain");
      this.$router.push(`/usermain/${this.$store.getters.user_id}`);
    },
    clickUserProfile: function () {
      console.log("clickUserProfile");
      this.$router.push("/create_user/not_initial");
    },
    logout: function () {
      console.log("click logout");
      this.$store
        .dispatch("user/logout")
        .then(() => {
          console.log("resp 200");
          this.$router.push({ path: this.redirect || "/" });
        })
        .catch(() => {
          console.log("logout error");
        });
    },
    // clickNotification(index) {
    //   console.log("click notification");
    //   const notification = this.notificationList[index];
    //   this.$router.push({
    //     path: "/" + notification.ref_obj_name,
    //     query: { id: notification.id },
    //   });
    // },
    // pathMap(name) {
    //   if (name === "TopicRevision") return "topic_revision";
    //   return name;
    // },
    handleMessageMore() {
      this.$router.push({ path: "/notificaiton" }, () => {});
    },
    getNotificationCount() {
      if(this.$store.getters.token){
        initNotificationCount().then((response) => {
          this.notificationCount = response.unread_count;
        });
      }
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
  margin-top: 0px;
  padding-top: 30px;
  width: 100%;
  top:60px //指的是margin更以上的距离，即div模块外围距离
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

.user-name {
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
  white-space: pre;
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

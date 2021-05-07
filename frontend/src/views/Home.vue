<template>
  <!-- <img alt="Vue logo" src="../assets/logo.png" />
    <HelloWorld msg="Welcome to Your Vue.js App" /> -->
  <el-container class="home-container">
    <el-header>
      <el-menu :default-active="this.$route.path" mode="horizontal" router>
        <el-menu-item index="/admission" router>录取汇报</el-menu-item>
        <el-menu-item index="/wiki" router>申请 WIKI</el-menu-item>
        <div style=" float: right;">
          <el-dropdown>
          <el-badge :value="notificationCount" class="item">
            <el-button size="small">通知</el-button>
          </el-badge>
          <!-- <span class="el-dropdown-link">
              {{ username }}<i class="el-icon-arrow-down el-icon--right"></i>
            </span> -->
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item v-for="(message, index) in messageList" :key="message" :id="index + '-' + notificationList[index].ref_obj_id" @click.native="clickNotification(index)"> {{message}} </el-dropdown-item>
          </el-dropdown-menu>
          </el-dropdown>
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
    </el-header>
    <el-container class="main">
      <router-view></router-view>
    </el-container>
  </el-container>
</template>

<script>
import {initNotification, initNotificationCount} from "@/api/user"
export default {
  name: "Home",
  data() {
    return {
      activeIndex: "",
      notificationCount: 0,
      messageList: null,
      notificationList: null
    };
  },
  computed: {
    username() {
      return this.$store.getters.name;
    },
  },
  created() {
    // fetch notification
    initNotificationCount().then((resp) => {
      this.notificationCount = resp.unread_count;
    }).catch((err) => {
      console.log(err);
    });

    initNotification().then((resp) => {
      console.log("initNotification");
      let data = resp.unread;
      this.messageList = new Array();
      this.notificationList = new Array();
      for (let i = 0; i < data.length; ++i) {
        this.messageList.push(data[i].message);
        this.notificationList.push({
          "id": data[i].ref_obj_id,
          "obj_name": data[i].ref_obj_name,
          "operation": data[i].operation
        });
      }
    }).catch((err) => {
      console.log(err);
    });
  },
  methods: {
    clickUserMain: function () {
      console.log("clickUserMain");
      this.$router.push('/usermain');
    },
    clickUserProfile: function () {
      console.log("clickUserProfile");
      this.$router.push('/create_user');
    },
    logout: function () {
      console.log("click logout");
    },
    clickNotification(index) {
      console.log("click notification");
      const notification = this.notificationList[index];
      this.$router.push({ 'path': '/' + notification.ref_obj_name,  query: {id: notification.id}});
    }
  },
};
</script>

<style scoped lang="scss">
.home-container {
  height: 100vh;
}
.el-header {
  /* background-color: #409eff; */
  /* display: flex; */
  justify-content: space-between;
  padding: 0;
  line-height: 60px;
}
.main {
  margin: auto;
  margin-top: 30px;
  width: 90%;
}
/* .el-aside {
  background-color: #409eff;
} */

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

.item {
  line-height: 40px;
  display: inline-flex;
  margin-right: 40px;
}
</style>

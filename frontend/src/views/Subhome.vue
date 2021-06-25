<template>
    <div class="subhome-container">
        <router-view v-if="isRouterAlive"></router-view>
        <div class="footer">
            <el-divider></el-divider>
            <router-link
                :to="{
                path: '/welcome',
                hash: 'contact',
                }"
            >
                <el-button type="text">
                联系我们
                </el-button>
            </router-link>
            <el-divider direction="vertical"></el-divider>
            <router-link
                :to="{
                path: '/rules',
                }"
            >
                <el-button type="text">
                社区规则
                </el-button>
            </router-link>
            <div>Copyright &copy; 2021 USTC飞跃网站</div>      
        </div>
    </div>
    
</template>
<script>
export default {
    name: "Subhome",
    data() {
        return {
            isRouterAlive: true,
        };
    },
}

</script>

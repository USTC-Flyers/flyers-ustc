<template>
  <div style="background-color: #f3f3f3;padding: 30px 0;min-height: calc(100vh - 60px)">
    <div class="discussion-container">
      <keep-alive>
        <router-view v-if="$route.meta.keepAlive">
        </router-view>
      </keep-alive>

      <router-view v-if="!$route.meta.keepAlive"/>
    </div>
  </div>
</template>

<script>
</script>

<style lang="scss" scoped>
.discussion-container {
  width: 90%;
  max-width: 1280px;
  margin: 0 auto;
  --text: #333;
  --border: #fff;
  --text-color: #333;
  --text-color2: #555;
  --text-color3: #70727c;
  --text-color4: #d8d8d8;
  --text-color5: #fff;
  --text-link-color: #3273dc;
  --text-link-hover-color: #363636;
  --bg-color: #fff;
  --bg-color2: rgba(247, 248, 250, 0.7);
  --bg-color3: #f2f3f5;
  --bg-color4: #f2f2f2;
  --bg-color5: #e8f3ff;
  --bg-color-alpha: rgba(29, 33, 41, 0.5);
  --border-color: #e9e9e9;
  --border-color2: #dcdfe6;
  --border-color3: #8590a6;
  --border-hover-color: #1878f3;
  --color-red: #fa5151;

}
</style>
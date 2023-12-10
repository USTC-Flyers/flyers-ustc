<template>
  <div class="load-more">
    <slot :results="results"/>
    <div class="has-more">
      <el-button type="text"
                 :disabled="!hasMore || loading"
                 @click="loadMore"
      >
        <span v-if="loading" class="icon">
          <i class="el-icon-loading"></i>
        </span>
        <span>{{ hasMore ? '查看更多' : '到底啦' }}</span>
      </el-button>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    // 请求方法
    pageMethod: {
      type: Function,
      required: true,
    },
    // 请求参数
    params: {
      type: Object,
      default() {
        return {}
      },
    },
    // 初始化数据
    initData: {
      type: Object,
      default() {
        return {
          results: [],
          page: 1,
          loading: false,
        }
      },
    },
  },
  data() {
    return {
      page: this.initData.page,
      results: this.initData.results,
      hasMore: false,
      loading: false,
    }
  },
  methods: {
    async loadMore() {
      this.loading = true
      try {
        const ret = await this.pageMethod({
          ...this.params,
          page: this.page,
        })
        if (ret.results && ret.results.length) {
          this.results.push(...ret.results);
        }
        const hasMore = ret.count > this.results.length;
        this.hasMore = hasMore;
        if (hasMore) {
          this.page += 1;
        }
      } catch (err) {
        this.hasMore = false
        console.error(err)
      } finally {
        this.loading = false
      }
    },
    unshiftResults(item) {
      this.results.unshift(item)
    },
    pushResults(item) {
        this.results.push(item)
    },
  },
  mounted() {
    this.loadMore();
  },
}
</script>

<style lang="scss" scoped>
.load-more {
  .has-more {
    text-align: center;
    margin: 20px auto;

    button {
      width: 150px;
    }
  }

  .no-more {
    text-align: center;
    padding: 10px 0;
    color: var(--text-color3);
    font-size: 14px;
  }

  .icon-loading {
    animation: rotating 3s infinite linear;
  }
}
</style>
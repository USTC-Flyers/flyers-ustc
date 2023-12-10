<template>
  <div class="text-editor">
    <textarea
        ref="textarea"
        v-model="content"
        placeholder="请输入您要发表的内容 ..."
        :style="{ 'min-height': height + 'px', height: height + 'px' }"
        @input="onInput"
        @keydown.ctrl.enter="doSubmit"
        @keydown.meta.enter="doSubmit"
    ></textarea>
    <div class="text-editor-bar">
      <div class="text-editor-btn">
        <span>Ctrl/⌘ + Enter</span>
        <el-button type="success" size="small"  @click="doSubmit">
          发布
        </el-button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    height: {
      type: Number,
      default: 120,
    },
    value: {
      type: String,
    },
  },
  data() {
    return {
      content: this.value,
    }
  },
  methods: {
    doSubmit() {
      this.$emit('submit')
    },
    onInput() {
      this.$emit('input', this.content)
    },
    clear() {
      this.content = '';
    },
    focus() {
      this.$refs.textarea.focus()
    },
  },
}
</script>
<style lang="scss" scoped>
.text-editor {
  border: 1px solid var(--border-color);

  textarea {
    box-sizing: border-box;
    width: 100%;
    font-family: inherit;
    background: var(--bg-color2);
    border: 0;
    outline: 0;
    display: block;
    position: relative;
    resize: none;
    line-height: 1.8;
    padding: 15px 15px 20px;
    overflow: auto;
    overscroll-behavior: contain;
    transition: all 100ms linear;
    color: var(--text-color);
  }

  .text-editor-image-uploader {
    padding: 10px;
  }

  .text-editor-bar {
    background-color: var(--bg-color);
    border-top: 1px solid var(--border-color);
    padding: 5px;
    display: flex;
    align-items: center;
    justify-content: space-between;

    .text-editor-actions {
      .text-editor-action-item {
        cursor: pointer;
        color: var(--text-color3);
        user-select: none;

        i,
        span {
          font-size: 16px;
        }

        &:hover {
          color: var(--text-link-color);
        }

        &.active {
          color: var(--text-link-color);
          font-weight: 500;
        }
      }
    }

    .text-editor-btn {
      margin-left: auto;
      display: flex;
      align-items: center;
      span {
        font-size: 12px;
        color: var(--text-color3);
        margin-right: 5px;
      }
    }
  }
}
</style>
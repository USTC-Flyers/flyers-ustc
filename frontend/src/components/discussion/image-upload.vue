<template>
  <div class="image-uploads">
    <div
        v-for="(image, index) in previewFiles"
        :key="index"
        class="preview-item"
        :class="{ deleted: image.deleted }"
        :style="{ width: size, height: size, margin: previewItemMargin }"
    >
      <img :src="image.url" class="image-item"/>
      <el-progress
          v-show="image.progress < 100"
          :percentage="image.progress"
          color="#25A9F6"
          :show-text="false"
          class="progress"
      />
      <div v-show="image.progress < 100" class="cover">上传中...</div>
      <div
          :class="{
          'upload-delete': true,
          'show-delete': image.progress === 100,
        }"
          @click="removeItem(index)"
      >
        <i class="el-icon-delete" style="color: var(--bg-color3)"/>
      </div>
    </div>
    <div
        v-show="previewFiles.length < limit"
        class="add-image-btn"
        :style="{ width: size, height: size }"
        @click="onClick($event)"
    >
      <input
          ref="uploadImage"
          :accept="accept"
          type="file"
          multiple
          @input="onInput"
      />
      <div class="add-image-btn-wrapper">
        <slot name="add-image-button">
          <i class="el-icon-plus"/>
        </slot>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import {uploadImg} from "@/api/discussion";

export default {
  props: {
    value: {
      type: Array,
      default() {
        return []
      },
    },
    accept: {
      type: String,
      default: 'image/*',
    },
    limit: {
      type: Number,
      default: 9,
    },
    sizeLimit: {
      type: Number,
      default: 1024 * 1024 * 20,
    },
    onUpload: {
      type: Boolean,
      default: false,
    },
    size: {
      type: String,
      default: '94px',
    },
  },
  data() {
    return {
      fileList: this.value,
      previewFiles: [],
      currentInput: null,
    }
  },
  computed: {
    previewItemMargin() {
      if (this.previewFiles.length > 1 || this.limit > 1) {
        return '0 10px 10px 0'
      }
      return '0'
    },
  },
  watch: {
    value() {
      this.fileList = this.value.map(it => {
        if (typeof it === "string") {
          return {
            url: it,
            progress: 100,
          }
        }
        return it
      })
    },
    fileList: {
      handler() {
        if (
            this.fileList.length > this.previewFiles.length &&
            this.previewFiles.length === 0
        ) {

          this.previewFiles.push(...this.fileList)
          this.previewFiles.map((item) => {
            item.progress = 100
          })
        }
      },
      deep: true,
      immediate: true,
    },
  },
  methods: {
    onClick() {
      const currentObj = this.$refs.uploadImage
      this.currentInput = currentObj
      currentObj.dispatchEvent(new MouseEvent('click'))
    },
    onInput(e) {
      const files = e.target.files
      this.addFiles(files)
    },
    addFiles(files) {
      if (!files || !files.length) return
      if (!this.checkSizeLimit(files)) return
      if (!this.checkLengthLimit(files)) return

      const fileArray = []
      for (let i = 0; i < files.length; i++) {
        const url = this.getObjectURL(files[i])
        this.previewFiles.push({
          name: files[i].name,
          url,
          progress: 0,
          deleted: false,
          size: files[i].size,
        })
        fileArray.push(files[i])
      }
      const promiseList = fileArray.reduce((result, file, index, array) => {
        result.push(this.uploadFile(file, index, array.length))
        return result
      }, [])
      this.uploadFiles(promiseList)
    },
    async uploadFile(file, index, length) {
      const me = this
      const config = {
        onUploadProgress(progressEvent) {
          if (!progressEvent.lengthComputable) {
            me.previewFiles[
            me.previewFiles.length - length + index
                ].progress = 100
            return
          }
          me.previewFiles[me.previewFiles.length - length + index].progress =
              parseInt(
                  Math.round(
                      (progressEvent.loaded / progressEvent.total) * 100
                  ).toString()
              ) * 0.9
        },
      }
      const uploadArg = await uploadImg();
      const {host, ...otherParams} = uploadArg;
      const formData = new FormData();
      for (const key in otherParams) {
        formData.set(key, otherParams[key]);
      }
      formData.set('success_action_status', 201);
      formData.append('file', file);
      await axios.post(host, formData, config);
      return host + '/' + otherParams.key;
    },
    uploadFiles(promiseList) {
      this.$emit(`update:onUpload`, true)
      Promise.all(promiseList).then(
          (resList) => {
            this.previewFiles.map((item) => {
              item.progress = 100
            })
            resList.forEach((item) => this.fileList.push(item))
            if (this.currentInput) {
              this.currentInput.value = ''
            }
            this.$emit('input', this.fileList)
            this.$emit(`update:onUpload`, false)
          },
          (e) => {
            // 失败的时候取消对应的预览照片
            if (this.currentInput) {
              this.currentInput.value = ''
            }
            const length = promiseList.length
            this.$emit(`update:onUpload`, false)
            this.previewFiles.splice(this.previewFiles.length - length, length)
            // this.handleError(e).then(() => {})
            console.error(e)
          }
      )
    },
    removeItem(index) {
      this.previewFiles[index].deleted = true
      this.fileList.splice(index, 1)
      this.$emit('input', this.fileList)
      this.previewFiles.splice(index, 1)
    },
    checkSizeLimit(files) {
      let pass = true
      for (let i = 0; i < files.length; i++) {
        if (files[i].size > this.sizeLimit) {
          pass = false
        }
      }
      if (!pass)
        this.$message.error(
            `图片大小不可超过 ${this.sizeLimit / 1024 / 1024} MB`
        )
      return pass
    },
    checkLengthLimit(files) {
      if (this.previewFiles.length + files.length > this.limit) {
        this.$message.warning(`图片最多上传${this.limit}张`)
        this.$emit('exceed', files)
        return false
      } else {
        return true
      }
    },
    getObjectURL(file) {
      let url = null
      if (window.createObjectURL) {
        url = window.createObjectURL(file)
      } else if (window.URL) {
        url = window.URL.createObjectURL(file)
      } else if (window.webkitURL) {
        url = window.webkitURL.createObjectURL(file)
      }
      return url
    },
    clear() {
      this.fileList = []
      this.previewFiles = []
    },
  },
}
</script>

<style lang="scss" scoped>
.image-uploads {
  display: flex;
  flex-wrap: wrap;

  .preview-item {
    position: relative;
    border: 2px dashed var(--border-color);

    &.deleted {
      transition: 1s all;
      transform: translateY(-100%);
      opacity: 0;
    }

    .image-item {
      cursor: pointer;
      // border-radius: 5px;
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .progress {
      position: absolute;
      top: 80px;
      width: 100%;
      height: 6px;
      padding: 0 10px;
    }

    .cover {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      color: var(--text-color2);
      background: rgba(255, 255, 255, 0.5);
      font-size: 12px;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .upload-delete {
      cursor: pointer;
      position: absolute;
      left: 0;
      bottom: 0;
      height: 20px;
      width: 100%;
      display: none;
      justify-content: center;
      align-items: center;
      background: rgba(0, 0, 0, 0.3);
      text-align: center;
      vertical-align: middle;
      line-height: 20px;

    }

    &:hover {
      .upload-delete.show-delete {
        display: flex;
      }
    }
  }

  .add-image-btn {
    cursor: pointer;
    border: 2px dashed var(--border-color);
    position: relative;

    input[type='file'] {
      cursor: pointer;
      display: none;
    }

    .add-image-btn-wrapper {
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100%;
    }
  }
}
</style>
<template>
  <div id="app">
    <editor
      api-key="skusgmkyvt20zw0c6ywi9swko5p3gzo7wzhdaaizwbbor7tx"
      :init="{
        height: 500,
        menubar: false,
        plugins: [
          'advlist autolink lists link image charmap print preview anchor',
          'searchreplace visualblocks code fullscreen',
          'insertdatetime media table paste code help wordcount',
        ],
        toolbar:
          'undo redo | formatselect | bold italic backcolor | \
           alignleft aligncenter alignright alignjustify | \
           bullist numlist outdent indent | removeformat | help',
      }"
      v-model="content"
    />
  </div>
</template>

<script>
import Editor from "@tinymce/tinymce-vue";

export default {
  name: "blog",
  components: {
    editor: Editor,
  },
  data() {
      return {
          content: null
      }
  }
};
</script>
<template>
    <el-tiptap 
        :content="content"
        @onUpdate="onEditorUpdate"
        :placeholder="placeholder"
        :extensions="extensions"
        :height="height"
    />
</template>

<script>
//import 'element-tiptap';
import 'element-tiptap/lib/index.css';
import defaultExtensions from './default-extensions'
import {ElementTiptap } from 'element-tiptap'

export default {
    name: 'TiptapEditor',
    components:{
        'el-tiptap':ElementTiptap,
    },
    props:{
        value:{
            type:String,
            default:''
        },
        extensions:{
            type:Object,
            default(){
                return defaultExtensions.extensions
            }
        },
        height:{
            type:String,
            required:false,
            default:'300'
        },
        placeholder:{
            type:String,
            default:'<p>写一点东西~</p>'
        }
    },
    data() {
        return {
            content:''
        }
    },
    watch:{
        value(newValue, preValue){
            if (newValue !== preValue){
                this.content=newValue
            }
        },
    },
    mounted(){
        this.initEditor()
    },
    methods:{
        initEditor(){
            if (this.value){
                this.content=this.value
            }
        },
        onEditorUpdate(val){//continuous feedback
            this.$emit('input',val)
        }
    }
}
</script>

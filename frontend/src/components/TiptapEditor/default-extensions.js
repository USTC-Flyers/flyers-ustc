import {
    // 需要的 extensions
    Doc,
    Text,
    Paragraph,
    Heading,
    Bold,
    Underline,
    Italic,
    Strike,
    HorizontalRule,
    Indent,
    TextAlign,
    Blockquote,
    //Link,
    Image,
    ListItem,
    BulletList,
    OrderedList,
    //FormatClear,
    History,
  } from 'element-tiptap'

  export default{
    extensions: [
        new Doc(),
        new Text(),
        new Paragraph(),
        new Heading({ level: 5 }),
        new Bold({ bubble: true }), // 在气泡菜单中渲染菜单按钮
        new Underline({ bubble: true}), // 在气泡菜单而不在菜单栏中渲染菜单按钮
        new Italic(),
        new Strike(),
        new HorizontalRule(),
        new Indent(),
        new TextAlign(),
        new Blockquote(),
        new Image(),
        //new Link(),
        new ListItem(),
        new BulletList(),
        new OrderedList(),
        //new FormatClear(),
        new History(),
    ],
  }
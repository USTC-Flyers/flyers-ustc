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
    HardBreak,
    Indent,
    Blockquote,
    Link,
    ListItem,
    BulletList,
    //OrderedList,
    FormatClear
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
        new HardBreak(),
        new Indent(),
        new Blockquote(),
        new Link(),
        new ListItem(),
        new BulletList(),
        //new OrderedList(),
        new FormatClear(),
    ],
  }
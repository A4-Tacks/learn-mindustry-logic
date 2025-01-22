# 开始学习bang语言
在前文中, 我们有提到一种方便的语言, 这可以方便复杂逻辑的编写.

> [!WARNING]
> 这篇教程bang相关的部分还不完善, 可能并不适合入门和写在这里

项目地址: <https://github.com/A4-Tacks/mindustry_logic_bang_lang>\
学习引导: <https://github.com/A4-Tacks/mindustry_logic_bang_lang/blob/main/examples/README.md>

在这里，我们试图呈现一种更好、更简洁的形式来帮助学习这个语言.

首先, 我们从项目地址页面寻找到`Releases`栏目, 找到最新版本,
并根据自己的系统[^1]和架构下载对应的压缩包.

接着我们将压缩包解压到合适的目录以方便执行,
在PATH环境变量中的可以不需要输入路径直接执行, 常见路径如
`~/.local/bin` `/usr/bin` `/bin` `/usr/local/bin` 等, 请确保它有可执行(x)权限

接着我们测试它是否能够正确的执行, 在shell中输入以下代码[^2]:

```
mindustry_logic_bang_lang cl <<< 'print "Hello, World!";'
```

它应输出编译为mdt逻辑的如下代码

```
print "Hello, World!"
```

虽然目前这个例子看着和输入的没什么区别, bang做的尽量贴合逻辑的语法风格,
不过随着需要编写的复杂起来, 它可以成为强大有力的工具.

要想阅读之后的章节, 请先确保你能够使用这个编译器编译代码, 不然将基本无法进行


[^1]: 如果是安卓请下载Linux版本, 架构通常为aarch64.
      使用方法为寻找一个可以执行二进制文件并附带环境的终端模拟器,
      如termux, MT管理器(sdk28)等软件.

[^2]: `<<<`是bash的一种语法, bash是一个常见的shell.

      这个语法直接将给定的字符串作为输入, 如果要从给定路径的文件输入请使用`<`,
      如果要控制输出到的文件请使用`>`.

当前项目中关于 Bang 后面的部分已经移除,
学习 Bang 请移步本章开头的**学习引导**链接处学习

---
[上一章](./24-world-processor.md)
[目录](./README.md)

# 打包颜色
这是一个简单的语句, 有五个参数, 一个是结果需要赋值到的变量,
剩下四个是四个颜色通道, 分别是 R G B A, 三种颜色和不透明度.

它在新版本被加入是为了解决一些颜色传递需要的变量太多的问题的,
把多给颜色通道挤压到单个值里面, 当然这个值的类型有点特殊,
不读游戏源码的话不建议深究.

使用到打包颜色的地方有`draw`的`col`, 还有`control`的`color`, 这些是已经讲过的.
没有讲过的有世处(世界处理器)的一些语句

**注**: 这个语句使用的不是8位颜色, 而是浮点颜色,
也就是说颜色取值范围区间不是 `0 ≤ n ≤ 255`, 而是 `0 ≤ n ≤ 1`.

一个简单的例子, 使用`packcolor`来调色绘制一个红底蓝色方块

```gas
packcolor red 1 0 0 1
packcolor blue 0 0 1 1
draw col red 0 0 0 0 0
draw rect 0 0 176 176 0 0
draw col blue 0 0 0 0 0
draw rect 44 44 88 44 0 0
drawflush display1
```


打包颜色字面量
---
可以直接使用字面量来创建打包颜色, 就像创建一个数字值一样

例如:

```gas
set color %ff00ff
draw clear 0 0 0 0 0 0
draw col color 0 0 0 0 0
draw rect 30 30 20 20 0 0
drawflush display1
```

你可以使用如 `%ff00ff` 的 16 进制 RGB 颜色代码,
或者 `%ff00ffff` 的 16 进制 RGBA 颜色代码 来创建颜色

在高版本(约为148)中, 你还可以使用预设颜色语法, 如 `%[red]` 来创建颜色


拆解打包颜色
---
`packcolor` 的本质是利用给定颜色, 强行创造一个特殊的数字来表示颜色,
这给了我们可趁之机, 例如:

```gas
set color1  %1c2b3d4e
set color2 0x1c2b3d4e
op idiv depack color1 %00000001 # 运算以解包颜色

print "{0}\n{1}"
format color2
format depack # 472595790  0x1c2b3d4e
printflush message1
```

可以看到, 我们之间将其解开成了 RGBA 格式,
如果需要解开成 RGB 格式可以将除数改为 `%00000100`

如果需要获取确切的 RGB 值, 可以利用位运算来完成:

```gas
set color1  %1c2b3d4e
set color2 0x1c2b3d4e
op idiv depack color1 %00000100 # 解包为 RGB

op shr r depack 16
op shr t depack 8
op and g t 255
op and b depack 255

print "{0}\n{1},{2},{3}"
format color2
format r # 28  0x1c
format g # 43  0x2b
format b # 61  0x3d
printflush message1
```

> [!TIP]
> 在高版本 (150) 中, 添加了一个新语句可以快速完成此操作,
> 例如如下例子一次性将颜色中 RGBA 解出并赋值给变量 r g b a
>
> `unpackcolor r g b a color`
>
> **注意**: r g b a 的值并不是 `[0,255]` 而是 `[0,1]`


---
[上一章](./13-lookup.md)
[目录](./README.md)
[下一章](./15-radar.md)

# 打印与绘制

打印
---
还记得上文中, 我们使用的`print`(打印)语句吗?

这个语句接受一个参数, 会将参数值附加到预打印区, 一般值的结果就是变量表中看到的那样

`printflush`也接受一个参数, 它的作用是将预打印区全部内容一次性输出到某个信息板建筑中.
(有字数上限)


绘制
---
`draw`语句, 它有一个特殊参数, 和六个普通参数

特殊参数接受的是绘制方法, 普通参数是绘制的数据

绘制的方法都有以下几种

| 描述              | 值        | 参数                       |
| ---               | ---       | ---                        |
| 清屏为某个颜色    | clear     | r, g, b                    |
| 设置颜色          | color     | r, g, b, 不透明度          |
| 用打包颜色设置    | col       | 颜色                       |
| 设置粗细          | stroke    | 粗细                       |
| 绘制线            | line      | x1, y1, x2, y2             |
| 绘制矩形          | rect      | x, y, 宽度, 高度           |
| 绘制中空矩形      | lineRect  | x, y, 宽度, 高度           |
| 绘制圆            | poly      | x, y, 边数, 半径, 角度     |
| 绘制中空圆        | linePoly  | x, y, 边数, 半径, 角度     |
| 绘制三角形        | triangle  | x1, y1, x2, y2, x3, y3     |
| 绘制图像          | image     | x, y, 图像[^1], 大小, 角度 |

没用到的参数位置以0填充, 当然你也可以写点其它的或者不写

`draw`就像`print`那样, 会把操作堆积在逻辑的预绘制缓冲区中,
直到使用`drawflush`才会输出到建筑

一个使用例子, 如下

```gas
draw clear 0xFF 0xAD 0xAD 0 0 0    # 清空背景
draw color 0x80 0xED 0x99 0xFF 0 0 # 设置绘制颜色
draw rect 20 20 40 20 0 0
drawflush display1
```

将逻辑连接一下小显示屏, 上述代码会以粉色的背景绘制出一个绿色的长方形

注: 小显示屏的可绘制范围是80x80, 大显示屏的可绘制范围是176x176


格式化
---
这是在146版本之后添加的语句, 写为`format`, 有一个普通参数

将预打印区中`{0}` `{1}` ... `{9}`中数字最小的**首个**内容替换成指定参数

```gas
printflush message1 # 先清空内容

print     "{3}-{1}-{3}-{1}"
format 8 # {3}-8-{3}-{1}
format 9 # {3}-8-{3}-9
format 2 # 2-8-{3}-9
printflush message1

stop # 自此停止执行
```

可以挪动`printflush`的位置, 来观察替换结果是否符合上述描述

> [!WARNING]
> 这个 format 和别的常用语言中设计的 format 不太一样,
> 别的语言通常是替换所有, 而这个则是只会替换首个
>
> 例如 `format("{0}-{0}", 2)` 可能希望它是 `"2-2"`,
> 但是逻辑中 `print "{0}-{0}"; format 2` 实际上是 `2-{0}`


[^1]: 这里一般是填写的content类型的值, 它们一般都附带一个图标可以被绘制出来


---
[上一章](./06-env-vars.md)
[目录](./README.md)
[下一章](./08-getlink.md)

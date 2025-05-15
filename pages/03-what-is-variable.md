# 什么是变量
变量, 是逻辑中不可或缺的一个东西.
它的意义是, 在某个时间和位置, 储存一个值.

会通过一些示例来描述类型方便理解, 但是用到了后面学的一些东西, 也可以先翻翻

> [!TIP]
> 逻辑是支持注释的, 使用一个井号`#`来表示, 在其之后直到一行末尾的内容都会被忽略,
> 可以用来描述代码的作用, 来方便阅读
>
> 逻辑也支持缩进, 也就是行开头的空格或者制表符, 也会被忽略,
> 可以用来将代码分成嵌套的块, 来让其更具有层次感, 使其更好阅读
>
> 逻辑也支持空行, 可以把相关度较低的部分用空行分隔开, 可以让代码更好阅读

# 值
在逻辑中, 变量值有以下几种类型

(数值) number
---
普通的数字类型, 如字面量中的数字, 其类型就是这个

```gas
set a 1
set b 2.5
set c -5
print a; print ","; print b; print ","; print c
```

(空值) null
---
表示什么都没有的一种类型, 发生无效数学运算比如除以0后,
或者一个还没有赋值[^1]的变量, 其值都会是空值

```gas
# a 未赋值, 所以是null值
op div b 3 0
print a; print ","; print b
```

(字符串) string
---
表示一段文本, 比如字面量中的字符串, 其类型就是这个

```gas
set str "Hello, World"
print str
```

(内容) content
---
表示某个游戏内容, 例如某种建筑, 某种单位等,
通常在 "核心数据库" 中看到的大多数内容都能用 content 来指代

> 建议直接使用 "content" 来说明,
> 而不是 "内容"、"类型"、"种类" 等用词, 以防引起误解

```gas
set a @sorter # 路由器的 content
getlink building 0
sensor c building @type
print a; print ","; print c
```

> [!TIP]
> 可以使用 `sensor result input @type` 获取 building 和 unit 的 content

(建筑) building
---
表示某个特定的建筑, 而不是某类建筑 (content)

注意, 这和 content 不同, content 可以描述某类建筑, 例如路由器 (`@sorter`),
而 building 描述了某个建造出来的建筑, 比如链接到的 sorter1

```gas
getlink a 0
print a # 可能输出和 content 的结果很像, 变量表能看到类型
```

(队伍) team
---
这个值表示某个队伍, 一般出现的很少不用去理会

```gas
set a @crux # 表示红队, 通常是敌方
print a
```

通常用于世界处理器[^2], 较少的用于 sensor 语句的 `@team` 属性用于辨别队伍

(单位) unit
---
这个值表示某个特定的单位, 而非某类单位 (content)

```gas
# 注: @unit 是一个环境变量, 代表目前绑定的单位, 类型是 unit
ubind @flare # 绑定一个场上的新星
sensor x @unit @x # 获取其x坐标
sensor y @unit @y # 获取其y坐标
print @unit; print ": "; print x; print ","; print y
```

(枚举) enum
---
这个值很普通, 一般是在某些特殊的地方代表某一个具体的意义, 不用去深究

```gas
# 注: 环境变量是自带的变量, 后面会讲
set x @type # 比如 sensor 的选项就是一个环境变量, 类型是 enum
print x
```

(未知) unknown
---
一般除非修改游戏源码, 或者使用mod什么的方式创建特殊的东西, 否则几乎不会遇到

---

好了, 值的概念已经明白了, 接下来我们将在下一章了解变量的常见操作


[^1]: 通过一些方法, 在某刻使变量的值改变为另一个值
[^2]: [24-世界处理器](./24-world-processor.md)

---
[上一章](./02-learn-literal.md)
[目录](./README.md)
[下一章](./04-change-variable.md)

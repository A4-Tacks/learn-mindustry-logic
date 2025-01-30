# 根据编号获取类型
我们知道, 物品、液体、方块和单位, 都有一个`content`类型的变量来表示它们的类型

比如我们可以通过环境变量`@copper`得到一个类型为`content`的值, 来表示物品铜的类型.

但是, 有时我们需要依次获取所有的`content`值, 批量进行一些处理,
此时, `lookup`语句就派上用场了.

`lookup` 有一个字面参数, 两个普通参数, 其字面参数的取值有以下四种:

1. block (方块 / 建筑)
2. unit (单位)
3. item (物品)
4. liquid (液体)

接下来的两个参数分别是最终要赋值到的变量, 和需要取的编号

编号从0开始, 你可以通过一个固定的编号取得某个大类中任意一个`content`值

至于最终取到多大合适, `lookup` 有四个环境变量, 如`@itemCount`表示总编号数,
当然你也可以判定是否取到了null来决定是否完成

以下是一个不断设置分类器的小逻辑, 用于演示

```gas
set i 0
loop:
    lookup item my_item i
    control config sorter1 my_item 0 0 0
    op add i i 1
    wait 0.1 # 因为逻辑执行太快了, 所以等一会
jump loop lessThan i @itemCount
```

**注**: 在以前的版本, 想通过content获取到lookup使用的id, 需要lookup所有物品去依次比较,
不过在146版本, sensor可以使用`@id`属性, 不需要费劲了

一些简单的用途, 例如因为内存元只能传递数字,
所以想在多逻辑之间沟通使用某个物品时, 就可以利用`@id`和lookup进行协调.

---
[上一章](./12-other-control-flow.md)
[目录](./README.md)
[下一章](./14-pack-color.md)

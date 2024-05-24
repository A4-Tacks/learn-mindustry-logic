# 单位绑定
这章将开启单位篇章, 这是一个比较大的篇章, 我们将从单位绑定开始

语句UnitBind, 其格式是`ubind`, 有一个普通参数,
传入需要绑定的单位类型content, 或者某个特定的单位, 也就是unit类型.

当你执行了`ubind`后, 如果场上有这类能绑定的友方单位的话,
那么环境变量`@unit`将会被设置为这个单位的值,
你可以对这个值进行sensor等操作获取所需信息.

绑定后会持续一段时间, 超出这个时间后, `@unit`变量将会重新清空到null

当然, 你把这个环境变量的值赋值给另一个变量也是有意义的,
因为`ubind`还有一种扩展用法, 那就是直接绑定某个单位的值表示的那个单位.

至于为什么不直接对着存储了的值进行sensor什么的操作, 当然可以,
但是后文中所需的其它单位控制系列语句都是直接针对`@unit`操作的, 所以需要这么做.

关于这个绑定的顺序, 一般是不好追溯的, 我们只需要关注没有单位数量变化时,
绑定的顺序不变且总是会刚好每个单位绑定一次, 直到绑定次数超出单位总数再从头开始.
不过就目前版本来说它在没有单位减少的情况下大致为单位生成顺序.

一个特性, 但不确定是否稳定: 在直接绑定到unit值时,
不会干扰上一次使用content绑定下一个单位的顺序

选读: 如果有单位减少将会使用置换删除, 将表中最后的单位交换到删除的单位空位中,
研究源码的话可以看看.

以下是一个示例程序, 它会实时打印某个玩家单位的坐标

```
# find player unit
set id 0
loop:
    lookup unit unit_ty id
restart:
    ubind unit_ty
    jump skip strictEqual @unit null
    set first @unit
    jump do_bind_loop_cond always 0 0
    # 这里会将该种单位全部绑定一遍, 直到找到玩家控制的那个
do_bind_loop:
    sensor is_dead first @dead
    jump restart notEqual is_dead false # 头单位已经死亡, 我们永远无法到达, 所以我们需要重新开始
do_bind_loop_cond:
    sensor ctrl_type @unit @controlled
    jump finded equal ctrl_type @ctrlPlayer # 绑定到的是玩家
    ubind unit_ty
    jump do_bind_loop notEqual @unit first
skip:
    op add id id 1
jump loop lessThan id @unitCount
end
finded:
set player @unit
follow_loop:
    sensor x player @x
    sensor y player @y
    sensor name player @name # 如果有, 则可以显示玩家名
    # 取两位小数省的小数部分太长
    op idiv x x 0.01 # 通过整除省去乘再向下取整运算
    op idiv y y 0.01
    op div x x 100
    op div y y 100
    print "player "
    print name
    print "[]: "
    print unit_ty
    print " -> "
    print x
    print ", "
    print y
    printflush message1
sensor ctrl_type player @controlled
jump follow_loop equal ctrl_type @ctrlPlayer # 仅在玩家控制期间进行执行, 玩家解除控制重新寻找
printflush message1 # clear message
```


---
[上一章](./15-radar.md)
[目录](./README.md)
[下一章](./17-unit-control.md)

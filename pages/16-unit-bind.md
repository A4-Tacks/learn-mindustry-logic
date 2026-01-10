# 单位绑定
这章将开启单位篇章, 这是一个比较大的篇章, 我们将从单位绑定开始

语句UnitBind, 写做`ubind`, 有一个普通参数, 传入需要绑定的单位content, 或者某个特定的unit

执行`ubind`后, 如果场上有符合的友方单位的话, 那么环境变量`@unit`将会被设置为这个单位(unit)

你可以对这个变量进行sensor等操作获取所需信息

简而言之, `ubind` 的作用就是找到一个单位并将该单位赋值给只读的环境变量 `@unit`

以下是一个示例程序, 它会实时打印某个玩家单位的坐标

```gas
# find player unit
set id 0
loop:
    lookup unit unit_ty id
restart:
    ubind unit_ty
    jump skip strictEqual @unit null
    set first @unit
    jump do_bind_loop_cond always 0 0
    # 这里会将该种单位依次绑定一遍, 直到找到玩家控制的那个
do_bind_loop:
    sensor is_dead first @dead
    jump restart notEqual is_dead false # 头单位已经死亡, 我们永远无法到达, 所以我们需要重新开始
do_bind_loop_cond:
    sensor ctrl_type @unit @controlled
    jump finded equal ctrl_type @ctrlPlayer # 绑定到的是玩家
    ubind unit_ty
    jump do_bind_loop notEqual @unit first
skip:
    # 该种单位全部绑定了一遍, 未找到玩家单位, 尝试下一种单位
    op add id id 1
jump loop lessThan id @unitCount
end

finded:
set player @unit
follow_loop:
    sensor x player @x; sensor y player @y
    sensor name player @name # 如果有, 则可以显示玩家名
    # 取两位小数避免小数部分过长
    op idiv x x 0.01; op idiv y y 0.01 # 通过整除省去乘再向下取整运算
    op div  x x 100;  op div  y y 100
    print "player "; print name; print "[]: "
    print unit_ty; print " -> "
    print x; print ", "; print y
    printflush message1
sensor ctrl_type player @controlled
jump follow_loop equal ctrl_type @ctrlPlayer # 仅在玩家控制期间进行执行, 玩家解除控制重新寻找
printflush message1 # clear message
```


单位绑定的扩展用法 (绑定具体单位)
-------------------------------------------------------------------------------
`ubind` 可以直接输入一个 **unit** , 而不是一个 **content**

当输入一个 unit 时, `ubind foo` 效果类似 `set @unit foo`, 就像给 `@unit` '赋值' 似的

可以用于一些巧妙的用途:

- 快速绑定曾经绑定过的单位
- 绑定来自雷达 (radar) 获取的友方单位
- 世处绑定来自 fetch 等语句获取的单位

> [!NOTE]
> 非特权处理器 (世界处理器) 使用此用法依旧不能绑定和控制其它队伍单位


单位绑定的顺序
-------------------------------------------------------------------------------
当使用content绑定单位时, 顺序较为随机

通常只需要关注, 通常在单位数量不变时,
绑定的顺序不变且总是会刚好每个单位绑定一次, 直到没有下一个单位时再从头开始

> [!TIP]
> 一个不确定是否稳定工作的特性:
> 在直接绑定一个unit而非content时, 不会影响绑定content时将要绑定的下一个单位

> [!TIP]
> 如果有单位减少将会使用置换删除, 将表中最后的单位交换到删除的单位空位中,
> 研究源码的话可以看看, 可能一些极端环境可以利用该顺序


简单的单位绑定例子
-------------------------------------------------------------------------------

**计数某种单位数量**:

```gas
restart:
    set count 0
    ubind @flare # 绑定星辉, 想计数其它单位可改成其它单位或使用 lookup
    jump finish equal @unit null
    set head @unit

loop:
    sensor dead head @dead
    jump restart notEqual dead false # 如果首个单位死亡, 则永远绑定不到, 重新计数

    op add count count 1
    ubind @flare
    jump loop notEqual @unit head


finish:
    print count; print " "; print @unit
    printflush message1
```

---
[上一章](./15-radar.md)
[目录](./README.md)
[下一章](./17-unit-control.md)

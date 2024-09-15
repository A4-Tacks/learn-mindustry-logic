# 世界处理器
还记得第一章提到的世界处理器吗? 它是一种特殊的处理器,
正常情况应只被地图编辑器或者特殊的mod才可以放置.

世界处理器相比普通的处理器拥有一些额外的语句, 可以操作的东西更多.

比如可以凭空更改某处的建筑、地板、启用等, 甚至可以在一定范围内更改自身的运行速度.

这章并不讲解太多其特有语句详细的用法, 只是介绍一下.

相信学习了前面的基础语句用法, 快速熟悉部分世界处理器的语句并不成问题.

关于世界处理器语句的介绍也有其它的教程、思维导图、解释等,
并且不要忘记逻辑编辑器有长按解释功能.

Fetch
---
这个语句用于获取场上的建筑、单位等
```
# @sharded处填写的是针对哪个队伍, @sharded是默认玩家队伍
# @sharded是环境变量, 其类型是team, 当然你用整数代表队伍也是可以的
fetch unit          result      @sharded i 0            # 获取场上第i个单位
fetch player        result      @sharded i 0            # 获取场上第i个玩家单位
fetch core          result      @sharded i 0            # 获取场上第i个核心
fetch build         result      @sharded i @conveyor    # 获取场上第i个传送带
fetch unitCount     result      @sharded 0 0            # 获取场上的单位总数
fetch playerCount   result      @sharded 0 0            # 获取场上的玩家单位总数
fetch coreCount     result      @sharded 0 0            # 获取场上的核心总数
fetch buildCount    result      @sharded 0 0            # 获取场上的建筑总数
```

你可以简单的通过上述示例用法写一个简单的遍历己方单位的逻辑

```
set i 0
# 我们应假定建筑不少于一个
fetch unitCount unitCount @sharded 0 0
loop:
    fetch unit unit @sharded i 0

    sensor x unit @x
    sensor y unit @y

    # 去整, 使输出更短
    op floor x x 0
    op floor y y 0

    print unit; print ": "; print x; print ","; print y; print "\n"

    op add i i 1
jump loop lessThan i unitCount
printflush message1
# 虽然单位多了信息板会打印不下, 毕竟有输出上限
```

---
[上一章](./23-advanced-control-flow-function.md)
[目录](./README.md)
[下一章](./25-start-bang-lang.md)

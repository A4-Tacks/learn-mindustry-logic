# 世界处理器
还记得第一章提到的世界处理器吗? 它是一种特殊的处理器,
正常情况应只被地图编辑器或者特殊的mod才可以放置与编辑.

世界处理器相比普通的处理器拥有一些额外的语句, 可以操作的东西更多.

比如可以凭空更改某处的建筑、地板、启用等, 甚至可以在一定范围内更改自身的运行速度.

这章并不讲解太多其特有语句详细的用法, 只是介绍一下.

相信学习了前面的基础语句用法, 快速熟悉部分世界处理器的语句并不成问题.

关于世界处理器语句的介绍也有其它的教程、思维导图、解释等,
并且不要忘记逻辑编辑器有长按解释功能, 同时可以在[附录-术语表](./appendix-04-glossary.md)中找到简介.


世处特权
-------------------------------------------------------------------------------
世处除了可以使用一些额外的特权语句外, 一些普通语句在特权下也变得更强

| 语句            | 描述                                                                  |
| ---             | ---                                                                   |
| ubind           | 绑定具体单位时可以不同队伍                                            |
| ucontrol        | 控制单位时可以不同队伍                                                |
| ucontrol build  | 可以无视规则是否允许逻辑单位建造                                      |
| control         | 控制建筑时无需在链接范围内, 也无需同队伍, 可控制特权建筑              |
| radar           | 在建筑上开启雷达无需同队伍, 可在特权建筑上开启雷达                    |
| drawflush       | 绘制建筑无需同队伍                                                    |
| printflush      | 输出建筑无需同队伍, 可以向特权建筑输出 (如世界信息板)                 |
| read            | 读取内存、画板、逻辑块变量无需同队伍, 可读取特权建筑如世处            |
| write           | 写入内存、画板、逻辑块变量无需同队伍, 可写入特权建筑如世处            |


Fetch
-------------------------------------------------------------------------------
这个语句用于获取场上的建筑、单位等
```gas
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

```gas
set i 0
# 我们应假定单位不少于一个
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

Flush Message (message)
-------------------------------------------------------------------------------
类似 printflush, 清空文本缓冲区并将其内容输出到玩家屏幕界面

| `message` | 直接向玩家屏幕上显示信息                       |
| ---       | ---                                            |
| 显示方式  | 消息将如何显示, 参考下表                       |
| 显示时间  | 消息持续显示的时间, 按秒计                     |
| 是否成功  | 如果成功显示, 赋值为 1, 否则为 0, 特殊情况如下 |

> [!TIP]
> 一种比较简单的做法是利用旧版兼容的一种模式, 将 '是否成功' 参数设置为 `@wait`,
> 这个环境变量的值并不重要, 你填入这个参数后如果显示失败将会类似 `wait` 语句那样原地等待直到成功显示

| 显示方式 | 描述                                           |
| ---      | ---                                            |
| notify   | 在屏幕顶部作为提醒消息弹出                     |
| announce | 显示在屏幕中心                                 |
| toast    | 显示在屏幕顶部                                 |
| mission  | 显示在波次计时器, 如果输出空信息则重置为正常   |

> [!NOTE]
> 当显示失败时, 也就是 '是否成功' 为 0 的情况, 它并不会清空文本缓冲区,
> 也就是当显示失败时无需重新 print 内容

以下为一个示例, 将会持续向屏幕中心输出持续一秒的 `测试文本`:

```gas
print "测试文本"
message announce 1 @wait
```

> [!TIP]
> 该显示支持了一点本地化, 但不多, 在文本开头为 `@` 时会尝试使用 bundle 文件中的翻译进行替换,
>
> 例如 `print "@liquid.slag.name"; message announce 1 @wait` 将显示 `矿渣`


---
[上一章](./23-advanced-control-flow-function.md)
[目录](./README.md)
[下一章](./25-compilers.md)

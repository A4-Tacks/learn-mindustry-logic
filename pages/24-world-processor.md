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


Set Prop (setprop)
-------------------------------------------------------------------------------
设置属性, 用于设置建筑、单位的属性, 包括物品、液体数量, 和部分可被 sensor 的属性

| 属性            | 描述                              |
| ---             | ---                               |
| x               | 当前 x 坐标                       |
| y               | 当前 y 坐标                       |
| velocityX       | 当前 x 方向的运动速度             |
| velocityY       | 当前 y 方向的运动速度             |
| rotation        | 朝向                              |
| speed           | 移动速度属性 (上限)               |
| armor           | 护甲                              |
| health          | 血量 (生命值)                     |
| shield          | 护盾                              |
| team            | 队伍                              |
| flag            | 单位标签 (类似 ucontrol flag)     |
| totalPower      | 全电量, 参考 sensor 附录          |
| payloadType     | 载荷类型                          |

例如以下逻辑让世处自己自毁

```gas
setprop @health @this 0
```


Set Rule (setrule)
-------------------------------------------------------------------------------
设置某个地图或队伍规则, 例如波次时间、建造速度等

| 规则                  | 参数          | 描述                                |
| ---                   | ---           | ---                                 |
| currentWaveTime       | 数值          | 当前波次倒计时 (tick)               |
| waveTimer             | 数值          | 波次定时器是否启用                  |
| waves                 | 数值          | 总波次数                            |
| wave                  | 数值          | 当前波次                            |
| waveSpacing           | 数值          | 波次间隔时间                        |
| waveSending           | 数值          | 是否允许用波次按钮手动生成波次      |
| attackMode            | 数值          | 游戏模式是否为攻击模式              |
| enemyCoreBuildRadius  | 数值          | 敌人核心禁止建造区半径              |
| dropZoneRadius        | 数值          | 敌人出生点爆破半径                  |
| unitCap               | 数值          | 基本单位上限 (可用核心等方式增加)   |
| mapArea               | x, y, 宽, 高  | 地图可见范围 (范围外无法前往与交互) |
| lighting              | 数值          | 是否需求照明 (需要点亮地图)         |
| canGameOver           | 数值          | 能否游戏结束 (毁灭所有核心后)       |
| ambientLight          | 数值          | 环境光颜色                          |
| solarMultiplier       | 数值          | 太阳能板发电倍率                    |
| dragMultiplier        | 数值          | 环境阻力倍率                        |
| ban                   | 方块/单位     | 不允许使用某些建筑或单位            |
| unban                 | 方块/单位     | 解除 ban                            |
| buildSpeed            | 队伍, 值      | 建造速度倍率                        |
| unitHealth            | 队伍, 值      | 单位血量倍率                        |
| unitBuildSpeed        | 队伍, 值      | 单位生产速度倍率                    |
| unitMineSpeed         | 队伍, 值      | 单位采矿速度倍率                    |
| unitCost              | 队伍, 值      | 单位成本                            |
| unitDamage            | 队伍, 值      | 单位攻击伤害倍率                    |
| blockHealth           | 队伍, 值      | 建筑血量倍率                        |
| blockDamage           | 队伍, 值      | 建筑伤害倍率                        |
| rtsMinWeight          | 队伍, 值      | RTS 的 “谨慎” 最低值                |
| rtsMinSquad           | 队伍, 值      | RTS 小队最小规模                    |


例如设置为需求照明

```gas
setrule lighting 1 0 0 0 0
```


Apply Status (status)
-------------------------------------------------------------------------------
给单位添加状态效果, `status false` 为添加效果, `status true` 为移除效果

例如添加十秒潮湿并移除 boss 效果

```gas
status false wet unit 10
status true boss unit 0
```


---
[上一章](./23-advanced-control-flow-function.md)
[目录](./README.md)
[下一章](./25-compilers.md)

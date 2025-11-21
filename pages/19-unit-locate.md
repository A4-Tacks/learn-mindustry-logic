# 单位定位
这个语句可以借助单位定位一些静止的东西, 并且被定位的通常是距离单位'较近的'

可以搜索的目标都有

- 敌我的某类建筑, 如核心
- 某类矿物
- 受损建筑
- 敌方出生点

语句为`ulocate`, 有两个字面参数,
一个是定位模式, 一个是定位建筑类型(在搜索建筑时使用)

### 定位模式

| 字面参数 | 类型             |
| ---      | ---              |
| building | 定位建筑         |
| ore      | 定位矿物         |
| spawn    | 定位敌方出生点   |
| damaged  | 定位己方受损建筑 |

### 建筑类型

| 字面参数  | 类型     |
| ---       | ---      |
| core      | 核心     |
| storage   | 仓库     |
| generator | 发电机   |
| turret    | 炮塔     |
| factory   | 工厂     |
| repair    | 修复器   |
| rally     | 指挥中心 |
| battery   | 电池     |
| reactor   | 反应堆   |

用法: `ulocate`, 定位模式, 建筑类型, 是否搜索敌方, 要搜索的矿物, 目标点x, 目标点y, 目标是否找到, 找到的建筑

> [!NOTE]
> 类似另外两个单位控制语句, 这个语句也会发出控制信号并标记已控制

> [!NOTE]
> 游戏内逻辑编辑器创建的 ulocate 语句, '是否搜索敌方' 默认是 `true`,
> 如果你需要搜索己方目标, 例如己方核心需要将其改为 `false` 或 `0` 等


小干扰的利用单位获取核心
-------------------------------------------------------------------------------

对于一些并不是单位控制类的逻辑, 如果反复绑定使用 ulocate 会造成大量控制干扰其它逻辑和单位默认行为

所以需要以下逻辑, 绑定任意未被控制的单位, 才对其使用 ulocate, 且核心没有死亡不重复获取

```gas
sensor coredead core @dead
jump found equal coredead false

lookup:
    lookup unit unit i
    op add i i 1; op mod i i @unitCount
    ubind unit
    jump lookup equal unit null

    sensor ctrl @unit @controlled
    jump lookup notEqual ctrl 0

ulocate building core false 0 corex corey 0 core
ucontrol unbind 0 0 0 0 0

found:
    print core; print "  "
    print corex; print ","; print corey
    printflush message1
```

---
[上一章](./18-unit-radar.md)
[目录](./README.md)
[下一章](./20-advanced-control-flow-basic.md)

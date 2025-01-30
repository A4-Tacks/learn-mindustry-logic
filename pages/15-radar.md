# 雷达
这是一个特殊的语句, 当你需要侦测敌方单位,
或者方便的关于某个建筑的己方单位时, 可以使用雷达语句.

雷达语句可以以一个建筑为中心, 以一定的范围[^1]去搜寻单位,
并且可以指定多个筛选条件, 和排序依据, 并找到依据排序依据最符合的那个单位.

搜索的单位只有满足所有的筛选条件才会被搜索.

雷达语句参数很多

radar, 筛选器A, 筛选器B, 筛选器C, 排序依据, 充当雷达的建筑, 是否正序排序, 返回目标赋值到的变量

可用的筛选器都有以下几种:

| 字面参数 | 解释         |
| ---      | ---          |
| any      | 任意         |
| enemy    | 敌方         |
| ally     | 友方         |
| player   | 玩家         |
| attacker | 有攻击能力的 |
| flying   | 飞行的       |
| boss     | BOSS         |
| ground   | 地面的       |

可选的排序依据有以下几种

| 字面参数  | 解释     |
| ---       | ---      |
| distance  | 距离     |
| health    | 血量     |
| shield    | 盾量     |
| armor     | 护甲     |
| maxHealth | 血量上限 |


以下是一个简单的小例子, 让链接的炮塔攻击距离最近的友方玩家控制的单位

```gas
getlink turret i
radar ally player any distance turret 1 unit
op notEqual shooted unit null
control shootp turret unit shooted 0 0
op add i i 1
op mod i i @links
```


[^1]: 这个范围一般点击建筑显示有个圈的话, 大致就是这个圈, 比如炮塔射程 超速器范围,
      或者单位射程, 没有的话一般这个范围应该很小.

---
[上一章](./14-pack-color.md)
[目录](./README.md)
[下一章](./16-unit-bind.md)

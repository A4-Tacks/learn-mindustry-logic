# 控制
在上文, 我们已经学习了`sensor`(传感器)来从游戏中获取足够的信息.
在这章, 我们可以借助这些信息来操作链接的建筑, 从而帮助我们完成一些事.

`control`语句, 拥有一个字面参数[^1], 和五个普通参数.

用法如下表

| 模式      | 参数           | 解释                 |
| ---       | ---            | ---                  |
| enabled   | 建筑, 是否启用 | 禁用或启用某个建筑   |
| shoot     | x, y, 是否射击 | 控制炮台向某个点射击 |
| shootp    | 目标, 是否射击 | 控制炮台向某个目标比如单位或建筑射击, 可以省去手动获取坐标和计算提前量 |
| 设置      | 目标, 设置     | 设置某个建筑的额外配置, 比较多的是分类器选中的物品 |
| 颜色      | 目标, 颜色[^2] | 设置灯箱的颜色       |

以下是一段代码示例, 可以在链接的钍反应堆冷冻液少于指定值时将其禁用,
从而避免直接爆炸

```
getlink block i # i default value by null, to integer by zero
sensor liquid block @cryofluid # 通过冷冻液的content获取反应堆冷冻液量
op greaterThan enabled liquid 20 # 判定开启标志为冷冻液量大于20
control enabled block enabled 0 0 0
op add i i 1
op mod i i @links # i自身对链接总数取余, 这样i在到达链接总数时将回绕至0
```


[^1]: 字面参数, 比如之前见过的`op`语句中的`add`,
      它并不会像普通参数那样被求值, 而是直接取输入的原始形式,
      这一般是用来控制语句的行为.

[^2]: 在老版本, 这里直接输入rgb参数的, 但是在新版本有了颜色打包,
      就只输入一个打包后颜色了

---
[上一章](./09-sensor.md)
[目录](./README.md)
[下一章](./11-read-and-write-of-memory.md)
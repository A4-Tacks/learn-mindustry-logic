# 单位控制
在上一章, 我们学习了单位绑定, 这章我们学习单位控制(UnitControl)语句,
写作`ucontrol`. 它有一个字面参数, 五个普通参数.

本章只说要点, 语句具体用法过多, 建议直接进入游戏内逻辑编辑器查看说明,
一般是长按选项, 或将鼠标悬停至选项上方.

查看说明配合参数旁的文字, 以及靠经验还有字面参数的命名, 应该可以直接了解大致用法.

首先, 单位语句(米黄色语句)中, 除了`ubind`, 其它的语句都属于**控制**语句.
此类语句会控制当前绑定的单位, 也就是`@unit`, 同一时间只能绑定一个单位.

这些控制语句一旦运行, 会给当前绑定单位发出一道控制命令, 控制命令一旦发出,
该单位将被标记为被当前逻辑控制, 直到控制结束或者被其它逻辑控制.

> [!NOTE]
> 发出的控制命令只会对绑定的单位发送, 和控制标记无关, 且只能同时绑定一个单位.
>
> 单位只能同时被一个逻辑所控制, 点击单位可以显示控制单位的逻辑

一般单位响应控制命令行为的持续时间都是控制标记的有效期内有效.

以下是一个简单示例代码,
它会将所有的星辉(flare)控制聚集到逻辑连接的一个电弧(arc)炮台射击点.

```gas
sensor shooting arc1 @shooting
jump skip equal shooting false # 没有开火时忽略选点
    sensor x arc1 @shootX
    sensor y arc1 @shootY
skip:

ubind @flare
ucontrol move x y 0 0 0
```


避免不必要的控制
---
对于within来判定是否接近某点时, 记得如果你不需要控制状态,
就不要使用这个, 因为是控制语句, 会造成控制状态.

如果不需要控制状态, 请手动应用公式计算距离: `len(x1-x0, y1-y0)`

以下是一段代码, 模拟了 `ucontrol within tx ty 10 within 0`

```gas
sensor ux @unit @x
sensor uy @unit @y
op sub dx ux tx
op sub dy uy ty
op len len dx dy
op lessThan within len 10
```


建造复杂建筑
---
对于build建造的建筑需要额外信息, 如带桥连接点或者逻辑内容等, 可以借助config参数,
它输入一个building类型值, 可以把另一个建筑的config复制过来

以下是一段代码, x坐标为奇数时, 会将自身复制一份在右边.
事先链接好四周建筑的位置, 这样新逻辑一被放下就会链接从而终止建筑条件

```gas
jump 0 notEqual @links 0
op mod c @thisx 2
jump 0 equal c 0
op add tx @thisx 1
sensor type @this @type
sensor r @this @rotation
ubind @poly
ucontrol build tx @thisy type r @this
```

注: `@this`变量表示逻辑自身的building环境变量,
而`@thisx`是逻辑自身位置的x坐标环境变量


单位控制语句中的命名问题
---
> [!WARNING]
> 对于`ucontrol unbind`, 命名并不合理,
> 其作用是解除控制(control)而不是绑定(bind),
> 所以或许应该叫做`ucontrol decontrol`


---
[上一章](./16-unit-bind.md)
[目录](./README.md)
[下一章](./18-unit-radar.md)

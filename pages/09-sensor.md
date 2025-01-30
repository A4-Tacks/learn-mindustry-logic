# 传感器
在前文, 我们学到了一些必要基础的操作, 接下来我们将开始学习如何从游戏中获取信息.

`sensor`语句, 这是获取信息的第一渠道.

在游戏中, 无论是建筑还是单位, 都有着各种属性, 比如大小、朝向、承装的物品等.
而想要获取这些, 通通都需要使用`sensor`来进行.

`sensor`的参数有三个, 分别是返回值、建筑和属性.
当然在游戏中编辑器参数顺序有些不同, 在游戏中的顺序是返回值、属性和建筑.

`sensor`所使用的属性参数, 是直接从环境变量中获取的,
不需要关系它们实际表示了什么值, 只需要知道它可以告知`sensor`取什么属性即可.

以下是一个代码示例, 可以打印出每个链接的建筑坐标

```gas
set i 0
loop:
    getlink block i
    sensor x block @x
    sensor y block @y
    print "id: "
    print i
    print ", x: "
    print x
    print ", y: "
    print y
    print "\n"
    op add i i 1
jump loop lessThan i @links
printflush message1 # 仅在遍历完成后一起输出
```

注: 上文中使用到的名词 `遍历` 大致表示对某一些东西全部操作一遍

全部的属性参考这里[附录02-传感器选项](./appendix-02-sensor-options.md)

---
[上一章](./08-getlink.md)
[目录](./README.md)
[下一章](./10-control.md)

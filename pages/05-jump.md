# 跳转
跳转语句(jump), 可以在条件满足时, 跳转到某一行中.

行号的起始是0, 并且可以用分号`;`来分隔行, 也可以用标记[^1]来作为跳转的目标点.

如果选择手写的话, 最好是使用标记进行跳转, 否则行号处理很费劲.

目前所拥有的条件有:

| 条件          | 含义                          |
| ---           | ---                           |
| equal         | 两值相等则成立                |
| notEqual      | 两值不等则成立                |
| lessThan      | 两值成小于关系则成立          |
| lessThanEq    | 两值成不大于关系则成立        |
| greaterThan   | 两值成大于关系则成立          |
| greaterThanEq | 两值成不小于关系则成立        |
| strictEqual   | 两值类型和值都相等则成立[^2]  |
| always        | 永远成立                      |

示例代码, 这将会打印出`0,1,2,3,4`

```
set i 0
loop1:
    jump sk1 equal i 0 # 在头部跳过打印逗号
    print ","
sk1:
    print i
    op add i i 1
jump loop1 lessThan i 5
printflush message1
```

上述代码中, 井号直到行末尾表示注释, 可以用于说明代码的目的提升可读性.\
可惜导入进逻辑就消失了, 再导出也会消失, 所以需要保留的还是用执行不到的代码吧.

上述代码再从游戏中导出后jump会变成行号的形式, 如下

```
set i 0
jump 3 equal i 0
print ","
print i
op add i i 1
jump 1 lessThan i 5
printflush message1
```


关于逻辑实现的坑
-------------------------------------------------------------------------------
逻辑块解析跳转标记时, 不会将最后一行的标记链接到最头部, 例如如下代码

```
set var true
jump label always 0 0
    print "skipped"
label:
```

导入逻辑块时, jump 的跳转目标为 -1, 也就是未连接任何目标, 就像这行什么都没做

要是想要如同预期的那样跳转到最后一行然后回到首行,
我们需要将标签挪至首行或者使其不在尾部, 例如如下两种做法

```
label:
set var true
jump label always 0 0
    print "skipped"
```

```
set var true
jump label always 0 0
    print "skipped"
label:
end # 这样会多执行一行 end, 或许会变慢?
```


[^1]: 标记大致是一个普通的变量, 末尾冒号, 并直接接着行结束, 就可以成为一个标记.\
      标记可以作为被跳转的目标, 当然如果你再从逻辑导出标记就没有了

[^2]: 因为op的运算和jump的比较在两个值类型不相同时,
      都会先将其转换成同一个类型来比较, 比如null会转换成0,
      而很多的值都能转换成数字1, 这将产生一些隐藏的问题,
      区分null和0的情况相对比较常见, 所以我们需要使用严格相等, 也就是`strictEqual`


---
[上一章](./04-change-variable.md)
[目录](./README.md)
[下一章](./06-env-vars.md)

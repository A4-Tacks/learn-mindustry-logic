# 进阶控制流-基础
从这章开始, 将进入逻辑进阶部分讲解.

这一章主要是讲解规范控制结构, 掌握后可以更好的规划逻辑结构和层次

> [!NOTE]
> 在本章及后文中出现的如 `if cond { ... }` 这种代码一般是用来说明逻辑的,
> 并不是能直接导入逻辑中的语言, 需要经过处理才能被逻辑所使用

跳过结构
-------------------------------------------------------------------------------
这个结构很简单, 就是条件满足即跳过而已, 直接编写一条jump跳过一些语句即可

例如`skip a < b { print 1; } printflush message1;`表示为如下形式

```gas
jump end lessThan a b
    print 1
end:
printflush message1
```

这样即可在条件满足时, 跳过某段代码, 也意味着只有满足相反的条件才执行某段代码


if分支结构
-------------------------------------------------------------------------------
一个if分支结构, 我们希望分出两条分支, 条件满足时执行一个, 条件不满足时执行另一个

我们可以将不满足的分支放在上面, 然后前面写一个跳过的跳转, 从而完成这个结构

比如`if a < b { print 1; } else { print 2; } printflush message1;`,
我们可以写成这样:

```gas
jump true lessThan a b
    print 2 # 执行完不满足的分支跳过满足分支, 跳出这个if
jump end always 0 0
true:
    print 1
end:
printflush message1
```

当然对于连续的多个条件我们可以直接以此类推, 参考上述写法编写这样的逻辑

```gas
if a < b {
    print 1;
} else {
    if c < d {
        print 2;
    } else {
        print 3;
    }
}
printflush message1;
```

然后以相同方式展开即可.

为了避免无意义的多步无条件跳转串联, 手动把中间的跳转指向最终无条件跳转链的终点.

然后我们就能从上述代码得到以下展开式

```gas
jump true1 lessThan a b
    jump true2 lessThan c d
        print 3
    jump end always 0 0
    true2:
        print 2
jump end always 0 0
true1:
    print 1
end:
printflush message1
```


do-while循环结构
-------------------------------------------------------------------------------
这个结构很简单, 就是条件满足直接跳回头部, 就算条件永不满足也至少会执行一次

比如`set i 0; do { print i; op add i i 1; } while i < 3; printflush message1;`

应展开为

```gas
set i 0
cont:
    print i
    op add i i 1
jump cont lessThan i 3
printflush message1
```


while循环结构
-------------------------------------------------------------------------------
这个结构建立在do-while循环结构的基础上, 以在外面增加一个相反的条件直接跳过来实现

这样条件不满足就会直接跳过, 而不是执行至少一次了

比如`set i 0; while i < 3 { print i; op add i i 1; } printflush message1;`

应展开为

```gas
set i 0
jump break greaterThanEq i 3
cont:
    print i
    op add i i 1
jump cont lessThan i 3
break:
printflush message1
```


gwhile循环结构
-------------------------------------------------------------------------------
gwhile起到的作用和while循环结构相同, 但是实现上略有不同.

它用首次进入循环时多执行一行的代价, 换来条件部分不必重复编写一遍

这对于多条语句构成的复杂条件, 或者不想费事将条件反转很有效.

比如`set i 0; gwhile i < 3 { print i; op add i i 1; } printflush message1;`

应展开为

```gas
set i 0
jump cond always 0 0
cont:
    print i
    op add i i 1
cond:
jump cont lessThan i 3
printflush message1
```


---
[上一章](./19-unit-locate.md)
[目录](./README.md)
[下一章](./21-advanced-control-flow-select.md)

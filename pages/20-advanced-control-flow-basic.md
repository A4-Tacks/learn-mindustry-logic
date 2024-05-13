# 进阶控制流-基础
从这章开始, 将进入逻辑进阶部分讲解.

这一章主要是讲解规范控制结构, 掌握后可以更好的规划逻辑结构和层次

跳过结构
-------------------------------------------------------------------------------
这个结构真的很简单, 就是条件满足即跳过而已, 直接编写一条jump跳过要跳过的语句


if分支结构
-------------------------------------------------------------------------------
一个if分支结构, 我们期望有两个分支, 一个条件满足执行, 一个条件不满足执行

我们可以将不满足的分支放在上面, 然后前面增设一个跳转, 从而完成

比如`if a < b { print 1; } else { print 2; } printflush message1;`,
我们可以写成这样:

```
jump true lessThan a b
    print 2
jump end always 0 0
true:
    print 1
end:
printflush message1
```

当然对于连续的多个条件我们可以直接以此类推, 参考上述写法编写这样的逻辑

```
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
记得为了避免无用的多步无条件跳转, 手动把中间的跳转指向最终无条件跳转链的终点.

然后我们就能从上述代码得到以下展开式

```
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
这个结构很简单, 就是条件满足直接跳回首部, 就算条件永不满足也至少会执行一次

比如`set i 0; do { print i; op add i i 1; } while i < 3; printflush message1;`

应展开为

```
set i 0
cont:
    print i
    op add i i 1
jump cont lessThan i 3
printflush message1
```


while循环结构
-------------------------------------------------------------------------------
这个结构就是在do-while循环结构的基础上, 又在外面增加了一个相反的条件直接跳过,
这样就不会条件不满足还会执行一次了

比如`set i 0; while i < 3 { print i; op add i i 1; } printflush message1;`

应展开为

```
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
它起到的作用和while循环结构相同, 但是实现上略有不同.
它用首次进入循环时多执行一行的代价, 换来条件部分不必重复一遍,
这对于复杂条件或者不想用脑子反转条件很有效.

比如`set i 0; while i < 3 { print i; op add i i 1; } printflush message1;`

应展开为

```
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

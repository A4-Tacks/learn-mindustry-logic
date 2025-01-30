# 进阶控制流-选择
这是进阶结构中最重要的几个结构之一, 可以在恒定的时间内选到第n块代码, n为非负整数.

还记得我们前面接触过的`@counter`环境变量吗? 这也几乎是我们唯一能赋值的环境变量.

参考[前文](./06-env-vars.md)的脚注, 我们可以了解到逻辑运行语句的工作原理.

扩展思路, jump做的事也仅仅是在条件满足时去设置`@counter`到指定行罢了.

设我们有如下要实现的结构

```gas
select n {
    {
        print 0;
        jump end always 0 0;
    }
    {
        print 1;
        print "1!";
        jump end always 0 0;
    }
    {
        print 2;
    }
}
end:
printflush message1
```

我们可以构建出一张跳转子表, 在我们的预期中, n为整数且 $0 \le n \le 2$

```gas
op add @counter @counter n
jump n0 always 0 0
jump n1 always 0 0
jump n2 always 0 0
n0:
    print 0
    jump end always 0 0
n1:
    print 1
    print "1!"
    jump end always 0 0
n2:
    print 2
end:
printflush message1
```

观察上述代码, 根据前面讲过的流程,
在执行到op那行时, `@counter` 的行号指向第一个jump的行.
但是此时我们可以根据n去增加这个行数, 当n为1时, `@counter` 被增加1,
所以原本应该跳着至`n0`的变成跳转至`n1`, n为2时同理.

这个就是select结构, 据上例可以看出, 无论我们的块数量增加至多大, 跳转所需时间不变.

当然, select结构还有一种变体, 就是在我们每个块的长度差不多时, 我们可以使用另一种形式.
根据上述代码可以看出, 如果我们每个块均为1行时, 无需使用跳转子表进行跳转,
我们之间将目标行放在那里即可.

接着我们可以扩展一下, 每个块只有一个数要跳转过去且每个块长度相同时, 我们可以采取如下形式
```gas
op mul inc n 3 # 这里先计算出n去乘每个块行数应该产生多少偏移
op add @counter @counter inc # 偏移到块行数的正整数倍
    print 0
    print "\n"
    jump end always 0 0

    print 1
    print "\n"
    jump end always 0 0

    print 2
    print "\n"
end:
printflush message1
```

在上述代码中, 只要n满足我们预期的限制, 也就是n为非负整数且不大于最大块数,
那么n只会跳转到每个块的开头.

这种形式编写在一部分情况中, 因为不需要编写跳转表, 所以行数会得到一定的节省,
但是需要注意最大块行数, 并且不够长的需要填充一些语句,
而且穿透[^1]顺序只能按n正序进行, 跳转表形式还可以让n的多个值指向同一个块.
所以这种还是没有跳转表形式实用.


匹配守卫
---
这个是跳转表形式的进阶, 可以在跳转前先检查是否满足某个条件, 再行跳转.
检查这个条件的被称作'匹配守卫'

比如下述代码 (这是一个方便编写逻辑的语言[^2], 在这用来演示思路, 可以不管它)

`case 0`表示当n为0时执行下面一块代码, 后面的`if`表示但是还要满足if的条件

```gas
gswitch n {
case 0 if a < b:
    print 0 "yes";
    break; # 相当于jump到整个gswitch之后
case 0:
    print 0 "no";
    break;
case 1:
    print 1 "...";
}
printflush message1;
```

修整后, 我们将会得到以下代码

```gas
op mul __1 n 2
op add @counter @counter __1
    jump n0g lessThan a b # case 0 符合条件
    jump n0 always 0 0    # case 0 不符合条件
    jump n1 always 0 0    # case 1
n0g:
    print 0
    print "yes"
    jump end always 0 0
n0:
    print 0
    print "no"
    jump end always 0 0
n1:
    print 1
    print "..."
end:
printflush message1
```

可以看出, 这里我们采用了select的另一种形式来容纳更复杂的跳转表,
即带有匹配守卫的跳转表


[^1]: 穿透, 观察之前编写的示例代码, 除了最后一个块我们都编写了跳转至select末尾的语句,
      我们可以思考一下, 如果没有这么做的话会怎样?
      会继续执行下一个块, 直到被某个跳转跳出. 这种行为称作穿透.

[^2]: https://github.com/A4-Tacks/mindustry_logic_bang_lang


---
[上一章](./20-advanced-control-flow-basic.md)
[目录](./README.md)
[下一章](./22-complex-cond.md)

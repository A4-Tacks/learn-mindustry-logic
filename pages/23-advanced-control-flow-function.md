# 进阶控制流-函数

非递归型函数
-------------------------------------------------------------------------------
在手写时, 可以借此避免大量重复的代码, 但是需要那么几行的调用成本,
可以使用在那种例如几百行需要以不同的值重复调用的情况.

一个非递归函数结构由三个部分组成

- 头部: 为了让函数定义处的代码不被执行,
  我们需要用一个跳转跳过整个函数函数体和返回部分
- 函数体: 在这里编写函数所需的代码, 并约定函数需要的参数都有哪些变量
- 返回部分: 约定好一个返回行号的变量, 如ret1, 在这里编写一行`set @counter ret1`

而调用函数也可分为三部分

- 传参: 确保约定的参数变量如预期那样为要传入的值
- 设置返回行: 设置函数结束后要返回到的行, 非递归的情况一般是`@counter+1`
- 调用: 这个可以使用跳转到函数函数体, 或者在定义函数处设置一个变量得到行号,
  然后调用时直接设置`@counter`到函数函数体

比如我们编写一个函数, 打印一段话, 并返回, 调用两次

```gas
jump defined always 0 0
print_msg:
    print msg
    set @counter print_msg_ret
defined:

set msg "Hello, "
op add print_msg_ret @counter 1 # 记得加1跳过调用用的jump, 不然会一直原地调用
jump print_msg always 0 0

set msg "World!"
op add print_msg_ret @counter 1
jump print_msg always 0 0

printflush message1
```


递归型函数
-------------------------------------------------------------------------------
这种函数一般有特殊的目的, 比如使用某种算法等.

其递归需要依赖内存, 因为递归运行的还是这代码自己, 所以用的变量是同一套,
所以递归时需要跨越调用前后的变量需要手动存至内存元做的函数栈中.

比如以下一段代码, 是斐波那契的递归定义式, 不考虑尾递归等情况

```gas
set stack_top -1
jump defined always 0 0
fib:
    # 栈内每次调用占两个内存位, 0:返回行号 1:参数n, 调用者负责调用的栈平衡
    # 栈顶直接指向1位置, 空的栈为-1
    read n cell1 stack_top
    jump t1 greaterThan n 1
        set result 1
    jump t2 always 0 0
    t1:
        # 调用fib(n-1)
        op add stack_top stack_top 1
        op add ret @counter 5 # 跳到最后写入n的后面
        write ret cell1 stack_top
        op add stack_top stack_top 1
        op sub n n 1
        write n cell1 stack_top
        jump fib always 0 0

        read n cell1 stack_top
        write result cell1 stack_top # 复用n的位置, 把上一次调用的结果存入栈

        # 调用fib(n-2)
        op add stack_top stack_top 1
        op add ret @counter 5 # 跳到最后写入n的后面
        write ret cell1 stack_top
        op add stack_top stack_top 1
        op sub n n 2
        write n cell1 stack_top
        jump fib always 0 0

        read prev_result cell1 stack_top
        op add result prev_result result
    t2:
    op sub stack_top stack_top 1
    read ret cell1 stack_top
    op sub stack_top stack_top 1
    set @counter ret
defined:

set i 0
loop:
    print i
    print ":"

    # 调用fib(i)
    op add stack_top stack_top 1
    op add ret @counter 4 # 跳到最后写入n的后面
    write ret cell1 stack_top
    op add stack_top stack_top 1
    write i cell1 stack_top
    jump fib always 0 0

    print result
    print "\n"
    op add i i 1
jump loop lessThanEq i 7 # 因为递归斐波那契太慢了, 所以这个数小一些
printflush message1
```

从上述代码可以看出, 递归是如此的麻烦, 若非特殊需求, 不要轻易去使用.

> [!NOTE]
> 递归函数需要内存的原因是, 因为普通函数在一次外部调用中总是只会执行一次,
> 而递归函数则可能执行多次, 也就需要保存多个返回行, 所以一个变量不够
>
> 且有可能函数执行过程中算出了一些变量, 但是递归调用自身后依旧要使用,
> 这时这些变量就可能被递归的执行覆盖, 也需要将这些变量存入内存中再递归,
> 然后递归结束后再读出
>
> 例如上面的例子就将中间递归自身计算出的结果存入内存中,
> 刚好用于传参的内存槽在这就用不着了, 可以用来存这个结果

递归函数利用内存元完成调用栈,
且调用方或函数自身调用结束后需要栈顶挪回调用前的位置,
不然再使用调用栈时就可能获取到错误的结果,
比如从栈中读取参数读到了要返回到的行号

> [!TIP]
> 如果传参不用担心被递归调用覆盖, 那么完全可以用变量传, 用非递归函数的方式传


尾递归优化
-------------------------------------------------------------------------------
对于一些函数, 可以从递归转换成循环

在一次执行只在尾部递归一次的, 且没有跨越递归的变量,
那可以尝试把整个函数转换成一个循环,
递归条件被满足直接用一个跳转跳回函数头部, 也不用记录返回行号了,
从而变为非递归函数


---
[上一章](./22-complex-cond.md)
[目录](./README.md)
[下一章](./24-world-processor.md)

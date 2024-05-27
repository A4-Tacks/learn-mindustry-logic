# bang-const和take
在这章我们将讲述bang的部分值类型(不是逻辑的), 还有其操作

这章内容非常多, 也最好放一起讲

Variable (变量), 也简称量, 是逻辑的所有字面量(包括逻辑的变量)

对于bang的值类型, 每种都能执行几个操作

1. take, 这也是大多数情况, 比如直接的Other就是对每个参数时值顺序take.
   take后会得到一个Variable, 简称其为'句柄'.
2. const-follow (常量追溯, 在这章会讲), 通常只会进行一次

这章顺便学习部分值类型, 没有讲到const-follow行为的话, 那么都是返回其自身

- Repr-Variable (原始变量), 它的语法是一对反引号包裹着的 Variable,
  例如`` `var` ``

  它的take和const-follow都会返回自身包裹的那个Variable

- Variable (变量),

  它的take会在常量表中尝试找到一个常量, 找到的话进行take, 没找到的话返回自身.
  如果找到的那个常量值依旧是一个Variable, 那么它将直接使用那个值而不是继续take继续找

  它的const-follow会在常量表中尝试找到一个常量, 找到的话把值替换成找到的常量,
  没找到的话还是自身

- DExp (D表达式), 它的take就如前文所讲,
  不过它的返回句柄声明处take时会进行一个const-follow,
  并限定其结果只能是一个Variable, 如果不是则会报错.

- Value-Bind (值绑定), 它的take会尝试将左侧的值take,
  然后将其结果和右侧的Variable结合起来, 将其映射到一个匿名Variable.

  只要左侧take的结果和右侧的Variable相同, 那么它始终映射到同一个匿名量,
  并且这个不受作用域影响, 它们的作用范围是全局.

  映射结束后, 它会将这个量进行take

  使用示例如`foo.Value`

- Value-Bind-Ref (值绑定引用), 它有三种写法,
  固定不变的是一个值后面跟随一个`->`符号,

  接下来是之后跟随的几种情况

  - 跟着一个Variable, 这种情况take等同于`->`换成`.`, 也就是Value-Bind.

    而这种情况的const-follow时会直接将左侧值take,
    然后将得到的句柄和右侧Variable组合去查找绑定量得到这个匿名量, 就像Value-Bind,
    只不过之后不是take而是进行const-follow并返回其结果.

  - 跟着一个`$`符号, 这种情况直接的take直接take左侧值,
    而const-follow时会将左侧值直接take, 然后直接将其句柄返回.

  - 跟着一个`..`符号, 这个会对左侧值进行const-follow,
    然后返回其const信息中的绑定者, 这部分还没学不用管

- Result-Handle (返回句柄替换符), 它的take会得到最内层正在take的DExp的返回句柄.


---

接下来有了上面基本的值类型基础, 我们可以讨论两个核心语句了.

`const`语句, 比如`const A = 2;`, A是表示被定义的常量, 2是这个常量表示的值.

在2处, 会进行const-follow, 然后用得到的值去定义常量A.

常量拥有作用域, 基本上都是由两个所带来的, 一个是Expand-Block, 另一个是DExp,
查找常量时, 会优先从最内层的作用域进行查找, 例如以下代码.

```
{
    const A = 1;
    {
        const A = 2;
        print A; # 找到内层的2
    }
    print A; # 找到本层的1, 内层的作用域在块结束时已经销毁了
}
print A; # 因为什么都没找到, 所以使用A本身
```

会编译出如下结果

```
print 2
print 1
print A
```

---

`take`语句, 它和const语句很像, 只是`const`换成了`take`.

它的行为是直接把右侧的值进行take, 然后将其句柄直接const到左侧.

例如以下代码

```
take Result = (res: $ = 3;);
print 1; # 借这个语句分隔说明上面那个DExp的take的确是发生在使用Result前
print Result;
```

编译出以下结果

```
set res 3
print 1
print res
```

如果换成const则是


```
print 1
set res 3
print res
```


---
[上一章](./29-bang-d-expression.md)
[目录](./README.md)
[下一章](./31-bang-consted-metainfo.md)

# 复杂条件
对于需求的升级, 我们需要构建越来越复杂的逻辑.

我们可以定义以下表达

| 符号     | 名称   | 意义                             |
| ---      | ---    | ---                              |
| !cond    | 条件非 | 当条件反转                       |
| a && b   | 短路与 | 当条件a成立时, 取b的结果做条件   |
| a \|\| b | 短路或 | 当条件a不成立时, 取b的结果做条件 |

上表优先级由高到低, 二元运算左结合, 也就是说
`!a && b && c || d && e` 应等价加上括号的 `(((!a) && b) && c) || (d && e)`

短路的概念为, 当一边条件满足某些条件,
就不需要考虑(求值)另一边条件, 因为最终条件无论另一边结果是什么都不会影响.

接下来我们讲解一下`!`运算, 也就是将条件反转.

### 基本条件的反转
比如`! lessThan a b`, 我们可以简单的将其变成`greaterThanEq a b`,
也就是小于变成不小于(大于或等于).

对于一些特殊的条件没有其对应的, 比如`always`,
我们可以手动捏造一个永远不成立的条件用来占位(如果我们不将这个跳转删除的话),
也就是例如 `notEqual 0 0`.

而有些条件, 反转后需要增加额外的行, 比如`strictEqual a b`,
严格的反转必须首先计算`op strictEqual tmp a b`, 然后判定`equal tmp false`


### 复杂条件的反转
我们在上面提出了两种复杂条件, 在最终构建条件时,
我们不应考虑`!`条件, 所以要将其消去.

基本条件直接将其反转便能消去, 而对于反转复杂条件`&&`和`||`,
我们需要应用逻辑代数中的一个定律 [德•摩根定律].

这个定律很简单, 他定义了两条等式

$!(a \ \\&\\&\  b) \ =\  !a \ \mid\mid\  !b$
$!(a \ \mid\mid\  b) \ =\  !a \ \\&\\&\  !b$

依照上述等式不断的将左边形式变换至右边形式, 直到问题化为基本条件的反转,
此时我们就将`!`符号消去了


### 复杂条件的构建
在消去了`!`条件后, 我们要考虑的就是如何将一个`&&` `||`和基本条件组成的一个复杂条件构建为一系列jump了.

这有着成熟的算法, 以下是一段伪代码

```
def build(cond, target)
    if cond.type == "&&"
        tmp = tmp_tag()
        build(not(cond.a), tmp)
        build(cond.b, target)
        add(tmp)
    else if cond.type == "||"
        build(cond.a, target)
        build(cond.b, target)
    else
        # 基本条件
        add(jump target ...)
```

在上述代码中, `tmp_tag`获取一个临时的tag, 用于构建中间跳转,
而`add`可以将 jump 或者一个 tag 添加到最后一行.
而`not`, 就像前面的条件反转一样的流程, 反转那个条件.

`cond.a`是运算的左边条件, 而`cond.b`是右边的条件

比如将以下条件转换成逻辑 `jump target (a < b && c < d) || e < f`

```
# 首先从顶部的短路或运算进入
# 开始构建左边的 (a < b && c < d)
# 这是一个与运算, 所以我们将左边条件反转为(a >= b),
# 并将其构建目标指向一个临时标签tmp1
jump tmp1 greaterThanEq a b
# 然后左边构建完成开始构建右边
jump target lessThan c d
# 然后右边构建完成, 将临时标签加入
tmp1:
# 然后回到顶层那个短路或运算, 开始构建右边, 也就是(e < f)
jump target lessThan e f
print "false"
target:
print "target"
printflush message1
```

当然, 虽然理论有了, 但是实践中, 除非你通过编写程序来转换这些条件,
不然条件复杂起来就算有理论, 思维负担依旧偏大.

这里依旧是推荐编译器项目: <https://github.com/A4-Tacks/mindustry_logic_bang_lang>


[德•摩根定律]: https://baike.baidu.com/item/%E5%BE%B7%C2%B7%E6%91%A9%E6%A0%B9%E5%AE%9A%E5%BE%8B/489073


---
[上一章](./21-advanced-control-flow-select.md)
[目录](./README.md)
[下一章](./23-advanced-control-flow-function.md)

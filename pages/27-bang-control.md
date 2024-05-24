# bang-控制
在这章, 我们简单的学习到bang的流程控制语句, 相信我们在前文学习逻辑时多少见过一些类似的

参考[进阶控制流-基础]一章, 在那章中使用的语法正是bang语言中的语法.

不过对于if, bang中还有方便的`elif`而不是`else if`来方便使用,
虽然结构上会有些不同, 但是效果是一样的.

对于`while` `switch` `select` `do-while`这些结构, 会开启一个控制范围,
可以使用`break`来跳出这个范围结束循环等, 或者使用`continue`跳转至头部,
通常是循环条件的部分.

```
set x 0;
set y 3;
while x < 5 {
    break x == y;
    print c "\n";
    op add c x y;
}
printflush message1;
```

以上这段使用t选项会编译为以下结果

```
set x 0
set y 3
jump :0 greaterThanEq x 5
:1
jump :2 equal x y
print c
print "\n"
op add c x y
jump :1 lessThan x 5
:0
:2
printflush message1
```

这里bang使用冒号在前的标签来描述跳转标签, 可以看到, break条件满足时将会直接跳出循环


[进阶控制流-基础]: (./20-advanced-control-flow-basic.md)

---
[上一章](./26-bang-var.md)
[目录](./README.md)

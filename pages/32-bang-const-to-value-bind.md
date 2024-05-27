# bang-const到值绑定
在上一章我们说过元信息中含有值的绑定者, 在这章将展开讲解.

还记得之前介绍值的时候说过值绑定吗? 它的take会得到一个匿名的变量,
const的扩展用法可以往这个变量上进行const, 并且就像它的映射关系一样全局有效.

这个特性非常重要, 它可以使常量值向外传递.
不过为了避免污染, 你在设计时最好只往由DExp的take生成的匿名句柄上进行值绑定的const.

比如我们可以写出如下代码

```
const Vec = (
    take $.X = _0;
    take $.Y = _1;
    const $.Print = (
        print "X: "...X", Y: "...Y;
    );
);
const _0=5 _1=3;
take MyVec = Vec;
take MyVec.Print;
```

编译会得到如下结果

```
print "X: "
print 5
print ", Y: "
print 3
```

可以看到, 用这种方式, 可以将在DExp的const或者take的结果传递到作用域外.

`_0` `_1` 这种形式是约定好的将一些值传递给在take的DExp使用的变量


---
[上一章](./31-bang-consted-metainfo.md)
[目录](./README.md)

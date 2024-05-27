# bang-const后的元信息
在上一章我们学习了const和take, 在这章我们会了解一些const的元信息.

const的元信息包含

1. 被const的值
2. 值所包含的被跳转标签
3. 值的绑定者(之后会学)

值包含的被跳转标签收集这一步骤是在构建时随着const语句的, 如以下代码

```
const F = (
    :a
    do {
        print 2;
    } while;
);
```

以上代码使用A选项我们可以观察到在const语句上标签被记录了, 如下

```
const F = (
    :a
    {
        :___0
        {
            `'print'` 2;
        }
        goto :___0 _;
    }
);#*labels: [a, ___0]*#
```

在const上被记录的标签, 在take其值时, 会将这些标签重命名,
这可以使内部的标签不和外部标签重复, 或者多次展开同一个值间标签不重复.


---
[上一章](./30-bang-const-and-take.md)
[目录](./README.md)

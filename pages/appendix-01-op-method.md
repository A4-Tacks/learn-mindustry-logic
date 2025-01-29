附录01-op方法
===============================================================================
这里描述了op语句的所有运算符

| 算符          | 解释         |
| ---           | ---          |
| add           | 加法         |
| sub           | 减法         |
| mul           | 乘法         |
| div           | 除法         |
| idiv          | 整除         |
| mod           | 求余         |
| pow           | 幂           |
| equal         | 相等         |
| notEqual      | 不等         |
| land          | 逻辑与       |
| lessThan      | 小于         |
| lessThanEq    | 不大于       |
| greaterThan   | 大于         |
| greaterThanEq | 不小于       |
| strictEqual   | 严格相等     |
| shl           | 左移         |
| shr           | 右移         |
| or            | 按位或       |
| and           | 按位与       |
| xor           | 按位异或     |
| not           | 按位取反     |
| max           | 最大值       |
| min           | 最小值       |
| angle         | 向量幅角     |
| angleDiff     | 幅角差绝对值 |
| len           | 向量模长     |
| noise         | 二维单形噪声 |
| abs           | 绝对值       |
| log           | 自然对数     |
| log10         | 底10对数     |
| floor         | 向下圆整     |
| ceil          | 向上圆整     |
| sqrt          | 平方         |
| rand          | 随机         |
| sin           | 正弦[^1]     |
| cos           | 余弦[^1]     |
| tan           | 正切[^1]     |
| asin          | 反正弦[^1]   |
| acos          | 反余弦[^1]   |
| atan          | 反正切[^1]   |


[^1]: 这里的三角函数全部为角度制而非弧度制,
      也就是说你可以直接使用`cos(360)`, 而不是`cos(2*@pi)`


---
[目录](./README.md)

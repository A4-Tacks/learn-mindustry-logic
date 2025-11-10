# 内存的读和写
在这一章, 我们将了解两个语句和两个逻辑建筑, 这是复杂逻辑中的常客

在游戏中, 有一类特殊的建筑, 叫内存(memory).

通常我们使用内存元(cell)或者内存库(bank), 它们可以存储一系列**数字**,
并且以指定的编号去访问(从0起始).

内存元和内存库的区别仅在于大小和最大编号数目.

操作内存的语句有两条, 一条是`read`(读), 一条是`write`(写).

这两个语句都有三个参数, 区别在于最左边的参数,
读语句是获取目标并赋值到参数, 写语句是求值参数并将值存储到目标.

另外两个参数分别是 操作哪个内存 和 内存中哪个编号, 用来确定目标

比如以下逻辑, 将一个数字存储到内存元中编号3位置, 并获取再打印出来

```gas
write 123 cell1 3 # 存储, 当然更合适的称呼叫做写入
read num cell1 3  # 从编号3的位置读取这个数字并赋值到num
print num
printflush message1
```

当然从上面这个小例子, 应该是看不出使用内存的必要性,
但是希望在后期, 在编写稍微复杂的思路碰壁时, 能想到是否可以使用内存.

内存也常常被用于多逻辑协同

### 上文使用的名词术语表
| 易于理解的 | 标准的           |
| ---        | ---              |
| 编号       | 地址、下标、索引 |
| 存储到     | 写入             |
| 获取       | 读取             |

> [!TIP]
> 对内存的读写并不要求链接目标内存, 具体的权限控制如下:
>
> `exec.privileged || (from.team == exec.team && !mem.block.privileged)`
>
> 当你的处理器是世处, 或者你与内存队伍相同且内存不是世处内存元即可读写


读取其它逻辑变量
-------------------------------------------------------------------------------
自 BE-25666 版本后, `read` 和 `write` 的功能被进行了扩展,
可以对其他逻辑中的变量进行读写

> [!NOTE]
> 被读写的变量必须是**已声明的**[^1]

例如有逻辑块A链接信息板至`message1`代码如下:
```gas
print n
printflush message1
```
由于在 `print` 中使用了变量 `n`, 所以变量 `n` 被声明

而逻辑块B链接逻辑块A至`processor1`, 代码如下:
```gas
read local processor1 "n"
op add result local 1
write result processor1 "n"
```

而观察逻辑块A链接的信息板, 会发现数字在不断递增,
这是来自逻辑块B对变量`n`的修改导致


[^1]: 声明指的是在参数中使用过此变量, 一旦使用过, 该变量将会在变量表中可见

      有时即便参数在逻辑编辑器的语句中并不可见, 也依旧声明了变量,
      例如 `op abs result n b` 会声明 `result`, `n`, `b` 三个变量,

      虽然 `op abs` 并不需要用到变量 `b`,
      但是通常大多数语句获取变量的个数都是固定的,
      所以哪怕其中一些语句的用法并没有用到某些变量, 这些变量也会被声明

      (大部分环境变量在变量表中被隐藏, `@counter` 除外)


读取字符单元
-------------------------------------------------------------------------------
在 146 后的某个版本中(建议 147-Beta 版本起),
`read` 语句可以读取字符串中某个字符的 utf-16 单元,
可以配合 [`printchar`](./07-print-and-draw.md#打印字符) 使用

字符串的 utf-16 单元长度由 `sensor` 语句的 `@size` 属性来获取

例如以下示例逻辑, 将字符串内容每个 utf-16 单元后加上一个换行再打印:

```gas
set str "你好,测试"
sensor size str @size
set i 0
loop:
    read char str i
    printchar char
    print "\n"
    op add i i 1
jump loop lessThan i size
printflush message1
```

> [!WARNING]
> 由于处理的是 utf-16 单元, 所以可能出现一个字符码点被分当成两个字处理的情况,
> 例如某个生僻字 `"𪙛"`


### 读取信息板
自 150 版本起, 类似读取字符串, `read` 语句还可以从信息板中读取,
不过获取长度使用 `@bufferSize` 而不是 `@size`

例如将 `message1` 的信息转移到 `message2`

```gas
set i 0
sensor size message1 @bufferSize
jump finish equal size 0
loop:
    read char message1 i
    printchar char
    op add i i 1
jump loop lessThan i size
finish:
printflush message2
```


### 读取画板 (Canvas)
自 150 版本起, 类似读写内存库, `read` 和 `write` 语句还可以从画板中读取,
长度为 144 (12x12), 不过边缘容易被边框遮住

需要注意的是, 仅支持写入 `[0,7] 范围的整数值`

例如将 `canvas1` 的图形转移到 `canvas2`

```gas
set i 0
set size 144
loop:
    read color canvas1 i
    write color canvas2 i
    op add i i 1
jump loop lessThan i size
printflush message2
```


---
[上一章](./10-control.md)
[目录](./README.md)
[下一章](./12-other-control-flow.md)

# 编译器

在编写逻辑行数过多时, 维护会非常艰难, 此时可以考虑使用编译器

编译器可以将其它语言翻译成逻辑语言,
而使用其它语言来编写代码会更加方便、结构更清晰、易于封装功能、编辑方便等

## 以下列出一些较为实用的编译器, 按star数排序

| 名称          | 特点                         | 参考语言       | 安装难度                                             | 编辑条件                                                  |
| ---           | ---                          | ---            | ---                                                  | ---                                                       |
| [mindcode]    | 极强的优化, 优秀的编译期计算 | 无             | B-下载jar, 运行需要Java环境                          | 有一个网页编辑器, 和扩展语言                              |
| [mlogjs]      | 参考js, 好上手, 编辑体验好   | JavaScript     | B-需要使用npm安装依赖, 有在线版本且很不错            | 直接使用 JavaScript/TypeScript 的补全, 有很好的网页编辑器 |
| [pyndustric]  | 功能偏弱, 不过有内联函数     | Python         | A-需要处理python依赖, 需要python环境                 | 直接使用 Python 代码的补全                                |
| [bang-lang]   | 极强灵活度, 操作生成的代码   | 逻辑语言       | C-下载可执行程序, 控制台运行                         | 使用 VSCode 进行编辑, 具有简单高亮、代码片段和词法补全    |
| [go-mlog]     | 内置支持了自动递归函数       | Go             | D-下载可执行程序, 控制台执行, 有在线版本             | 直接使用 Go 代码的补全                                    |
| [mlogx]       | 极端简陋, 增加了少量宏语句   | 逻辑语言       | A-需要使用npm安装依赖                                | 纯文本编辑器, 如记事本等                                  |
| [mlogpp]      | 优秀的编译期计算, 结构体抽象 | 无             | A-需要处理python依赖, 需要python环境                 | 似乎没有任何编辑支持                                      |
| [slimlog]     | LISP风格                     | LISP           | B-需要安装rust环境                                   | 没有任何编辑支持                                          |

如果你已经学过 '参考语言' 的话, 学习对应的编译器将会较为简单

例如如果你阅读完了本教程, 学习 [bang-lang] 将会较为简单


## 以下是一些特性列表

| 名称          | 代码性能             | 短路条件 | switch | 内联函数 | 非递归函数 | 递归函数 | 循环展开 |
| ---           | ---                  | ---      | ---    | ---      | ---        | ---      | ---      |
| [mindcode]    | A-极强的优化         | -        | +      | +        | +          | +        | ?        |
| [mlogjs]      | C-结构稍差           | +        | +      | +        | +          | -        | ?        |
| [pyndustric]  | C-结构稍差           | -        | -      | +        | +          | -        | -        |
| [bang-lang]   | B-无优化, 结构良好   | +        | +      | +        | +          | #        | #        |
| [go-mlog]     | D-经常更慢           | -        | +      | ?        | +          | +        | ?        |
| [mlogx]       | B-基本没做什么       | -        | -      | -        | +          | -        | -        |
| [mlogpp]      | C-结构稍差, 较少优化 | -        | -      | +        | -          | -        | -        |
| [slimlog]     | D-结构稍差, 冗余代码 | -        | -      | -        | -          | -        | -        |

`-` 为未支持, `+` 为已支持, `?` 为未知, `#` 为半手动支持


## 以下是元编程能力

| 名称          | 编译期求值能力                                 | 编译期代码操作能力             | 结构化抽象能力 |
| ---           | ---                                            | ---                            | ---            |
| [mindcode]    | A-很完善且统一                                 | C-少量, 如重复展开代码         | D-较弱         |
| [mlogjs]      | D-基础的求值                                   | D-基本没有                     | C-较弱         |
| [pyndustric]  | E-无                                           | E-无                           | E-基本没有     |
| [bang-lang]   | C-通常仅做数值计算, 其余动静态求值并不怎么统一 | B-将代码作为值, 传递并随处生成 | B-手动操作代码 |
| [go-mlog]     | E-无                                           | D-基本没有                     | E-基本没有     |
| [mlogx]       | E-无                                           | D-基本没有                     | E-基本没有     |
| [mlogpp]      | A-很完善, 较为统一                             | C-少量                         | A-极强         |
| [slimlog]     | E-无                                           | E-无                           | E-无, 有潜力   |


## 以下是文档情况

| 名称          | 文档                                         |
| ---           | ---                                          |
| [mindcode]    | B-英文独立文档, 质量较高                     |
| [mlogjs]      | B-英文独立文档, 质量还行                     |
| [pyndustric]  | D-仅README少量例子                           |
| [bang-lang]   | B-中英双版本教程, 质量勉强, 高级部分内容极长 |
| [go-mlog]     | C-英文独立wiki, 内容较少                     |
| [mlogx]       | B-英文独立文档, 基本大致介绍                 |
| [mlogpp]      | C-仅README少量例子, 与一点代码示例           |
| [slimlog]     | D-有一些代码示例                             |


## 以下是版本跟进情况

| 名称          | 版本跟进                                       |
| ---           | ---                                            |
| [mindcode]    | A-目前为止非常活跃                             |
| [mlogjs]      | C-目前较不活跃                                 |
| [pyndustric]  | C-目前较不活跃                                 |
| [bang-lang]   | B-目前较不活跃, 但是由于其设计不跟进也影响不大 |
| [go-mlog]     | E-停滞(2022)                                   |
| [mlogx]       | C-目前较不活跃                                 |
| [mlogpp]      | E-停滞(2023)                                   |
| [slimlog]     | E-停滞(2023)                                   |


[mindcode]: https://github.com/cardillan/mindcode
[mlogjs]: https://github.com/mlogjs/mlogjs
[pyndustric]: https://github.com/Lonami/pyndustric
[bang-lang]: https://github.com/A4-Tacks/mindustry_logic_bang_lang
[go-mlog]: https://github.com/Vilsol/go-mlog
[mlogx]: https://github.com/BalaM314/mlogx
[mlogpp]: https://github.com/albi-c/mlogpp
[mlogls]: https://github.com/JeanJPNM/mlogls
[c2logic]: https://github.com/SuperStormer/c2logic
[minasm]: https://github.com/yangfl/minasm
[MlogEvo]: https://github.com/UMRnInside/MlogEvo
[VCode]: https://github.com/Sirvoid/MindustryVCode
[slimlog]: https://github.com/ThePotatoChronicler/slimlog


> 如果发现编译器特性等描述错误, 请打开一个 issue 来讨论


不推荐的编译器
===============================================================================
在上述列表中, 有意的忽略了一些编译器, 原因如下

| 名称          | 原因                                                                 |
| ---           | ---                                                                  |
| [c2logic]     | 似乎bug极多, 生成的代码非常古怪                                      |
| [mlogls]      | 零文档零示例                                                         |
| [minasm]      | 项目结构并不像一个项目, 而是将一组前端代码打包, 尝试浏览器打开, 失败 |
| [MlogEvo]     | 基本无文档, 存在一些bug, 影响正常使用                                |
| [VCode]       | 零文档, 基本无示例, 无法在命令行运行, 测试不便                       |


---
[上一章](./24-world-processor.md)
[目录](./README.md)
[下一章](./26-start-bang-lang.md)

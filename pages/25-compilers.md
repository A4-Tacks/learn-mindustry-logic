# 编译器

在编写逻辑行数过多时, 维护会非常艰难, 此时可以考虑使用编译器

编译器可以将其它语言翻译成逻辑语言,
而使用其它语言来编写代码会更加方便、结构更清晰、易于封装功能、编辑方便等

## 以下列出一些较为实用的编译器, 按star数排序

| 名称          | 特点                       | 参考语言       | 安装难度                                             | 编辑条件                                                  |
| ---           | ---                        | ---            | ---                                                  | ---                                                       |
| [mindcode]    | 极强的优化                 | 无             | B-下载jar, 运行需要Java环境                          | 有一个网页编辑器, 和扩展语言                              |
| [mlogjs]      | 参考js, 好上手, 编辑体验好 | JavaScript     | B-需要使用npm安装依赖, 有在线版本且很不错            | 直接使用 JavaScript/TypeScript 的补全, 有很好的网页编辑器 |
| [pyndustric]  | 功能偏弱, 不过有内联函数   | Python         | A-需要处理python依赖, 需要python环境                 | 直接使用 Python 代码的补全                                |
| [bang-lang]   | 极强灵活度, 操作生成的代码 | 逻辑语言       | C-下载可执行程序, 控制台运行                         | 使用 VSCode 进行编辑, 具有简单高亮、代码片段和词法补全    |
| [go-mlog]     | 内置支持了自动递归函数     | Go             | D-下载可执行程序, 控制台执行, 有在线版本             | 直接使用 Go 代码的补全                                    |

如果你已经学过 '参考语言' 的话, 学习对应的编译器将会较为简单

例如如果你阅读完了本教程, 学习 [bang-lang] 将会较为简单


## 以下是一些特性列表

| 名称          | 代码性能           | 短路条件 | switch | 内联函数 | 非递归函数 | 递归函数 | 循环展开 |
| ---           | ---                | ---      | ---    | ---      | ---        | ---      | ---      |
| [mindcode]    | A-极强的优化       | -        | +      | +        | +          | +        | ?        |
| [mlogjs]      | C-结构稍差         | +        | +      | +        | +          | -        | ?        |
| [pyndustric]  | C-结构稍差         | -        | -      | +        | +          | -        | -        |
| [bang-lang]   | B-无优化, 结构良好 | +        | +      | +        | +          | #        | #        |
| [go-mlog]     | D-经常更慢         | -        | +      | ?        | +          | +        | ?        |

`-` 为未支持, `+` 为已支持, `?` 为未知, `#` 为半手动支持


## 以下是文档情况

| 名称          | 文档                                         |
| ---           | ---                                          |
| [mindcode]    | B-英文独立文档, 质量较高                     |
| [mlogjs]      | B-英文独立文档, 质量还行                     |
| [pyndustric]  | D-仅README少量例子                           |
| [bang-lang]   | B-中英双版本教程, 质量勉强, 高级部分内容极长 |
| [go-mlog]     | C-英文独立wiki, 内容较少                     |


## 以下是版本跟进情况

| 名称          | 版本跟进                                       |
| ---           | ---                                            |
| [mindcode]    | A-目前为止非常活跃                             |
| [mlogjs]      | C-目前较不活跃                                 |
| [pyndustric]  | D-基本停滞                                     |
| [bang-lang]   | B-目前较不活跃, 但是由于其设计不跟进也影响不大 |
| [go-mlog]     | D-基本停滞                                     |



[mindcode]: https://github.com/cardillan/mindcode
[mlogjs]: https://github.com/mlogjs/mlogjs
[pyndustric]: https://github.com/Lonami/pyndustric
[bang-lang]: https://github.com/A4-Tacks/mindustry_logic_bang_lang
[go-mlog]: https://github.com/Vilsol/go-mlog

---
[上一章](./24-world-processor.md)
[目录](./README.md)
[下一章](./26-start-bang-lang.md)

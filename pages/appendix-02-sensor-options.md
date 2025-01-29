附录02-传感器选项
===============================================================================
这里描述了所有的sensor可用属性.

当然, 游戏中编辑器sensor语句可以直接选择选项,
你可以直接在游戏内编辑器编写一条sensor, 然后选择选项时长按或将鼠标悬停于某选项,
游戏内编辑器有对很多属性进行解释, 或许会很有帮助

**物品属性**, sensor支持直接通过物品的content获取建筑、单位等里面某种物品的数量

**液体属性**, sensor支持直接通过液体的content获取建筑、单位等里面某种液体的数量

**固有属性**, sensor始终可用的一系列通用属性, 参考下表

| 属性              | 翻译          |
| ---               | ---           |
| totalItems        | 总物品数      |
| firstItem         | 第一个物品    |
| totalLiquids      | 总液体数      |
| totalPower        | 总电力        |
| itemCapacity      | 物品容量      |
| liquidCapacity    | 液体容量      |
| powerCapacity     | 电力容量      |
| powerNetStored    | 电网储电      |
| powerNetCapacity  | 电网电容量    |
| powerNetIn        | 电网净输入    |
| powerNetOut       | 电网净输出    |
| ammo              | 弹药          |
| ammoCapacity      | 弹药容量      |
| health            | 血量          |
| maxHealth         | 血量上限      |
| heat              | 热量          |
| shield            | 盾            |
| efficiency        | 效率          |
| progress          | 进度          |
| timescale         | 时间比例      |
| rotation          | 朝向          |
| x                 | x坐标         |
| y                 | y坐标         |
| shootX            | 射击点X       |
| shootY            | 射击点Y       |
| size              | 大小          |
| dead              | 已死亡        |
| range             | 范围          |
| shooting          | 是否射击      |
| boosting          | 是否助推      |
| mineX             | 挖矿点X       |
| mineY             | 挖矿点Y       |
| mining            | 是否正在挖矿  |
| speed             | 速度          |
| team              | 队伍          |
| type              | 类型          |
| flag              | 标记          |
| controlled        | 已控制        |
| controller        | 控制者        |
| name              | 名称          |
| payloadCount      | 荷载数量      |
| payloadType       | 荷载类型      |
| id                | 编号          |
| enabled           | 启用          |
| config            | 设置[^1]      |
| color             | 颜色          |


[^1]: 比如分类器选中的物品, 注意不要和build系列语句的config记混

---
[目录](./README.md)

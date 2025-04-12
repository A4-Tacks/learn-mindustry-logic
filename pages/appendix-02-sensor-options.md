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
| firstItem         | 首个物品      |
| totalLiquids      | 总液体数      |
| totalPower        | 总电力        |
| itemCapacity      | 物品容量      |
| liquidCapacity    | 液体容量      |
| powerCapacity     | 电力容量      |
| powerNetStored    | 电网电池储电  |
| powerNetCapacity  | 电网电池容量  |
| powerNetIn        | 电网净输入    |
| powerNetOut       | 电网净输出    |
| ammo              | 弹药          |
| ammoCapacity      | 弹药容量      |
| currentAmmoType   | 当前弹药类型  |
| memoryCapacity    | 内存容量[^3]  |
| health            | 血量          |
| maxHealth         | 血量上限      |
| heat              | 热量          |
| shield            | 盾            |
| armor             | 护甲          |
| efficiency        | 效率          |
| progress          | 进度          |
| timescale         | 时间系数      |
| rotation          | 朝向          |
| x                 | X坐标         |
| y                 | Y坐标         |
| velocityX         | 运动速度X     |
| velocityY         | 运动速度Y     |
| shootX            | 射击点X       |
| shootY            | 射击点Y       |
| cameraX           | 相机X         |
| cameraY           | 相机Y         |
| cameraWidth       | 相机宽度      |
| cameraHeight      | 相机高度      |
| size              | 大小[^4]      |
| solid             | 是否实心      |
| dead              | 是否已死亡    |
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
| totalPayload      | 已用荷载空间  |
| payloadCapacity   | 荷载容量      |
| id                | 编号[^2]      |
| enabled           | 是否启用      |
| config/configure  | 设置[^1]      |
| color             | 颜色          |


[^1]: 比如分类器选中的物品, 注意不要和build系列语句的config记混

[^2]: 获取 content 的对应 lookup 语句的编号, 注意是 content 而不是 unit building 等

[^3]: 指定内存中能存储多少个数据, 例如 cell 是 64 个, bank 是 512 个

[^4]: 不仅能获取建筑、单位的大小, 还能获取字符串的大小(utf-16长度)

---
[目录](./README.md)

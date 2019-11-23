# flex布局

Flexible Box 模型，通常被称为 flexbox，是一种一维的布局模型。它给 flexbox 的子元素之间提供了强大的空间分布和对齐能力。本文给出了 flexbox 的主要特性，更多的细节将在别的文档中探索。

我们说 flexbox 是一种一维的布局，是因为一个 flexbox 一次只能处理一个维度上的元素布局，**一行或者一列**。作为对比的是另外一个二维布局 CSS Grid Layout，可以**同时**处理行和列上的布局。

## flexbox的两个轴线

当使用 flex 布局时，首先想到的是两根轴线 — 主轴和交叉轴。主轴由 `flex-direction` 定义，另一根轴垂直于它。我们使用 `flexbox` 的所有属性都跟这两根轴线有关, 所以有必要在一开始首先理解它。

### 主轴

主轴由 flex-direction 定义，可以取4个值：

- row
- row-reverse
- column
- column-reverse

如果你选择了 row 或者 row-reverse，你的主轴将沿着 inline 方向延伸。


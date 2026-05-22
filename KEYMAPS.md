# Neovim 快捷键文档

## 通用基础快捷键

| 按键 | 功能 |
|------|------|
| `<Space>` | Leader Key |
| `<leader>w` | 保存文件 |
| `<leader>q` | 强制退出 |
| `j/k` | 虚拟行上下移动 |
| `$` / `g_` | 跳转行尾 |
| `H` / `L` | 跳转到行首/行尾 |
| `<C-j>` / `<C-k>` | 5行下/上移动 |
| `<C-d>` / `<C-u>` | 10行下/上移动 |
| `<Esc>` | Terminal 切换到 Normal 模式 |

### 窗口操作 (`s` 前缀)

| 按键 | 功能 |
|------|------|
| `sv` | 垂直分屏 |
| `sh` | 水平分屏 |
| `sc` | 关闭当前窗口 |
| `so` | 关闭其他窗口 |
| `<A-h/j/k/l>` | 窗口间跳转 |
| `s,` / `s.` | 减少/增加垂直宽度 |
| `sj` / `sk` | 减少/增加水平高度 |

### Visual 模式

| 按键 | 功能 |
|------|------|
| `<` / `>` | 缩进代码 |
| `J` / `K` | 上下移动选中文本 |
| `p` | 粘贴不复制已选内容 |

---

## Buffer (bufferline)

| 按键 | 功能 |
|------|------|
| `<C-h>` | 上一个 Buffer |
| `<C-l>` | 下一个 Buffer |
| `<C-w>` | 关闭当前 Buffer |
| `<leader>bh` | 关闭左侧所有 Buffer |
| `<leader>bl` | 关闭右侧所有 Buffer |
| `<leader>bo` | 关闭其他 Buffer |
| `<leader>bp` | 选择性关闭 Buffer |

---

## NvimTree

| 按键 | 功能 |
|------|------|
| `<leader>m` | 切换 NvimTree |
| `o` / `<2-LeftMouse>` | 打开文件/目录 |
| `sv` / `sh` / `st` | 垂直/水平/标签页打开 |
| `P` | 跳转到父节点 |
| `K` / `J` | 第一个/最后一个兄弟节点 |
| `a` | 创建文件 |
| `d` | 删除文件 |
| `r` | 重命名 |
| `x` | 剪切 |
| `c` | 复制 |
| `p` | 粘贴 |
| `y` / `Y` / `gy` | 复制文件名/相对路径/绝对路径 |

---

## Telescope

| 按键 | 功能 |
|------|------|
| `<C-p>` / `ff` | 查找文件 |
| `<C-f>` | 全局搜索 |
| `<C-j>` / `<C-k>` | 下/上选择项 |

---

## GitSigns

| 按键 | 功能 |
|------|------|
| `<leader>gj` / `<leader>gk` | 下/上一个 Hunk |
| `<leader>gs` | 暂存 Hunk |
| `<leader>gS` | 暂存整个 Buffer |
| `<leader>gu` | 撤销暂存 |
| `<leader>gr` / `<leader>gR` | 重置 Hunk / Buffer |
| `<leader>gp` | 预览 Hunk |
| `<leader>gb` | Blame 行 |
| `<leader>gd` / `<leader>gD` | Diff this |
| `<leader>gtb` | 切换当前行 Blame |
| `<leader>gtd` | 切换显示已删除 |

---

## LSP

| 按键 | 功能 |
|------|------|
| `gd` | 跳转到定义 |
| `gi` | 跳转到实现 |
| `gr` | 查找 References |
| `gh` | 显示 Hover 信息 |
| `<leader>rn` | 重命名变量 |
| `<leader>ca` | 代码操作 |
| `<leader>f` | 格式化当前 Buffer |
| `gp` | 打开浮窗诊断 |
| `gj` / `gk` | 下/上一个诊断 |

---

## Debug (DAP)

| 按键 | 功能 |
|------|------|
| `<leader>dc` | 继续/开始调试 |
| `<leader>de` | 终止调试 |
| `<leader>dj` / `<leader>di` / `<leader>do` | Step Over / Into / Out |
| `<leader>dt` / `<leader>dT` | 切换/清除断点 |
| `<leader>dh` | 评估/监视 |

---

## Terminal

| 按键 | 功能 |
|------|------|
| `<leader>ta` | 切换浮动 Terminal |
| `<leader>tb` | 切换侧边 Terminal |
| `<leader>tc` | 切换底部 Terminal |

---

## 其他插件

### Comment

| 按键 | 功能 |
|------|------|
| `gcc` / `gbc` | 切换行/块注释 (Normal) |
| `gc` / `gb` | 注释选中文本 (Visual) |

### Surround

| 按键 | 功能 |
|------|------|
| `ys` | 添加包围 (Normal) |
| `ds` / `cs` | 删除/改变包围 |
| `yss` | 包围当前行 |

### Neotest

| 按键 | 功能 |
|------|------|
| `<leader>nt` | 切换测试面板 |
| `<leader>nr` / `<leader>nf` | 运行测试/当前文件测试 |
| `<leader>nd` | DAP 运行测试 |

### Markdown (mkdnflow)

| 按键 | 功能 |
|------|------|
| `gn` / `gp` | 下/上一个链接 |
| `gj` / `gk` | 下/上一个标题 |
| `gd` | 跟随链接 |

### Zen Mode

| 按键 | 功能 |
|------|------|
| `<leader>z` | 切换 Zen Mode |

---

## AI 助手

### CodeCompanion

| 按键 | 功能 |
|------|------|
| `<leader>cc` | 打开/关闭 Chat |
| `<leader>cp` | 打开 Actions 面板 |

### Copilot Chat

| 按键 | 功能 |
|------|------|
| `<leader>cc` | Quick Chat |
| `<leader>cp` | Prompt Actions |
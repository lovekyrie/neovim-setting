# InsisVim

> [English](./README-EN.md) 

一个开箱即用的 Neovim IDE 层，以难以置信的简单方式配置开发环境，例如配置 `golang`，只需：

```lua
require("insis").setup({
  golang = {
    enable = true,
    lsp = "gopls",
    linter = "golangci-lint",
    formatter = "gofmt",
    format_on_save = true,
  },
})
```

`:wq` 保存重启后，会自动安装语法高亮和 Golang Language Server，Linter，Formatter 等。

## 🛠 安装

https://github.com/nshen/InsisVim/assets/181506/ad36e1b1-05f6-47e9-bf2e-6738f539ccce

### 注意事项

- 如缺少以下常见命令行工具，`git`、`wget`、`curl`、`ripgrep`、`nvim v0.9.x`，则有可能安装失败。

  - 在 Mac 上，您可以使用 `brew install` 安装以上工具。
  - 在 Ubuntu 上，您可以检查 [Ubuntu 安装指南](https://github.com/nshen/InsisVim/issues/5)。

- 如之前安装过其他配置，建议先删除或备份以下目录

  - `~/.local/share/nvim`
  - `~/.cache/nvim`
  - `~/.config/nvim`

* 需要**科学网络**环境，建议开启**全局/增强**模式等，如遇[网络问题可以到此讨论](https://github.com/nshen/learn-neovim-lua/discussions/categories/q-a?discussions_q=is%3Aopen+category%3AQ%26A+label%3A%E6%8F%92%E4%BB%B6%E5%AE%89%E8%A3%85%E9%97%AE%E9%A2%98)

### 安装步骤

1. 克隆本项目到 Neovim 配置目录

```lua
git clone https://github.com/nshen/InsisVim.git ~/.config/nvim
```

2. 运行 `nvim` ，等待插件全部安装完成

3. 重启

## 自定义配置

自定义配置非常简单，就像配置一个插件一样，只需要修改 `~/.config/nvim/init.lua` 后保存重启即可

```lua
require("insis").setup({
    -- 按需设置参数
})
```

这里支持的参数非常的多，但基本上分为**常用配置**，和**编程环境配置**。

### 常用配置

例如用来设置主题的 `colorscheme` 这类常用的配置，修改后 `:wq` 保存重启即可生效

```lua
require("insis").setup({
    colorscheme = "tokyonight"
})
```

> InsisVim 默认使用 `tokyonight` 主题，同时内置了 `nord`、`onedark`、`gruvbox`、`nightfox`、`nordfox`、`duskfox`、`dracula` 主题。
> 可以通过 `:InsisColorPreview` 命令预览内置主题

https://github.com/nshen/InsisVim/assets/181506/15517b20-acdf-45eb-9db6-9a0d0806cb4a

#### AI 补全

<details>
<summary>Copilot 配置</summary>
  
```lua
require("insis").setup({
  cmp = {
    -- 让 cmp 启用 copilot 补全
    copilot = true,
  },
})
```

InsisVim 内置了以下插件，启用后会使其生效

- [copilot.lua](https://github.com/zbirenbaum/copilot.lua)
- [copilot-cmp](https://github.com/zbirenbaum/copilot-cmp)
- [copilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim/tree/canary)

因为 copilot 是收费的，首次使用需要运行 `:Copilot auth` 认证后才会生效，但如果你是学生老师或者开源项目贡献者，可以[申请免费](https://docs.github.com/en/copilot/quickstart)使用。

> GitHub Copilot is free to use for verified students, teachers, and maintainers of popular open source projects.

启用 `Copilot Chat` 就可以和代码对话了：

```lua
copilot_chat = {
  enable = true,
  keys = {
     -- Code Chat 快速与选中的代码对话
     quick_chat = "<leader>cc",
     -- Code Prompt 列出打开各种预定义prompt，例如解释代码，重构代码，加文档等
     prompt_actions = "<leader>cp",
     -- Code Help 修复选中错误
     help_actions = "<leader>ch",
  },
},
```

</details>

<details>
<summary>Codeium 配置</summary>

```lua
require("insis").setup({
  cmp = {
    -- 让 cmp 启用 codeium 补全
    codeium = true,
  },
})
```

InsisVim 内置了[Codeium.nvim](https://github.com/Exafunction/codeium.nvim)，启用后会使其生效

首次使用需要运行 `:Codeium Auth` 认证一下即可生效

</details>

#### Buffers

在 Vim 世界里，Buffer 表示已经加载到内存中的文件。非常像 VSCode 中的 Tab 页，在 VSCode 里看到一个标签页，就表示一个文件加载到内存中了。

在 InsisVim 中使用 [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) 插件来模拟这种行为，并且简化了配置，非常容易定制按键

https://github.com/nshen/InsisVim/assets/181506/a639f05b-adab-4279-8482-e3088d2fae8f

<details>
<summary>Bufferline 配置</summary>
  
```lua
require("insis").setup({
  bufferLine = {
    enable = true,
    keys = {
      -- left / right cycle
      prev = "<C-h>",
      next = "<C-l>",
      -- close current buffer
      close = "<C-w>",
      -- close = "<leader>bc",
      -- close all left / right tabs
      close_left = "<leader>bh",
      close_right = "<leader>bl",
      -- close all other tabs
      close_others = "<leader>bo",
      close_pick = "<leader>bp",
    },
  },
})
```

</details>

#### Super Windows

和 VSCode 不同，Vim 中的 Window 只是显示 Buffer 的窗口，允许多个窗口同时显示甚至修改一个 Buffer，在 InsisVim 中可以非常简单的定义一系列窗口相关的快捷键，包括水平垂直分割，快速窗口之间跳转，关闭等，称为 Super windows。

<details>
<summary>Super Windows 配置</summary>
  
```lua
require("insis").setup({
  s_windows = {
    enable = true,
    keys = {
      split_vertically = "sv",
      split_horizontally = "sh",
      -- close current
      close = "sc",
      -- close others
      close_others = "so",
      -- jump between windows
      jump_left = { "<A-h>", "<leader>h" },
      jump_right = { "<A-l>", "<leader>l" },
      jump_up = { "<A-k>", "<leader>k" },
      jump_down = { "<A-j>", "<leader>j" },
      -- control windows size
      width_decrease = "s,",
      width_increase = "s.",
      height_decrease = "sj",
      height_increase = "sk",
      size_equal = "s=",
    },
  },
})
```

</details>

#### Super Tab

Vim 中的 Tab 是用来保存一个或多个 windows 组合，这样你就可以在不改变 windows 布局的情况下，切换到不同的 Tab， 用不同的 windows 布局来做不同的事。

在 InsisVim 中也可以快速的定义一组 tabs 相关的快捷键，称为 Super Tab

<details>
<summary>Super Tab 配置</summary>

注意 super tab 并不常用，所以默认是关闭的，需要手动启用

```lua
require("insis").setup({
  s_tab = {
    enable = true, -- 默认关闭
    keys = {
      split = "ts",
      prev = "th",
      next = "tl",
      first = "tj",
      last = "tk",
      close = "tc",
    },
  },
})
```

</details>

---

简单讲 Buffers & Windows & Tabs 三者的关系如下：

- buffer 是加载到内存的文件，我们用 bufferline 插件模拟类似 VSCode 的 Tab页 行为
- window 负责显示buffer，熟悉快速分割窗口，在不同窗口快速跳转的快捷键是提高开发效率的关键
- tab 负责组织 windows 布局，通常用不到，所以默认是关闭的

<img width="762" alt="image" src="https://github.com/nshen/InsisVim/assets/181506/fb10bd17-895a-4f67-9718-87e11eb538b3">

---

### 编程环境配置

例如 `Golang` 环境，设置 enable 后，`:wq` 保存重启会自动调用 Mason 安装对应的语法高亮 Language Server，Linter，Formatter 等。安装完毕后再次重启打开对应的 Golang 项目即可生效

```lua
require("insis").setup({
  colorscheme = "tokyonight"
  golang = {
    enable = true,
  },
})
```

开启其他语言相关的模块也都类似，修改 `~/.config/nvim/init.lua` 后保存重启，即可自动完成安装。

由于编程环境启用后需要额外安装LSP Linter Formatter 语法高亮等，所以默认情况下**编程环境配置**都是关闭的，需要手动开启，只有 `Lua` 是默认开启的，这是因为你会经常使用 `Lua` 语言来修改配置。而 **常用配置** 则大部分默认都是开启状态的。

> 完整默认参数列表在此 [config.lua](https://github.com/nshen/InsisVim/blob/main/lua/insis/config.lua)

## 常用编程环境配置

语言环境相关模块请逐个打开，否则重启后一次会安装很多服务，需要等待较长时间。

<details>
<summary>JSON 编辑</summary>
  
```lua
require("insis").setup({
  json = {
    enable = true,
    -- 以下为默认值，可以省略
    lsp = "jsonls",
    ---@type "jsonls" | "prettier"
    formatter = "jsonls",
    format_on_save = false,
    indent = 2,
   }
})
```

启用 `json` 功能，重启后

- 会自动安装 Treesitter 的 JSON 语法高亮。
- 自动安装并配置 [jsonls](https://github.com/microsoft/vscode-json-languageservice) Language Server

</details>

<details>
<summary>Markdown 编辑</summary>

Markdown 文件中可直接在 `[文字](路径)` 链接上按 `gf` 打开目标，按 `Ctrl+o` 返回。
相对路径以当前 Markdown 文件所在目录为基准；此功能无需启用下面的完整 Markdown 工具链。
  
```lua
require("insis").setup({
  markdown = {
    enable = true,
    -- 以下为默认值，可以省略
    mkdnflow = {
      next_link = "gn",
      prev_link = "gp",
      next_heading = "gj",
      prev_heading = "gk",
      -- 进入链接
      follow_link = "gd",
      -- 从链接返回
      go_back = "<C-o>",
      toggle_item = "tt",
    },
    formatter = "prettier",
    -- 保存时格式化默认为false
    format_on_save = false,
    -- 文字长度到达边缘默认自动折行
    wrap = true,
    ---:MarkdownPreview 命令打开文章预览默认是 dark 皮肤
    ---@type "dark" | "light"
    theme = "dark",
  },
})
```

启用 markdown 功能后，重启会自动安装 Treesitter 的 markdown 语法高亮，和 prettier 用于格式化。

增加 `:MarkdownPreview` 命令实时预览 markdown 文件

增加 `mkdnflow.nvim` 相关的快捷键

增加 markdown 相关快捷键例如 `5x5table`

</details>

<details>
<summary>前端开发</summary>
  
前端开发配置相对比较复杂，因为需要安装多个 LSP，多种文件的语法高亮等，重启后需要等待时间会较长

```lua
require("insis").setup({
  frontend = {
    enable = true,
    ---@type "eslint" | false
    linter = "eslint", -- :EslintFixAll command added
    ---@type false | "prettier" | "ts_ls"
    formatter = "ts_ls",
    format_on_save = false,
    indent = 4,
    cspell = false,
    tailwindcss = true,
    prisma = false,
    -- vue will take over typescript lsp
    vue = false,
  },
})
```

</details>

<details>
<summary>Solidity 开发</summary>
  
```lua
require("insis").setup({
  solidity = {
    enable = true,
    --linter 可以是 sohint 或 false
    linter = "solhint",
    format_on_save = true,
    indent = 4,
  },
})
```
当设置 `enable` 为 `true`  并重启后，将安装:

- TreeSitter 语法高亮：`solidity`
- Language Server: [nomicfoundation-solidity-language-server](https://github.com/NomicFoundation/hardhat-vscode/tree/development/server)
- 代码片段: [solidity snippets](https://github.com/rafamadriz/friendly-snippets/blob/main/snippets/solidity.json)
- 如果设置了linter，则自动下载 [sohint](https://github.com/protofire/solhint) 并启动

</details>

<details>
<summary>Golang开发</summary>
  
```lua
require("insis").setup({
  golang = {
    enable = true,
    -- 下边的都是默认值可以省略
    lsp = "gopls",
    linter = "golangci-lint",
    formatter = "gofmt",
    format_on_save = false,
    indent = 4,
  },
})
```
</details>

<details>
<summary>clangd开发</summary>
  
```lua
require("insis").setup({
  clangd = {
    enable = true,
    lsp = "clangd",
    -- linter = "clangd-tidy",
    formatter = "clang-format",
    format_on_save = false,
    indent = 4,
  },
})
```
</details>

<details>
<summary>Bash开发</summary>
  
```lua
require("insis").setup({
  bash = {
    enable = true,
    lsp = "bashls",
    --  brew install shfmt
    formatter = "shfmt",
    format_on_save = false,
    indent = 4,
  },
})
```
</details>

<details>
<summary>Python开发</summary>
  
```lua
require("insis").setup({
  python = {
    enable = true,
    -- can be pylsp or pyright
    lsp = "pylsp",
    -- pip install black
    -- asdf reshim python
    formatter = "black",
    format_on_save = false,
    indent = 4,
  },
})
```
</details>

<details>
<summary>Ruby开发</summary>
  
```lua
require("insis").setup({
  ruby = {
    enable = true,
    lsp = "ruby_ls",
    -- gem install rubocop
    formatter = "rubocop",
    format_on_save = false,
    indent = 2,
  },
})
```
</details>

<details>
<summary>Docker 开发</summary>
  
```lua
require("insis").setup({
  docker = {
    enable = true,
    lsp = "dockerls",
    indent = 2,
  },
})
```
</details>

## 日常使用

### 常用命令

- 更新插件:
  - `:Lazy restore` 更新所有插件到 `lazy-lock.json` 锁定的稳定版本
  - `:Lazy update` 更新所有插件到最新版本，不保证兼容性
- 查看报错信息:
  - `:Notifications`
  - `:messages`
- 查看/安装 LSP :
  - `:LspInfo` 查看运行状态
  - `:Mason` 安装更新等
- 更新语法高亮：
  - `:TSUpdate` 全部更新
  - `:TSUpdate <json>` 单独更新
- Markdown 预览：
  - `:MarkdownPreview`

### 代码折叠快捷键

| fold shortcuts | description     |
| -------------- | --------------- |
| zc             | close fold      |
| zo             | open fold       |
| za             | toggle fold     |
| zM             | close all folds |
| zR             | open all folds  |

更新中。。。

## 微信群

有问题扫码加我，注明 `vim` ，拉你进群，微信号：nshen121

<img src="./wechat.jpg" alt="image" width="300" height="auto">

## 项目结构

如何扩展

TODO

## Requirements

- Neovim v0.9.x.
- Nerd Fonts.

## License

MIT

WIP 🟡, PR is welcome.

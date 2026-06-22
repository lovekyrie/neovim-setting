# NvimTree Filters

> Related source: [lua/insis/plugins/nvim-tree.lua](../../../lua/insis/plugins/nvim-tree.lua)

## Meaning

NvimTree 的 `filters.custom`、`filters.dotfiles` 和
`filters.git_ignored` 是互相独立的过滤器。关闭或不配置 `custom`，
不会关闭 Git ignore 过滤。

`filters.exclude` 的含义是“从所有过滤规则中排除”，匹配的路径会始终显示，
并不是“额外隐藏这些路径”。

## In This Project

当前配置使用了旧选项 `git.ignore = true`。NvimTree 会将其迁移为：

```lua
filters = {
  git_ignored = true,
}
```

因此，只要前端项目的 `.gitignore` 包含 `node_modules` 或 `dist`，它们就不会
显示。当前按键 `i` 调用 `api.tree.toggle_gitignore_filter`，可以临时切换该
过滤器。

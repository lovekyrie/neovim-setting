vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_smartcase = 1

local opts = {
  remap = true,
  silent = true,
}

local modes = { "n", "x", "o" }

vim.keymap.set(modes, "<leader><leader>w", "<Plug>(easymotion-w)", opts)
vim.keymap.set(modes, "<leader><leader>e", "<Plug>(easymotion-e)", opts)
vim.keymap.set(modes, "<leader><leader>b", "<Plug>(easymotion-b)", opts)
vim.keymap.set(modes, "<leader><leader>ge", "<Plug>(easymotion-ge)", opts)
vim.keymap.set(modes, "<leader><leader>j", "<Plug>(easymotion-j)", opts)
vim.keymap.set(modes, "<leader><leader>k", "<Plug>(easymotion-k)", opts)
vim.keymap.set(modes, "<leader><leader>s", "<Plug>(easymotion-s2)", opts)

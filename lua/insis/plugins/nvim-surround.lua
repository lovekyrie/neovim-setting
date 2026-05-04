local surround = pRequire("nvim-surround")
local cfg = require("insis").config.surround

if not surround or not cfg or not cfg.enable then
  return
end

-- v4 起 setup 只接受 surrounds 等，不再接受 keymaps
surround.setup({})

local k = vim.tbl_deep_extend("force", {
  normal = "ys",
  normal_cur = "yss",
  delete = "ds",
  change = "cs",
  change_line = "cS",
  visual = "s",
  visual_line = "gs",
  insert = false,
  insert_line = false,
  normal_line = false,
  normal_cur_line = false,
}, cfg.keys or {})

local plug = {
  insert = "<Plug>(nvim-surround-insert)",
  insert_line = "<Plug>(nvim-surround-insert-line)",
  normal = "<Plug>(nvim-surround-normal)",
  normal_cur = "<Plug>(nvim-surround-normal-cur)",
  normal_line = "<Plug>(nvim-surround-normal-line)",
  normal_cur_line = "<Plug>(nvim-surround-normal-cur-line)",
  visual = "<Plug>(nvim-surround-visual)",
  visual_line = "<Plug>(nvim-surround-visual-line)",
  delete = "<Plug>(nvim-surround-delete)",
  change = "<Plug>(nvim-surround-change)",
  change_line = "<Plug>(nvim-surround-change-line)",
}

local base = { remap = true, silent = true }

local function n_expr(lhs, p, desc)
  if not lhs or lhs == false then
    return
  end
  vim.keymap.set("n", lhs, p, vim.tbl_extend("force", { desc = desc, expr = true }, base))
end

local function x_expr(lhs, p, desc)
  if not lhs or lhs == false then
    return
  end
  vim.keymap.set("x", lhs, p, vim.tbl_extend("force", { desc = desc, expr = true }, base))
end

local function i_map(lhs, p, desc)
  if not lhs or lhs == false then
    return
  end
  vim.keymap.set("i", lhs, p, vim.tbl_extend("force", { desc = desc }, base))
end

i_map(k.insert, plug.insert, "nvim-surround: insert")
i_map(k.insert_line, plug.insert_line, "nvim-surround: insert line")
n_expr(k.normal, plug.normal, "nvim-surround: normal")
n_expr(k.normal_cur, plug.normal_cur, "nvim-surround: normal cur")
n_expr(k.normal_line, plug.normal_line, "nvim-surround: normal line")
n_expr(k.normal_cur_line, plug.normal_cur_line, "nvim-surround: normal cur line")
n_expr(k.delete, plug.delete, "nvim-surround: delete")
n_expr(k.change, plug.change, "nvim-surround: change")
n_expr(k.change_line, plug.change_line, "nvim-surround: change line")
x_expr(k.visual, plug.visual, "nvim-surround: visual")
x_expr(k.visual_line, plug.visual_line, "nvim-surround: visual line")

-- Nvim 0.12：get_parser 可无报错返回 nil，旧版 is_treesitter_active 误判 → CursorHold 崩
local function patch()
  local ok, utils = pcall(require, "ts_context_commentstring.utils")
  if not ok or type(utils) ~= "table" then
    return
  end
  utils.is_treesitter_active = function(bufnr)
    bufnr = bufnr or 0
    local p_ok, parser = pcall(vim.treesitter.get_parser, bufnr)
    return p_ok and parser ~= nil
  end
end

return {
  apply = patch,
}

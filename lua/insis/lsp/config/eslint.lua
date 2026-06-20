local common = require("insis.lsp.common-config")
local cfg = require("insis").config.frontend

local customizations = {
  { rule = "style/*", severity = "off", fixable = true },
  { rule = "format/*", severity = "off", fixable = true },
  { rule = "*-indent", severity = "off", fixable = true },
  { rule = "*-spacing", severity = "off", fixable = true },
  { rule = "*-spaces", severity = "off", fixable = true },
  { rule = "*-order", severity = "off", fixable = true },
  { rule = "*-dangle", severity = "off", fixable = true },
  { rule = "*-newline", severity = "off", fixable = true },
  { rule = "*quotes", severity = "off", fixable = true },
  { rule = "*semi", severity = "off", fixable = true },
}

-- 等同于 VSCode 的 source.fixAll.eslint，同步等待结果以保证 BufWritePre 内可用
local function eslint_fix_all(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "eslint" })
  if #clients == 0 then
    return
  end
  local client = clients[1]
  local enc = client.offset_encoding or "utf-16"

  local params = vim.lsp.util.make_range_params(0, enc)
  params.context = {
    only = { "source.fixAll.eslint" },
    diagnostics = {},
  }

  local result = client:request_sync("textDocument/codeAction", params, 3000, bufnr)
  for _, action in ipairs((result or {}).result or {}) do
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit, enc)
    end
    if type(action.command) == "table" then
      client:request_sync("workspace/executeCommand", action.command, 3000, bufnr)
    end
  end
end

local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
    "html",
    "markdown",
    "json",
    "jsonc",
    "yaml",
    "toml",
    "xml",
    "gql",
    "graphql",
    "astro",
    "svelte",
    "css",
    "less",
    "scss",
    "pcss",
    "postcss",
  },
  settings = {
    format = true,
    rulesCustomizations = customizations,
    codeActionOnSave = {
      enable = true,
      mode = "all",
    },
  },
  on_attach = function(client, bufnr)
    if cfg.formatter ~= "eslint" then
      common.disableFormat(client)
    end
    common.keyAttach(bufnr)

    vim.api.nvim_buf_create_user_command(bufnr, "LspEslintFixAll", function()
      eslint_fix_all(bufnr)
    end, {})

    if cfg.format_on_save and cfg.formatter == "eslint" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          if vim.bo[bufnr].buftype ~= "" or not vim.bo[bufnr].modifiable then
            return
          end
          eslint_fix_all(bufnr)
        end,
      })
    end
  end,
}

return {
  on_setup = function()
    vim.lsp.config("eslint", opts)
    vim.lsp.enable("eslint")
  end,
}

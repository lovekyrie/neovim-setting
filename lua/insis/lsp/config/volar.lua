local cfg = require("insis").config.frontend
local common = require("insis.lsp.common-config")

return {
  on_setup = function(server_name)
    local vue_package_path = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server"
    local filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }

    -- Vue 3.x uses a TypeScript server with the Vue plugin instead of Take Over Mode.
    vim.lsp.config("ts_ls", {
      filetypes = filetypes,
      capabilities = common.capabilities,
      flags = common.flags,
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = vue_package_path .. "/node_modules/@vue/language-server",
            languages = { "vue" },
            configNamespace = "typescript",
          },
        },
      },
      on_attach = function(client, bufnr)
        if cfg.formatter ~= "ts_ls" then
          common.disableFormat(client)
        end
        common.keyAttach(bufnr)
        if cfg.inlay_hint then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
      end,
    })
    vim.lsp.config(server_name, {
      capabilities = common.capabilities,
      flags = common.flags,
      on_attach = function(client, bufnr)
        if cfg.formatter ~= "vue_ls" then
          common.disableFormat(client)
        end
        common.keyAttach(bufnr)
      end,
    })
    vim.lsp.enable({ "ts_ls", server_name })
  end,
}

local common = require("insis.lsp.common-config")
local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  init_options = {
    extendedClientCapabilities = { classFileContentsSupport = true },
  },

  on_attach = function(_, bufnr)
    common.keyAttach(bufnr)
  end,
}

local server_runtime = vim.fn.stdpath("data") .. "/jdtls-runtime/Contents/Home"
if vim.fn.executable(server_runtime .. "/bin/java") == 1 then
  opts.cmd_env = { JAVA_HOME = server_runtime }
  local project_jdk = vim.fn.expand("~/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home")
  if vim.fn.executable(project_jdk .. "/bin/javac") == 1 then
    opts.settings = {
      java = { configuration = { runtimes = { { name = "JavaSE-21", path = project_jdk, default = true } } } },
    }
  end
end

return {
  on_setup = function(name)
    vim.lsp.config(name, opts)
    vim.lsp.enable(name)
  end,
}


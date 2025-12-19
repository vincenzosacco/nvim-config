local nvchad_cfg = require "nvchad.configs.lspconfig"
nvchad_cfg.defaults()

-- 1. Standard servers managed by Mason
local servers = {
  "html",
  "cssls",
  "clangd",
  "pyright",
}

-- Use the new native enable function for standard servers
-- This automatically applies NvChad defaults if you pass them as the second argument
vim.lsp.enable(servers, {
  on_attach = nvchad_cfg.on_attach,
  on_init = nvchad_cfg.on_init,
  capabilities = nvchad_cfg.capabilities,
})

--==================================== WINDOWS ====================================
-- 2. Manual Setup for Dartls
vim.lsp.config("dartls", {
  cmd = { "dart", "language-server", "--protocol=lsp" },
  filetypes = { "dart" },
  init_options = {
    closingLabels = true,
    flutterOutline = true,
    onlyAnalyzeProjectsWithOpenFiles = true,
    outline = true,
    suggestFromUnimportedLibraries = true,
  },
  -- Apply NvChad's shared logic
  on_attach = nvchad_cfg.on_attach,
  on_init = nvchad_cfg.on_init,
  capabilities = nvchad_cfg.capabilities,
})

-- Finally, enable the manual config
vim.lsp.enable "dartls"

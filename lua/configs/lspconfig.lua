local nvchad_cfg = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

-- nvchad_cfg.defaults() // dont know if needed

-- 1. Standard servers managed by Mason
local servers = {
  "html",
  "cssls",
  "clangd",
  "pyright",
}

-- Use the new native enable function for standard servers
-- This automatically applies NvChad defaults if you pass them as the second argument
-- vim.lsp.enable(servers, {
--   on_attach = nvchad_cfg.on_attach,
--   on_init = nvchad_cfg.on_init,
--   capabilities = nvchad_cfg.capabilities,
-- })

for _, lsp in ipairs(servers) do
  -- require lspconfig is deprecated for this version (0.11.5), use vim.lsp.config  
  vim.lsp.config(lsp, {
    -- Apply NvChad's shared logic
    on_attach = nvchad_cfg.on_attach,
    on_init = nvchad_cfg.on_init,
    capabilities = nvchad_cfg.capabilities,
  })
end

--==================================== WINDOWS ====================================
if vim.fn.has "win32" == 1 then
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

  vim.lsp.enable "dartls"
end

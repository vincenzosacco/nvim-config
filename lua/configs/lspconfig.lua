nvchad_cfg = require "nvchad.configs.lspconfig"
nvchad_cfg.defaults()
-- read :h vim.lsp.config for changing options of lsp servers

local servers = {
  "html",
  "cssls",
  "clangd",
  "pyright",
  "dartls", -- Manually
}
--- Configure servers
-- local servers = {
--   -- C/C++ LSP
--   clangd = {
--     cmd = { "clangd", "--background-index", "--clang-tidy" }, -- optional flags
--     filetypes = { "c", "cpp", "objc", "objcpp" },
--     root_dir = lsp_util.root_pattern("compile_commands.json", ".git"), -- auto-detect root
--     init_options = {
--       clangdFileStatus = true, -- optional: shows file status in the statusline
--     },
--},
-- }

--=================================== Manual Setup (for LSPs oustide mason)
-- "cmd" fields assumes executables are in PATH

-- Setup Dart (Manually)
servers.dartls.setup {
  on_attach = nvchad_cfg.on_attach,
  on_init = nvchad_cfg.on_init,
  capabilities = nvchad_cfg.capabilities,
  -- assume dart is in PATHs
  cmd = { "dart", "language-server", "--protocol=lsp" },
  filetypes = { "dart" },
  init_options = {
    closingLabels = true,
    flutterOutline = true,
    onlyAnalyzeProjectsWithOpenFiles = true,
    outline = true,
    suggestFromUnimportedLibraries = true,
  },
}

vim.lsp.enable(servers)

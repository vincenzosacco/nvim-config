local nvchad_cfg = require "nvchad.configs.lspconfig"

-- nvchad_cfg.defaults() // dont know if needed

-- 1. Define exactly what each server needs (cmd and filetypes)
local servers = {
  html = {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html" },
  },
  cssls = {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
  },
  pyright = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
  },
  clangd = {
    cmd = { "clangd", "--background-index", "--clang-tidy", "--fallback-style=llvm" },
    filetypes = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
    -- For C++, it's highly recommended to tell it how to find the root folder
    root_dir = vim.fs.root(0, { "compile_commands.json", "compile_flags.txt", ".git" }),
  },
}

-- 2. Loop through the table to configure AND enable them natively
for lsp_name, config in pairs(servers) do
  -- Inject NvChad's shared logic into each specific config
  config.on_attach = nvchad_cfg.on_attach
  config.on_init = nvchad_cfg.on_init
  config.capabilities = nvchad_cfg.capabilities

  -- Step A: Save the configuration to Neovim
  vim.lsp.config(lsp_name, config)

  -- Step B: Actually turn the server ON
  vim.lsp.enable(lsp_name)
end

-- Diagnostic configuration (e.g. lsp warnings, errors,  signs)
vim.diagnostic.config {

  -- require neovim >= 0.11.0 for virtual_lines
  virtual_text = false, -- Turn off the text that gets cut off
  virtual_lines = { current_line = true }, -- Show full message under the cursor line

  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
}

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

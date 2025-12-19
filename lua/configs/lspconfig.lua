require("nvchad.configs.lspconfig").defaults()
-- read :h vim.lsp.config for changing options of lsp servers

local servers = {
  "html",
  "cssls",
  "clangd",
  "pyright",
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
vim.lsp.enable(servers)

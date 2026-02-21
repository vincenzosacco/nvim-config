vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

--=============================== WINDOWS SPECIFIC CONFIGS ===============================--
if vim.fn.has "win32" == 1 then
  -- Prefer modern PowerShell (pwsh) if available, fallback to Windows PowerShell
  local shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell"
  vim.opt.shell = shell

  -- Force UTF-8 encoding for the session
  vim.opt.shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"

  -- Use UTF8 to prevent data loss.
  -- MUST include `exit $LastExitCode` so Neovim catches command failures (e.g., for `:make`).
  vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"

  -- Required for PowerShell to work smoothly with Neovim
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end

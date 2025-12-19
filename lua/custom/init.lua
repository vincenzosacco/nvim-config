--========================== Init all custom features

local M = {}

-- Load your ASP syntax module
local asp_syntax = require "custom.syntax.asp"

-- Helper function to reload and apply custom theme highlights
local function apply_custom_highlights()
  -- 1. Clear cache to ensure logic is re-run (e.g. recalculating light vs dark)
  package.loaded["custom.theme"] = nil

  -- 2. Safely require the theme
  local status, theme = pcall(require, "custom.theme")
  if not status then
    print("Error loading custom.theme: " .. theme)
    return
  end

  -- 3. Get highlights based on current background/theme
  local highlights = theme.get_highlights()

  -- 4. Apply them globally (namespace 0)
  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

--============================= Main func ===============================================
M.setup = function()
  -- Create a group to manage autocommands (prevents duplication on reload)
  local group = vim.api.nvim_create_augroup("CustomUserSetup", { clear = true })

  -- =========================================
  -- 1. ASP Configuration (Your existing code)
  -- =========================================
  vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = group,
    pattern = { "*.asp2" }, --not 'asp' to avoid conficts with Active Server Pages 
    callback = function()
      vim.cmd "set filetype=asp"
      asp_syntax.apply_syntax()
    end,
  })

  -- =========================================
  -- 2. Dynamic Theme Configuration
  -- =========================================

  -- Event: When you toggle background (:set background=light/dark)
  vim.api.nvim_create_autocmd("OptionSet", {
    group = group,
    pattern = "background",
    callback = apply_custom_highlights,
  })

  -- Event: When NvChad changes the base theme
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = apply_custom_highlights,
  })

  -- Apply highlights immediately on startup
  apply_custom_highlights()
end

return M

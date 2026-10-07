-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "darcula-dark",
  transparency = false,
  -- static theme override ( works only on startup)
  hl_override = require("custom.theme").get_highlights(),
}

-- Load Custom config
local customInit = require "custom.init"
customInit.setup() -- this load also the 'switch theme event'

M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

--============== TERMINALS

M.term = {
  winopts = { winfixbuf = true }, -- Locks terminal buffer to window
  sizes = { sp = 0.3, vsp = 0.2 }, -- Default sizes for splits
  float = {
    relative = "editor",
    row = 0.1,
    col = 0.045,
    width = 0.9,
    height = 0.8,
    border = "single",
  },
}
return M

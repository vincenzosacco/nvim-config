-- File: lua/configs/nvterm.lua
local M = {}

M.setup_opts = function(_, opts)
  opts = opts or {}

  -- Keep the default window type, just change the size percentages
  opts.terminals = {
    type_opts = {
      float = {
        width = 0.90, -- Sets the width to 90% of your screen
        height = 0.85, -- Sets the height to 85% of your screen
      },
    },
  }

  return opts
end

return M

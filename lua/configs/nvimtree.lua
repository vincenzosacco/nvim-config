local M = {}

M.setup = function(_, opts)
  -- 1. Ensure opts is a valid table
  opts = opts or {}

  -- 2. Add your custom filters
  opts.filters = {
    dotfiles = false,
    git_ignored = false,
  }

  -- 3. Add your refresh fix from earlier
  opts.filesystem_watchers = {
    enable = true,
  }

  -- 4. Pass the merged options back to NvChad
  return opts
end

return M

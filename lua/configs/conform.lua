local home_path = vim.fn.expand "~"

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    python = {
      "isort", -- Runs first to sort imports
      "black", -- Runs second to apply standard formatting
    },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  -- Specify how to call formatters
  formatters = {
    clang_format = {
      command = "clang-format",
      args = { "-style=file:" .. home_path .. "/.clang-format" },
    },
  },

  format_on_save = {
    --   -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options

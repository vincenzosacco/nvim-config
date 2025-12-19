return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require "configs.treesitter"
    end,
  },

  ---- AI MODEL ----
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      -- Disable default <Tab> mapping if you want to map it manually
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap("i", "<S-Right>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
  },
}

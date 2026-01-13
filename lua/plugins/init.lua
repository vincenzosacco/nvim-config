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
    lazy = false,
    config = function()
      require "configs.treesitter"
    end,
  },

  ---- GIT ----
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- keys are set in mappings.lua
    config = function()
      require "configs.lazygit"
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

  ---- Markdown Preview ----
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    -- CHANGE THIS LINE BELOW:
    -- We add 'git restore .' to undo the changes to yarn.lock after installation
    build = "cd app && npm install && git restore .",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      -- Don't close the preview when switching buffers
      vim.g.mkdp_auto_close = 0
      -- Reuse the same browser tab for all markdown files
      vim.g.mkdp_combine_preview = 1
    end,
  },
}

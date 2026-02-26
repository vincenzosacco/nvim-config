return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- format on save
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
  ---- DAP (Debug Adapter Protocol) for debugging
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- Optional: Config here
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    config = function()
      require("configs.nvim-dap-python").setup()
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

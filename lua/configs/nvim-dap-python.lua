local M = {}

M.setup = function()
  local dap = require "dap"
  local dapui = require "dapui"
  local dap_python = require "dap-python"

  -- 1. BREAKPOINT SYMBOLS & COLORS
  local signs = {
    DapBreakpoint = { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" },
    DapBreakpointCondition = { text = "", texthl = "DapBreakpointCondition", linehl = "", numhl = "" },
    DapLogPoint = { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" },
    DapStopped = { text = "󰁕", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "DapStoppedLine" },
  }

  for name, opts in pairs(signs) do
    vim.fn.sign_define(name, opts)
  end

  -- Define Highlight Colors
  vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#F44336" })
  vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#2e3b30", fg = "#98c379" })

  -- 2. PYTHON SETUP (Mason Path)
  local path = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python"
  if vim.fn.executable(path) == 1 then
    dap_python.setup(path)
  else
    dap_python.setup "python3"
  end

  -- 3. PYTHON MODULE DEBUG CONFIG
  dap.configurations.python = {
    {
      type = "python",
      request = "launch",
      name = "Debug current file",
      program = "${file}",
      justMyCode = false,
    },
    {
      type = "python",
      request = "launch",
      name = "Debug Python module",

      module = function()
        return vim.fn.input "Module name: "
      end,

      args = function()
        return vim.split(vim.fn.input "Arguments: ", " ")
      end,

      justMyCode = false,
    },
  }

  -- 4. UI AUTOMATION (Open/Close on debug)
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end
end

return M

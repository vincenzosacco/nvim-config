require "nvchad.mappings"

local setMap = vim.keymap.set
local delMap = vim.keymap.del
local is_windows = vim.fn.has "win32" == 1

setMap("n", ";", ":", { desc = "CMD enter command mode" })
setMap("i", "jk", "<ESC>")
setMap({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
setMap({ "n", "i", "v" }, "<C-a>", "gg0vG$")

--Make
if is_windows then
  vim.opt.makeprg = "mingw32-make" -- Win binary for make, ensure it's in your PATH
end

-- 3. Map <leader>m to the native :make command
setMap("n", "m", ":make<cr>", { desc = "run makefile" })
--========================= PLUGINS =========================--
---- Terminal mode

-- ovveride nvcahd
delMap("t", "<C-x>") --delete previus map for exiting( conflict key, e.g. Nano editor when using git)
setMap("t", "<ESC><ESC>", "<C-\\><C-N>") -- should have no conflict

---- LazyGit
setMap("n", "<leader>gg", "<cmd> LazyGit <cr>", { desc = "Open LazyGit" })

---- LSP mappings
-- Shortcut: <Leader> + ai (Auto Import)
setMap("n", "<leader>ai", function()
  vim.lsp.buf.code_action {
    apply = true, -- Attempt to apply automatically
    context = {
      diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
      only = { "quickfix" }, -- Focus on fixes (imports are usually here)
    },
  }
end, { desc = "Auto Import / Quick Fix" })

setMap("n", "<leader>oi", function()
  vim.lsp.buf.code_action {
    apply = true,
    context = {
      only = { "source.organizeImports" },
      diagnostics = {},
    },
  }
end, { desc = "Organize Imports" })

---- Debugger

setMap("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
setMap("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Run or continue debugger" })
setMap("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "Toggle Debugger UI" })

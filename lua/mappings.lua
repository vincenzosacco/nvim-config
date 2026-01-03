require "nvchad.mappings"

local setMap = vim.keymap.set
local delMap = vim.keymap.del

setMap("n", ";", ":", { desc = "CMD enter command mode" })
setMap("i", "jk", "<ESC>")
setMap("n", "m", ":make<cr>", { desc = "run makefile" })
setMap({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
setMap({ "n", "i", "v" }, "<C-a>", "gg0vG$")

-- LSP mappings
-- Shortcut: <Leader> + ai (Auto Import)
setMap("n", "<leader>ai", function()
  vim.lsp.buf.code_action({
    apply = true,           -- Attempt to apply automatically
    context = {
      diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
      only = { "quickfix" } -- Focus on fixes (imports are usually here)
    }
  })
end, { desc = "Auto Import / Quick Fix" })

setMap("n", "<leader>oi", function()
  vim.lsp.buf.code_action({
    apply = true,
    context = {
      only = { "source.organizeImports" },
      diagnostics = {},
    },
  })
end, { desc = "Organize Imports" })

--===== Terminal mode

-- ovveride nvcahd
delMap("t", "<C-x>") --delete previus map ( conflict key, e.g. Nano editor when using git)
setMap("t", "<ESC>", "<C-\\><C-N>")

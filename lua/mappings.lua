require "nvchad.mappings"

local setMap = vim.keymap.set
local delMap = vim.keymap.del
local is_windows = vim.fn.has "win32" == 1

setMap("n", ";", ":", { desc = "CMD enter command mode" })
setMap("i", "jk", "<ESC>")
setMap({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
setMap({ "n", "i", "v" }, "<C-a>", "gg0vG$")

--Make
local function get_best_makeprg()
  -- 1. Definiamo i nomi dei file che vogliamo cercare
  local win_makefile = "windows.mk"
  local linux_makefile = "linux.mk"

  if is_windows then
    vim.opt.shellpipe = ">%s 2>&1"
    -- Try Windows-specific Makefile first
    if vim.fn.filereadable(win_makefile) == 1 then
      return "mingw32-make -f " .. win_makefile
    else
      return "mingw32-make" -- default mingw32-make search for "GNUmakefile", "makefile" or "Makefile"
    end
  else -- Linux
    -- Try Linux-specific Makefile first
    if vim.fn.filereadable(linux_makefile) == 1 then
      return "make -f " .. linux_makefile
    else
      return "make" -- default make search for "GNUmakefile", "makefile" or "Makefile"
    end
  end
end

-- Applichiamo la configurazione
vim.opt.makeprg = get_best_makeprg()

-- 3. Map <leader>m to the native :make command
setMap("n", "m", ":make<cr>", { desc = "run makefile" })
--========================= PLUGINS =========================--
---- Terminal mode

-- ovveride nvcahd
delMap("t", "<C-x>") --delete previus map ( conflict key, e.g. Nano editor when using git)
setMap("t", "<ESC>", "<C-\\><C-N>")

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

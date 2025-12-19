require "nvchad.options"

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

local opt = vim.opt
--===================================== [[ Spacing/Indentation ]]

-- Imposta la larghezza della tabulazione a 4 spazi
opt.tabstop = 4

-- Imposta la larghezza dell'indentazione a 4 spazi
opt.shiftwidth = 4

-- Sostituisce i caratteri di tabulazione veri e propri con spazi
opt.expandtab = true

-- L'indentazione funziona meglio con queste opzioni attivate
opt.autoindent = true
opt.smartindent = true

--===================================== WSL clipboard sharing 
vim.g.clipboard = {
  name = 'WslClipboard',
  copy = {
    ['+'] = 'clip.exe',
    ['*'] = 'clip.exe',
  },
  paste = {
    -- powershell is too slow, im using https://github.com/equalsraf/win32yank/tree/master 
    ['+'] = 'win32yank.exe -o --lf',
    ['*'] = 'win32yank.exe -o --lf',
  },
  cache_enabled = 0,
}



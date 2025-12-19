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

--===================================== [[ Clipboard ]]

-- Sync clipboard between OS and Neovim.
-- On native OS, this allows you to Ctrl+V / Ctrl+C outside neovim
-- and use 'p' / 'y' inside neovim seamlessly.
opt.clipboard = "unnamedplus"
